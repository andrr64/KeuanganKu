import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:keuanganku/app/app_colors.dart';
import 'package:keuanganku/app/reusable_widgets/bar_chart/bar_chart.dart';
import 'package:keuanganku/app/reusable_widgets/bar_chart/data.dart';

class GrafikBarMingguan extends StatelessWidget {
  const GrafikBarMingguan({super.key, required this.dataBarChart});
  final List<BarChartXY> dataBarChart;
  
  @override
  Widget build(BuildContext context) {
    // Widgets
    Widget bottomTitleHarian(double xValue, TitleMeta meta){
      TextStyle textStyle = TextStyle(
        fontFamily: "QuickSand_Bold",
        fontSize: 12,
        color: ApplicationColors.primaryColorWidthPercentage(percentage: 50)
      );

      List<String> listDay = ["S", "S", "R", "K", "J", "S", "M"];

      return Text(listDay[xValue.toInt()], style: textStyle,);
    }

    Widget getRightTitle(double val, TitleMeta meta){
      TextStyle textStyle = TextStyle(
        fontFamily: "QuickSand_Bold",
        fontSize: 12,
        color: ApplicationColors.primaryColorWidthPercentage(percentage: 50)
      );

      return Text(meta.formattedValue, style: textStyle,);
    }

    var display = MediaQuery.sizeOf(context);

    return 
    SizedBox(
      width: display.width * 0.9,
      child: ApplicationBarChart(
        dataXY: dataBarChart, 
        barWidth: 25, 
        getBottomTitle: bottomTitleHarian, 
        getRightTitle: getRightTitle
      ),
    );
  }
}