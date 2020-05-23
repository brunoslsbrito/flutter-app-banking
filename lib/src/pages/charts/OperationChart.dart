import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OperationChart extends StatelessWidget {
  final List<TransactionSeries> data;

  OperationChart({@required this.data});

  @override
  Widget build(BuildContext context) {
    List<charts.Series<TransactionSeries, String>> series = [
      charts.Series(
          id: "Transações",
          data: data,
          domainFn: (TransactionSeries series, _) => series.month,
          measureFn: (TransactionSeries series, _) => series.value,
          colorFn: (TransactionSeries series, _) => series.barColor)
    ];

    return Container(
      height: 400,
      padding: EdgeInsets.only(top: 0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Column(
            children: <Widget>[
              Expanded(
                child: charts.BarChart(series, animate: true),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class TransactionSeries {
  final String month;
  final double value;
  final charts.Color barColor;

  TransactionSeries(
      {@required this.month,
      @required this.value,
      @required this.barColor});
}
