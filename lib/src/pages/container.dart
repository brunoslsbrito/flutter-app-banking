import 'dart:async';

import 'package:FlexPay/src/component/barcodeScanner.dart';
import 'package:FlexPay/src/pages/loginPage.dart';
import 'package:FlexPay/src/pages/transaction.dart';
import 'package:FlexPay/src/service/auth/authentication_state.dart';
import 'package:FlexPay/src/util/consts.dart';
import 'package:flutter/material.dart';

import 'dashboard.dart';
import 'myAccount.dart';

class ContainerPage extends StatefulWidget {
  ContainerPage({Key key}) : super(key: key);

  @override
  _ContainerPageState createState() => _ContainerPageState();
}

class _ContainerPageState extends State<ContainerPage> {
  final StreamController<AuthenticationState> streamController =
      new StreamController();

  Widget _title() {
    return Image.asset('assets/images/logo.png');
  }

  _barcodeReader() {
    return BarcodeComponent();
  }

  _cardProfile() {
    return Card(
      child: ListTile(
        leading: CircleAvatar(child: Image.asset('assets/images/profile.png')),
        title: Text('Bruno Brito'),
        subtitle: Text('bruno.brito@flexpag.com'),
      ),
    );
  }

  _cardMyAccount() {
    return Card(
      child: ListTile(
          leading: Icon(Icons.account_circle,
              color: Color(Consts.PRIMARY_BLUE_COLOR)),
          title: Text('Meu Perfil'),
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => MyAccount()));
          }),
    );
  }

  _cardDashboard() {
    return Card(
      child: ListTile(
          leading:
              Icon(Icons.dashboard, color: Color(Consts.PRIMARY_BLUE_COLOR)),
          title: Text('Dashboard'),
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Dashboard()));
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
    return MaterialApp(
      color: Color(Consts.PRIMARY_BLUE_COLOR),
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: buildTab(),
          body: TabBarView(
            children: [
              MyAccount(),
              _barcodeReader(),
              Dashboard(),
            ],
          ),
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
        ),
      ),
    );
  }

  AppBar buildTab() {
    return AppBar(
      backgroundColor: Color(0xff2a508e),
      bottom: TabBar(
        tabs: [
          Tab(icon: Icon(Icons.credit_card), text: "Minha Conta"),
          Tab(icon: Icon(Icons.add_a_photo), text: "Pagamento"),
          Tab(icon: Icon(Icons.dashboard), text: "Dashboard"),
        ],
      ),
    );
  }
}
