import 'dart:async';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:FlexPay/src/component/customDialog.dart';
import 'package:FlexPay/src/model/bancoRendimento/responseBillInfo.dart';
import 'package:FlexPay/src/pages/loginPage.dart';
import 'package:FlexPay/src/service/auth/authentication_state.dart';
import 'package:FlexPay/src/service/bancoRendimentoService.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ContainerPage extends StatefulWidget {
  ContainerPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ContainerPageState createState() => _ContainerPageState();
}

class _ContainerPageState extends State<ContainerPage> {
  final StreamController<AuthenticationState> streamController = new StreamController();
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
//         _billsInfo(),
        ],
      ),
    );
  }

  _cardProfile() {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
            backgroundImage: NetworkImage(
                'https://media-exp1.licdn.com/dms/image/C4D03AQEeea6DPn5mvg/profile-displayphoto-shrink_100_100/0?e=1588204800&v=beta&t=3nm8yRQ-2oqrb8p15zK3RRRfMDcvUIsTlB5afpGcQOs')),
        title: Text('Bruno Brito'),
        subtitle: Text('bruno.brito@flexpag.com'),
      ),
    );
  }
  _cardMyAccount() {
    return  Card(
      child: ListTile(
        leading: Icon(Icons.account_circle, color: Color(0xff0f3666)),
        title: Text('Meu Perfil'),
      ),
    );
  }
  _cardMyOrders() {
    return    Card(
      child: ListTile(
        leading: Icon(Icons.shopping_cart, color: Color(0xff0f3666)),
        title: Text('Meus Pedidos'),
      ),
    );
  }
  _cardSignout(){
    return Card(
      child: ListTile(
          leading: Icon(Icons.exit_to_app, color: Color(0xff0f3666)),
          title: Text('Sair'),
          onTap: () {
            signOut();
          }),
    );
  }

  signOut() {
    streamController.add(AuthenticationState.signedOut());
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => LoginPage()));

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
        mainAxisAlignment: MainAxisAlignment.center,
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
              child: Container(
                child: _title(),
              ),
              decoration: BoxDecoration(
                color: Colors.white,
              ),
            ),
            _cardProfile(),
            _cardMyAccount(),
            _cardMyOrders(),
            _cardSignout()
          ],
        ),
      ),
    );
  }

  _billsInfo() {
    if (resp != null) {
      return new Text("Motivo : " + resp?.value?.motivo);
    }
  }
}
