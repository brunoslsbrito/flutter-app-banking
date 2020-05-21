import 'package:FlexPay/src/pages/home.dart';
import 'package:FlexPay/src/service/auth/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FlexPay - Flexpag',
      theme: ThemeData(
//        brightness: Brightness.dark,
        primarySwatch: Colors.indigo,
        textTheme: GoogleFonts.latoTextTheme(textTheme).copyWith(
          body1: GoogleFonts.roboto(textStyle: textTheme.body1),
        ),
      ),
      home: HomePage(),
    );
  }
}
