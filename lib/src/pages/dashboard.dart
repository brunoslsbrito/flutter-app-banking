import 'package:FlexPay/src/pages/charts/OperationChart.dart';
import 'package:FlexPay/src/service/gatewayService.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final GatewayService gatewayService = new GatewayService();

  final List<TransactionSeries> data = [];

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

  @override
  void initState() {
    fetchData();
  }

  fetchData() {
    gatewayService.fetchMovimentMonthly().then((value) {
      setState(() {
        for (int x = 0; x < value.ref.length; x++) {
          data.add(TransactionSeries(
            month: value.ref[x],
            value: value.acumulado[x]/100,
            barColor: x != value.ref.length -1 ? charts.ColorUtil.fromDartColor(Colors.blue) : charts.ColorUtil.fromDartColor(Color(0xff1959a9)),
          ));
        }
      });
    });
  }
}
