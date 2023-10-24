import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:keuanganku/pages/mainpage/beranda/widgets/barchart/individual_bar.dart';

class BarChartDataArray {
  List<IndividualBar> listDataBarChart = [];

  BarChartDataArray(List<double> data) {
    listDataBarChart = [];
    int dataLength = data.length;

    for (int i = 0; i < dataLength; i++) {
      listDataBarChart.add(IndividualBar(x: i, y: data[i]));
    }
  }
}

class BarChartWidget extends StatelessWidget {
  final double lebar;
  final double tinggi;
  final List<double> dataGrafik;
  final Color warnaBar;

  const BarChartWidget(
      {super.key,
      required this.dataGrafik,
      required this.lebar,
      required this.tinggi,
      required this.warnaBar});

  @override
  Widget build(BuildContext context) {
    findMax(List<double> list) {
      if (list.isEmpty) {
        throw ArgumentError("List tidak boleh kosong");
      }

      double max = list[0];
      for (double number in list) {
        if (number > max) {
          max = number;
        }
      }
      return max;
    }

    double maxValue = findMax(dataGrafik);
    BarChartDataArray barChartDataArray = BarChartDataArray(dataGrafik);
    double lebarBar = 10;

    return SizedBox(
      width: lebar,
      height: tinggi,
      child: BarChart(BarChartData(
          minY: 0,
          maxY: maxValue + (maxValue * 0.05),
          borderData: FlBorderData(show: false),
          titlesData: const FlTitlesData(
            show: false,
          ),
          gridData: const FlGridData(show: false),
          barGroups: barChartDataArray.listDataBarChart
              .map((data) => BarChartGroupData(x: data.x, barRods: [
                    BarChartRodData(
                        toY: data.y, color: warnaBar, width: lebarBar)
                  ]))
              .toList())),
    );
  }
}
