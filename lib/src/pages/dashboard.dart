import 'package:FlexPay/src/pages/charts/OperationChart.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  final List<TransactionSeries> data = [
    TransactionSeries(
      month: "Nov/19",
      value: 752400,
      barColor: charts.ColorUtil.fromDartColor(Colors.blue),
    ),
    TransactionSeries(
      month: "Dec/19",
      value: 165244402,
      barColor: charts.ColorUtil.fromDartColor(Colors.blue),
    ),
    TransactionSeries(
      month: "Jan/20",
      value: 2389957,
      barColor: charts.ColorUtil.fromDartColor(Colors.blue),
    ),
    TransactionSeries(
      month: "Fev/20",
      value: 170000,
      barColor: charts.ColorUtil.fromDartColor(Colors.blue),
    ),
    TransactionSeries(
      month: "Mar/20",
      value: 65100,
      barColor: charts.ColorUtil.fromDartColor(Colors.blue),
    ),
    TransactionSeries(
      month: "Apr/20",
      value: 7707386,
      barColor: charts.ColorUtil.fromDartColor(Colors.blue),
    ),
    TransactionSeries(
      month: "May/20",
      value: 1374938,
      barColor: charts.ColorUtil.fromDartColor(Color(0xff1959a9)),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff1959a9),
        title: Text("Operações Flexpag"),
      ),
      body: Center(
          child: OperationChart(
            data: data,
          )),
    );
  }
}
