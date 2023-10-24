import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:keuanganku/ui/mainpage/beranda/widgets/barchart/bar_data.dart';

class MyBartChart extends StatelessWidget {
  final List dataMingguan;
  const MyBartChart({super.key, required this.dataMingguan});

  getBottomTitle(double value, TitleMeta titleMeta) {
    const style = TextStyle(fontSize: 12, color: Colors.white);

    Widget textWidget;

    switch (value.toInt()) {
      case 0:
        textWidget = const Text(
          "S",
          style: style,
        );
        break;
      case 1:
        textWidget = const Text(
          "S",
          style: style,
        );
        break;
      case 2:
        textWidget = const Text(
          "R",
          style: style,
        );
        break;
      case 3:
        textWidget = const Text(
          "K",
          style: style,
        );
        break;
      case 4:
        textWidget = const Text(
          "J",
          style: style,
        );
        break;
      case 5:
        textWidget = const Text(
          "S",
          style: style,
        );
        break;
      case 6:
        textWidget = const Text(
          "M",
          style: style,
        );
        break;
      default:
        textWidget = const Text("");
        break;
    }

    return textWidget;
  }

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

  @override
  Widget build(BuildContext context) {
    BarDataMingguan barDataMingguan = BarDataMingguan(
        senin: dataMingguan[0],
        selasa: dataMingguan[1],
        rabu: dataMingguan[2],
        kamis: dataMingguan[3],
        jumat: dataMingguan[4],
        sabtu: dataMingguan[5],
        minggu: dataMingguan[6]);
    barDataMingguan.inisialisasiBarData();
    double maxY =
        findMax(barDataMingguan.barData.map((data) => data.y).toList());
    maxY += (maxY * 0.1);

    return SizedBox(
      width: 125,
      height: 90,
      child: BarChart(BarChartData(
          minY: 0,
          maxY: findMax(barDataMingguan.barData.map((data) => data.y).toList()),
          borderData: FlBorderData(show: false),
          titlesData: const FlTitlesData(show: false,),
          gridData: const FlGridData(show: false),
          barGroups: barDataMingguan.barData
              .map((data) => BarChartGroupData(x: data.x, barRods: [
                    BarChartRodData(toY: data.y, color: Colors.white, width: 12)
                  ]))
              .toList())),
    );
  }
}
