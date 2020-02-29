import 'dart:async';

import 'package:FlexPay/src/pages/loginPage.dart';
import 'package:FlexPay/src/pages/welcomePage.dart';
import 'package:FlexPay/src/service/auth/authentication_state.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final StreamController<AuthenticationState> _streamController =
      new StreamController<AuthenticationState>();

  Widget buildUi(BuildContext context, AuthenticationState s) {
    if (s.authenticated) {
      return Container();
    } else {
      return WelcomePage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return new StreamBuilder<AuthenticationState>(
        stream: _streamController.stream,
        initialData: new AuthenticationState.initial(),
        builder: (BuildContext context,
            AsyncSnapshot<AuthenticationState> snapshot) {
          final state = snapshot.data;
          return buildUi(context, state);
        });
  }
}
