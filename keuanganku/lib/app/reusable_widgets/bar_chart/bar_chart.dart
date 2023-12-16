import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:keuanganku/app/app_colors.dart';
import 'package:keuanganku/app/reusable_widgets/bar_chart/data.dart';
import 'package:keuanganku/util/search_algo.dart';

class ApplicationBarChart extends StatelessWidget {
  const ApplicationBarChart({
    super.key, required this.dataXY, 
    required this.barWidth,
    required this.getBottomTitle,
    required this.getRightTitle
  });

  final List<BarChartXY> dataXY;
  final double barWidth;
  final Widget Function(double xValue, TitleMeta meta) getBottomTitle;
  final Widget Function(double val, TitleMeta meta) getRightTitle;

  double get minY => 0;
  double get maxY => findLargestValue(dataXY.map((e) => e.yValue).toList());

  BarChartGroupData _createBar(BarChartXY barChartXYData, double barWidth) {
    return BarChartGroupData(
      x: barChartXYData.xValue.toInt(),
      barRods: [
        BarChartRodData(
          color: ApplicationColors.secondaryYoungPurple,
          borderRadius: BorderRadius.circular(5),
          width: barWidth,
          toY: barChartXYData.yValue
        )
      ] 
    );
  }
  
  List<BarChartGroupData> get barChartGroupData{
    return dataXY.map((e) => _createBar(e, barWidth)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: BarChart(
        BarChartData(
          borderData: FlBorderData(show: false),
          gridData: const FlGridData(show: true, drawVerticalLine: false),
          titlesData: FlTitlesData(
            leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: getRightTitle,
                reservedSize: 45,
                interval: maxY == 0? 1000000 : maxY / 5
              )
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                getTitlesWidget: getBottomTitle,
                showTitles: true,
              )
            ),
          ),
          minY: minY,
          maxY: maxY,
          barGroups: barChartGroupData
        )
      ),
    );
  }

}
