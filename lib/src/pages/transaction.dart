import 'package:FlexPay/src/model/transactionModel.dart';
import 'package:FlexPay/src/service/gatewayService.dart';
import 'package:FlexPay/src/util/consts.dart';
import 'package:data_tables/data_tables.dart';
import 'package:flutter/material.dart';

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

  void fetchTransactions() {
    gatewayService.fetchPayment().then((value) {
      setState(() {
        _transactions = value;
      });
    });
  }

  void _sort<T>(Comparable<T> getField(TransactionModel d), int columnIndex,
      bool ascending) {
    _transactions.sort((TransactionModel a, TransactionModel b) {
      if (!ascending) {
        final TransactionModel c = a;
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

  List<TransactionModel> _transactions = [];
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
            final TransactionModel transactionModel = _transactions[index];
            return DataRow.byIndex(
                index: index,
                selected: transactionModel.selected,
                onSelectChanged: (bool value) {
                  if (transactionModel.selected != value) {
                    setState(() {
                      transactionModel.selected = value;
                    });
                  }
                },
                cells: <DataCell>[
                  DataCell(Text('${transactionModel.uid}')),
                  DataCell(Text('${transactionModel.amount}')),
                  DataCell(Text('${transactionModel.installments}')),
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
          // mobileItemBuilder: (BuildContext context, int index) {
          //   final i = _desserts[index];
          //   return ListTile(
          //     title: Text(i?.name),
          //   );
          // },
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
              icon: Icon(Icons.delete),
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
            DataColumn(
                label: const Text('Identificador'),
                tooltip: 'Indentificador do pagamento no Gateway V2',
                numeric: false,
                onSort: (int columnIndex, bool ascending) => _sort<String>(
                    (TransactionModel d) => d.uid, columnIndex, ascending)),
            DataColumn(
                label: const Text('Valor'),
                numeric: true,
                onSort: (int columnIndex, bool ascending) => _sort<num>(
                    (TransactionModel d) => d.amount * 100, columnIndex, ascending)),
            DataColumn(
                label: const Text('Parcelas'),
                numeric: true,
                onSort: (int columnIndex, bool ascending) => _sort<num>(
                    (TransactionModel d) => d.installments,
                    columnIndex,
                    ascending)),
            DataColumn(
                label: const Text('Portador'),
                numeric: false,
                onSort: (int columnIndex, bool ascending) => _sort<String>(
                    (TransactionModel d) => d.cardHolder,
                    columnIndex,
                    ascending)),
            DataColumn(
                label: const Text('Cartão'),
                numeric: false,
                onSort: (int columnIndex, bool ascending) => _sort<String>(
                    (TransactionModel d) => d.cardNumber,
                    columnIndex,
                    ascending)),
            DataColumn(
                label: const Text('NSU'),
                tooltip: 'NSU da transação',
                numeric: false,
                onSort: (int columnIndex, bool ascending) => _sort<String>(
                    (TransactionModel d) => d.nsuCode, columnIndex, ascending)),
            DataColumn(
                label: const Text('Cód. Autorização'),
                numeric: false,
                onSort: (int columnIndex, bool ascending) => _sort<String>(
                    (TransactionModel d) => d.authorizationCode,
                    columnIndex,
                    ascending)),
          ],
        ),
      ),
    );
  }
}
