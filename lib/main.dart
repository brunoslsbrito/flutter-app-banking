import 'package:FlexPay/src/pages/home.dart';
import 'package:FlexPay/src/service/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'src/pages/welcomePage.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return MaterialApp(
      title: 'FlexPay - Flexpag',
      theme: ThemeData(
         primarySwatch: Colors.blue,
         textTheme:GoogleFonts.latoTextTheme(textTheme).copyWith(
           body1: GoogleFonts.montserrat(textStyle: textTheme.body1),
         ),
      ),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
