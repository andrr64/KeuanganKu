import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:keuanganku/enum/data_transaksi.dart';
import 'package:keuanganku/app/app_colors.dart';
import 'package:keuanganku/app/main/beranda/widgets/ringkasan_grafik/ringkasan_grafik.dart';
import 'package:keuanganku/app/reusable_components/bar_chart/bar_chart.dart';
import 'package:keuanganku/app/reusable_components/bar_chart/data.dart';

class Properties {
    
  Widget _weeklyTitle(double xValue, TitleMeta meta){
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
  Widget _yearlyTitle(double xValue, TitleMeta meta) {
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
      case WaktuTransaksi.MINGGUAN:
        return _weeklyTitle;
      case WaktuTransaksi.TAHUNAN:
        return _yearlyTitle;
      default:
        return _defaultGetTitle;
    }  
  }

  String 
  infoWaktuTransaksi(WaktuTransaksi waktuTransaksi) {
    switch (waktuTransaksi) {
      case WaktuTransaksi.MINGGUAN:
        return "Minggu Ini";
      case WaktuTransaksi.TAHUNAN:
        return "Tahun Ini";
      default:
        return "Ringkasan";
    }
  }
}

class GrafikBar extends StatelessWidget {
  GrafikBar({super.key, required this.jenisTransaksi, required this.waktuTransaksi, required this.dataBarChart});
  
  final JenisTransaksi jenisTransaksi;
  final WaktuTransaksi waktuTransaksi;
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
        RingkasanGrafik.data.total,
        style: const TextStyle(
          fontSize: 18,
          fontFamily: "QuickSand_Bold",
          color: ApplicationColors.primary
        ),
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
            barWidth:  waktuTransaksi == WaktuTransaksi.MINGGUAN? 25 : (225/dataBarChart.length)-10,
            getBottomTitle: properties.getBottomTitle(waktuTransaksi),
            getRightTitle: properties.getRightTitle,
          )
        ],
      ),
  );
  }
}