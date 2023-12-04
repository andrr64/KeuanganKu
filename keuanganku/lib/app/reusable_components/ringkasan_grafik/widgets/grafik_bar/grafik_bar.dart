import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:keuanganku/enum/data_transaksi.dart';
import 'package:keuanganku/app/app_colors.dart';
import 'package:keuanganku/app/reusable_components/bar_chart/bar_chart.dart';
import 'package:keuanganku/app/reusable_components/bar_chart/data.dart';
import 'package:keuanganku/util/get_currency.dart';

class Properties {
    
  Widget _titleMingguIni(double xValue, TitleMeta meta){
    TextStyle textStyle = TextStyle(
      fontFamily: "QuickSand_Bold",
      fontSize: 12,
      color: ApplicationColors.primaryColorWidthPercentage(percentage: 50)
    );

    List<String> listDay = [
      "S",
      "S",
      "R",
      "K",
      "J",
      "S",
      "M"
    ];
    
    return Text(listDay[xValue.toInt()], style: textStyle,);
  }
  Widget _titleTahunIni(double xValue, TitleMeta meta) {
    TextStyle textStyle = TextStyle(
      fontFamily: "QuickSand_Bold",
      fontSize: 12,
      color: ApplicationColors.primaryColorWidthPercentage(percentage: 50),
    );

    List<String> listMonth = [
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "Mei",
      "Jun",
      "Jul",
      "Ags",
      "Sep",
      "Okt",
      "Nov",
      "Des",
    ];

    return Text(listMonth[xValue.toInt()], style: textStyle,);
  }
  Widget _defaultGetTitle(double value, TitleMeta meta) {
    return SideTitleWidget(
    axisSide: meta.axisSide,
    child: Text(
      meta.formattedValue,
    ),
  );
  }
  
  Widget 
  getRightTitle(double val, TitleMeta meta){
    TextStyle textStyle = TextStyle(
      fontFamily: "QuickSand_Bold",
      fontSize: 12,
      color: ApplicationColors.primaryColorWidthPercentage(percentage: 50)
    );

    return Text(meta.formattedValue, style: textStyle,);
  }

  Widget Function(double val, TitleMeta meta) 
  getBottomTitle(WaktuTransaksi waktuTransaksi){
    switch (waktuTransaksi) {
      case WaktuTransaksi.MingguIni:
        return _titleMingguIni;
      case WaktuTransaksi.TahunIni:
        return _titleTahunIni;
      default:
        return _defaultGetTitle;
    }  
  }

  String 
  infoWaktuTransaksi(WaktuTransaksi waktuTransaksi) {
    switch (waktuTransaksi) {
      case WaktuTransaksi.MingguIni:
        return "Minggu Ini";
      case WaktuTransaksi.TahunIni:
        return "Tahun Ini";
      default:
        return "Ringkasan";
    }
  }
}

class GrafikBar extends StatelessWidget {
  GrafikBar({super.key, required this.jenisTransaksi, required this.waktuTransaksi, required this.dataBarChart, required this.totalNilai});
  
  final JenisTransaksi jenisTransaksi;
  final WaktuTransaksi waktuTransaksi;
  final double totalNilai;
  final Properties properties = Properties();
  final List<BarChartXY> dataBarChart;

  
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    // WIDGETS
    Widget widgetJudul(){
      return 
      Text(properties.infoWaktuTransaksi(waktuTransaksi),
        style: TextStyle(
          fontSize: 16,
          fontFamily: "QuickSand_Medium",
          color: ApplicationColors.primaryColorWidthPercentage(percentage: 75)
        ),
      );
    }
    Widget widgetTotalNilai(){
      return
      Text(
        formatCurrency(totalNilai),
        style: const TextStyle(
            fontSize: 18,
            fontFamily: "QuickSand_Bold",
            color: ApplicationColors.primary
        )
      );
    }
    
    return  
    SizedBox(
      width: size.width * 0.9,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widgetJudul(),
          widgetTotalNilai(),
          const SizedBox(height: 20,),
          ApplicationBarChart(
            dataXY: dataBarChart,
            barWidth:  waktuTransaksi == WaktuTransaksi.MingguIni? 25 : (225/dataBarChart.length)-10,
            getBottomTitle: properties.getBottomTitle(waktuTransaksi),
            getRightTitle: properties.getRightTitle,
          )
        ],
      ),
  );
  }
}