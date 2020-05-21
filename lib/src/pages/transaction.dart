import 'package:FlexPay/src/model/dto/gateway/paymentDTO.dart';
import 'package:FlexPay/src/service/gatewayService.dart';
import 'package:FlexPay/src/util/consts.dart';
import 'package:data_tables/data_tables.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money2/money2.dart';

void main() => runApp(Transaction());

class Transaction extends StatefulWidget {
  @override
  _TransactionState createState() => _TransactionState();
}

class _TransactionState extends State<Transaction> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  int _sortColumnIndex;
  bool _sortAscending = true;
  final GatewayService gatewayService = new GatewayService();

  @override
  void initState() {
    fetchTransactions();
    super.initState();
  }

  fetchTransactions() {
    gatewayService.fetchPayment().then((value) {
      setState(() {
        _merchant = value.merchant;
        _transactions = value.payments;
      });
    });
  }

  void _sort<T>(
      Comparable<T> getField(PaymentDTO d), int columnIndex, bool ascending) {
    _transactions.sort((PaymentDTO a, PaymentDTO b) {
      if (!ascending) {
        final PaymentDTO c = a;
        a = b;
        b = c;
      }
      final Comparable<T> aValue = getField(a);
      final Comparable<T> bValue = getField(b);
      return Comparable.compare(aValue, bValue);
    });
    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAscending = ascending;
    });
  }

  String _merchant = "";
  List<PaymentDTO> _transactions = [];
  int _rowsOffset = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
//       theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Transações '),
          backgroundColor: Color(Consts.PRIMARY_BLUE_COLOR),
        ),
        body: NativeDataTable.builder(
          rowsPerPage: _rowsPerPage,
          itemCount: _transactions?.length ?? 0,
          firstRowIndex: _rowsOffset,
          handleNext: () async {
            setState(() {
              _rowsOffset += _rowsPerPage;
            });

            await new Future.delayed(new Duration(seconds: 3));
            setState(() {
              fetchTransactions();
            });
          },
          handlePrevious: () {
            setState(() {
              _rowsOffset -= _rowsPerPage;
            });
          },
          itemBuilder: (int index) {
            final PaymentDTO transactionModel = _transactions[index];
            return DataRow.byIndex(
                index: index,
                selected: false,
                cells: <DataCell>[
                  DataCell(Row(
                    children: <Widget>[
                      transactionModel.status == 2
                          ? Icon(Feather.check, color: Colors.green)
                          : Icon(Feather.x_circle, color: Colors.red),
                      Padding(
                        padding: EdgeInsets.only(left: 16.0),
                        child: Text('${transactionModel.uid.substring(0,6)}',
                            style: GoogleFonts.lato().copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 16)),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 16.0),
                        child: Text(mountAmount(transactionModel.amount),
                            style: GoogleFonts.lato().copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 16)),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10.0),
                        child: Text('$_merchant ',
                            style: GoogleFonts.lato().copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 16)),
                      ),
                      Padding(
                          padding: EdgeInsets.only(left: 16.0),
                          child: getBrand(transactionModel.cardId)),
                    ],
                  )),
                  DataCell(Text('${_merchant}')),
                  DataCell(Text('${transactionModel.uid}')),
                  DataCell(Text(mountAmount(transactionModel.amount))),
                  DataCell(Text('${transactionModel.installments}x')),
                  DataCell(Text('${transactionModel.cardHolder}')),
                  DataCell(Text('${transactionModel.cardNumber}')),
                  DataCell(Text('${transactionModel.nsuCode}')),
                  DataCell(Text('${transactionModel.authorizationCode}')),
                ]);
          },
          header: const Text('Data Management'),
          sortColumnIndex: _sortColumnIndex,
          sortAscending: _sortAscending,
          onRefresh: () async {
            await new Future.delayed(new Duration(seconds: 3));
            setState(() {
              fetchTransactions();
            });
            return null;
          },
          onRowsPerPageChanged: (int value) {
            setState(() {
              _rowsPerPage = value;
            });
            print("New Rows: $value");
          },
          onSelectAll: (bool value) {
            for (var row in _transactions) {
              setState(() {
                row.selected = value;
              });
            }
          },
          rowCountApproximate: true,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.info_outline),
              onPressed: () {},
            ),
          ],
          selectedActions: <Widget>[
            IconButton(
              icon: Icon(Icons.file_download),
              onPressed: () {
                setState(() {
                  for (var item in _transactions
                      ?.where((d) => d?.selected ?? false)
                      ?.toSet()
                      ?.toList()) {
                    _transactions.remove(item);
                  }
                });
              },
            ),
          ],
          columns: <DataColumn>[
            DataColumn(label: const Text(''), numeric: false),
            DataColumn(
                label: const Text('Associado')),
            DataColumn(
                label: const Text('Identificador'),
                tooltip: 'Indentificador do pagamento no Gateway V2',
                numeric: false,
                onSort: (int columnIndex, bool ascending) => _sort<String>(
                    (PaymentDTO d) => d.uid, columnIndex, ascending)),
            DataColumn(
                label: const Text('Valor'),
                numeric: true,
                onSort: (int columnIndex, bool ascending) => _sort<num>(
                    (PaymentDTO d) => d.amount * 100, columnIndex, ascending)),
            DataColumn(
                label: const Text('Parcelas'),
                numeric: true,
                onSort: (int columnIndex, bool ascending) => _sort<num>(
                    (PaymentDTO d) => d.installments, columnIndex, ascending)),
            DataColumn(
                label: const Text('Portador do Cartão'),
                numeric: false,
                onSort: (int columnIndex, bool ascending) => _sort<String>(
                    (PaymentDTO d) => d.cardHolder, columnIndex, ascending)),
            DataColumn(
                label: const Text('Número do Cartão'),
                numeric: true,
                onSort: (int columnIndex, bool ascending) => _sort<num>(
                    (PaymentDTO d) => d.cardId, columnIndex, ascending)),
            DataColumn(
                label: const Text('NSU'),
                tooltip: 'NSU da transação',
                numeric: false,
                onSort: (int columnIndex, bool ascending) => _sort<String>(
                    (PaymentDTO d) => d.nsuCode, columnIndex, ascending)),
            DataColumn(
                label: const Text('Cód. Autorização'),
                numeric: false,
                onSort: (int columnIndex, bool ascending) => _sort<String>(
                    (PaymentDTO d) => d.authorizationCode,
                    columnIndex,
                    ascending)),
          ],
        ),
      ),
    );
  }

  getBrand(brand) {
    switch (brand) {
      case 1:
        return Image.asset('assets/images/visa.png');
      case 2:
        return Image.asset('assets/images/visa.png');
      case 3:
        return Image.asset('assets/images/mastercard.png');
      case 8:
        return Image.asset('assets/images/amex.png');
    }
  }

  String mountAmount(int amount) {
    var real = Currency.create('BRL', 2, symbol: 'R\$');
    return Money.fromInt(amount, real).toString();
  }
}
