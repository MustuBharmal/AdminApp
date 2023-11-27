import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

import '../constants/global_variables.dart';

class MonthlyAnalysis extends StatelessWidget {
  static const routeName = '/monthly-analysis';
  final Map<String, double> dataMap = {
    "Pending": double.parse(pen),
    "Ongoing": double.parse(on),
    "Resolved": double.parse(res),
    "Rejected": double.parse(rej),
  };

  MonthlyAnalysis({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pie Chart"),
      ),
      body: Center(
        child: PieChart(
          dataMap: dataMap,
          chartRadius: MediaQuery.of(context).size.width / 1.7,
          legendOptions: const LegendOptions(
            legendPosition: LegendPosition.bottom,
          ),
          chartValuesOptions: const ChartValuesOptions(
            showChartValuesInPercentage: true,
          ),
        ),
      ),
    );
  }
}
