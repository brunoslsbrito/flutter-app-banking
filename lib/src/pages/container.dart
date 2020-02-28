import 'package:barcode_scan/barcode_scan.dart';
import 'package:flexpay/src/component/customDialog.dart';
import 'package:flexpay/src/model/bancoRendimento/responseBillInfo.dart';
import 'package:flexpay/src/service/bancoRendimentoService.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ContainerPage extends StatefulWidget {
  ContainerPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ContainerPageState createState() => _ContainerPageState();
}

class _ContainerPageState extends State<ContainerPage> {
  String barcode = "";
  ResponseBillInfo resp;


  Widget _title() {
    return Image.asset('assets/images/logo.png');
  }

  // Method for scanning barcode....
  Future<ResponseBillInfo> barcodeScanning() async {
    try {
      String barcode = await BarcodeScanner.scan();
      setState(() => this.barcode = barcode);
      var bancoRendimentoService = new BancoRendimentoService();
       bancoRendimentoService
          .loadBillInfos(barcode)
          .then((value) => resp = value)
          .catchError((error) => showDialog(
        context: context,
        builder: (BuildContext context) => CustomDialog(
          title: "",
          description: "Ocorreu um problema ao tentar ler o boleto",
          buttonText: "Fechar",
        ),
      ));
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          this.barcode = 'No camera permission!';
        });
      } else {
        setState(() => this.barcode = 'Unknown error: $e');
      }
    } on FormatException {
      setState(() => this.barcode = 'Nothing captured.');
    } catch (e) {
      setState(() => this.barcode = 'Unknown error: $e');
    }
  }

  _cardBarcode() {
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
//          new Text("Motivo : " + resp?.value?.motivo),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff0f3666),
      ),
      body: Center(
          child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[Expanded(child: _cardBarcode())],
      )),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: _title(),
              decoration: BoxDecoration(
                color: Colors.white,
              ),
            ),
            ListTile(
              title: Text('Bruno Brito',
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0)),
              subtitle: Text('bruno.brito@flexpag.com'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Item 1'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title:
                  Text('Sair', style: TextStyle(fontWeight: FontWeight.bold)),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
