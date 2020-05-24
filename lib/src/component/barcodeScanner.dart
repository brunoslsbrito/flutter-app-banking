import 'package:FlexPay/src/model/bancoRendimento/responseBillInfo.dart';
import 'package:FlexPay/src/service/bancoRendimentoService.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'customDialog.dart';

class BarcodeComponent extends StatefulWidget {
  // Method for scanning barcode....
  @override
  _BarcodeComponentState createState() => _BarcodeComponentState();
}

class _BarcodeComponentState extends State<BarcodeComponent> {
  String barcode = "";

  Future<ResponseBillInfo> barcodeScanning() async {
    try {
      String barcode = await BarcodeScanner.scan();
      setState(() => this.barcode = barcode);
      var bancoRendimentoService = new BancoRendimentoService();
      bancoRendimentoService
          .loadBillInfos(barcode)
          .then((value) => _bill(value))
          .catchError((error) => showDialog(
        context: context,
        builder: (BuildContext context) => CustomDialog(
          title: "",
          description: "Ocorreu um problema ao tentar ler o boleto",
          buttonText: "Fechar",
        ),
      ));
    } on FormatException {
      setState(() => this.barcode = 'Nothing captured.');
    } catch (e) {
      setState(() => this.barcode = 'Unknown error: $e');
    }
  }

  _bill(billInfo) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.info, size: 20),
            title: Text('Boleto'),
            onTap: barcodeScanning,
          ),
          new Text("Cedente: " + billInfo.value.nomeBeneficiario),
          new Text("Còdigo de Barras: " + billInfo.value.codigoDeBarras),
          new Text("Valor Total: " + billInfo.value.valorTotal.toString()),
          new Text("Data de Vencimento: " +
              billInfo.value.dataVencimento.toString()),
          new Text("Pagador: " + billInfo.value.nomePagador),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.add_a_photo, size: 50),
            title: Text(''),
            onTap: barcodeScanning,
            subtitle: Text('Pagamento com Código de Barras'),
          ),
          new Text("Barcode Number after Scan : " + barcode),
//         _billsInfo(),
        ],
      ),
    );
    ;
  }
}
