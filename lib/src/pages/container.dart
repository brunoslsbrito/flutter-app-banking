import 'dart:async';

import 'package:FlexPay/src/component/customDialog.dart';
import 'package:FlexPay/src/model/bancoRendimento/responseBillInfo.dart';
import 'package:FlexPay/src/pages/loginPage.dart';
import 'package:FlexPay/src/pages/transaction.dart';
import 'package:FlexPay/src/service/auth/authentication_state.dart';
import 'package:FlexPay/src/service/bancoRendimentoService.dart';
import 'package:FlexPay/src/util/consts.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ContainerPage extends StatefulWidget {
  ContainerPage({Key key}) : super(key: key);

  @override
  _ContainerPageState createState() => _ContainerPageState();
}

class _ContainerPageState extends State<ContainerPage> {
  final StreamController<AuthenticationState> streamController =
      new StreamController();
  String barcode = "";

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
          .then((value) => _bill(value))
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

  _barcodeReader() {
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
    return Card(
      child: ListTile(
        leading:
            Icon(Icons.account_circle, color: Color(Consts.PRIMARY_BLUE_COLOR)),
        title: Text('Meu Perfil'),
      ),
    );
  }

  _cardDashboard() {
    return Card(
      child: ListTile(
          leading:
              Icon(Icons.dashboard, color: Color(Consts.PRIMARY_BLUE_COLOR)),
          title: Text('Dashboard'),
          onTap: () {
//            Navigator.push(context,
//                MaterialPageRoute(builder: (context) => Dashboard.withSampleData()));
          }),
    );
  }
  _cardTransactions() {
    return Card(
      child: ListTile(
          leading:
              Icon(Icons.view_list, color: Color(Consts.PRIMARY_BLUE_COLOR)),
          title: Text('Transações'),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => Transaction()));
          }),
    );
  }

  _cardMyOrders() {
    return Card(
      child: ListTile(
        leading:
            Icon(Icons.shopping_cart, color: Color(Consts.PRIMARY_BLUE_COLOR)),
        title: Text('Meus Pedidos'),
      ),
    );
  }

  _cardSignout() {
    return Card(
      child: ListTile(
          leading:
              Icon(Icons.exit_to_app, color: Color(Consts.PRIMARY_BLUE_COLOR)),
          title: Text('Sair'),
          onTap: () {
            signOut();
          }),
    );
  }

  signOut() {
    streamController.add(AuthenticationState.signedOut());
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(Consts.PRIMARY_BLUE_COLOR),
      ),
      body: Center(
          child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
//        children: <Widget>[Expanded(child: _barcodeReader())],
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
            _cardDashboard(),
            _cardTransactions(),
            _cardMyOrders(),
            _cardSignout(),
          ],
        ),
      ),
    );
  }
}
