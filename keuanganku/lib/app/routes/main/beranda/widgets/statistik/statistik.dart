import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:keuanganku/app/app_colors.dart';
import 'package:keuanganku/app/reusable_widgets/bar_chart/data.dart';
import 'package:keuanganku/app/reusable_widgets/k_card/k_card.dart';
import 'package:keuanganku/app/reusable_widgets/k_empty/k_empty.dart';
import 'package:keuanganku/database/helper/data_pengeluaran.dart';
import 'package:keuanganku/database/model/data_pengeluaran.dart';
import 'package:keuanganku/main.dart';
import 'package:keuanganku/util/dummy.dart';
import 'package:keuanganku/enum/data_transaksi.dart';
import 'package:keuanganku/util/font_style.dart';
import 'package:keuanganku/util/search_algo.dart';

class WidgetData{
  WaktuTransaksi waktuTransaksi = WaktuTransaksi.Mingguan;
  SortirTransaksi sortirTransaksi = SortirTransaksi.Terbaru;
  
  List<BarChartXY>? _dataBar(List<SQLModelPengeluaran> data){
    List<BarChartXY> barChartMingguan(List<SQLModelPengeluaran> listPengeluaran) {
      List<BarChartXY> result = [];
      DateTime now = DateTime.now();

      // Mencari tahu tanggal hari Senin ini
      DateTime monday = now.subtract(Duration(days: now.weekday - 1));

      // Iterasi untuk 7 hari dari Senin hingga Minggu
      for (var i = 0; i < 7; i++) {
        // Menghitung tanggal untuk setiap hari dalam minggu
        DateTime currentDate = monday.add(Duration(days: i));

        // Memanggil fungsi totalPengeluaranByDate untuk setiap hari
        double totalNilaiPengeluaran = SQLModelPengeluaran.totalPengeluaranByDate(currentDate, listPengeluaran);

        // Menambahkan data ke list result
        result.add(
          BarChartXY(
            xValue: i.toDouble(),
            yValue: totalNilaiPengeluaran,
          ),
        );
      }

      return result;
    }
    List<BarChartXY> barChartTahun(List<SQLModelPengeluaran> listPengeluaran) {
        List<BarChartXY> result = [];
        DateTime now = DateTime.now();

        // Iterasi untuk 12 bulan
        for (var i = 1; i <= 12; i++) {
          // Memanggil fungsi totalPengeluaranByDate untuk setiap bulan dalam tahun ini
          double totalNilaiPengeluaran = SQLModelPengeluaran.totalPengeluaranByMonth(
            now.year, 
            i,
            listPengeluaran,
          );

          // Menambahkan data ke list result
          result.add(
            BarChartXY(
              xValue: i.toDouble(),
              yValue: totalNilaiPengeluaran,
            ),
          );
        }

        return result;
      }

      switch (waktuTransaksi) {
        case WaktuTransaksi.Mingguan:
          return barChartMingguan(data);  
        case WaktuTransaksi.Tahunan:
          return barChartTahun(data);
        default:
          return null;
      }
    }

  Future<ListBarChartXY?> get barChart async {
    var dataPengeluaran = await SQLHelperPengeluaran().readByWaktu(waktuTransaksi, db: db.database);
    if (dataPengeluaran.isEmpty){
      return [];
    }
    return _dataBar(dataPengeluaran)!;
  }
}

class Statistik extends StatelessWidget {
  const Statistik({super.key, required this.widgetData});
  final WidgetData widgetData;
  
  Widget getBottomTitle (double val, TitleMeta meta){
    if (widgetData.waktuTransaksi == WaktuTransaksi.Mingguan){
      final title = ['S', 'S', 'R', 'K', 'J', 'S', 'M'];
      return Text(title[val.toInt()]);
    } else {
      final title = ['Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun', 'Jul', 'Agu', 'Sep', 'Okt', 'Nov', 'Des'];
      return Text(title[val.toInt()], style: kFontStyle(fontSize: 12),);
    }
  }

  Widget getRightTitle(double val, TitleMeta meta){
    return Text(meta.formattedValue, style: kFontStyle(fontSize: 12),);
  }

  FutureBuilder firstStep(Size size){
    return FutureBuilder<ListBarChartXY?> (
      future: widgetData.barChart, 
      builder: (_, snapshot){
        if (snapshot.connectionState == ConnectionState.waiting){
          return makeCenterWithRow(child: const CircularProgressIndicator());
        } else if (snapshot.hasError){
          return makeCenterWithRow(child: const Text("Sadly, something wrong..."));
        } else {
          if (snapshot.data!.isEmpty || snapshot.data == null){
            return makeCenterWithRow(
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: KEmpty(),
                )
              );     
          } else {
            final maxY = findLargestValue(snapshot.data!.map((e) => e.yValue).toList());
            return Column(
              children: [
                Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque nec interdum arcu. In quis erat lacus. Praesent ac cursus arcu, quis congue libero. Praesent viverra laoreet tortor ut sagittis. Nunc iaculis neque ut interdum convallis. ",
                  textAlign: TextAlign.justify,
                  style: kFontStyle(fontSize: 14, family: "QuickSand_Medium"),
                ),
                dummyPadding(height: 25),
                SizedBox(
                  width: size.width * 0.875,
                  height: 275,
                  child: barChart(size: size, data: snapshot.data!, maxY: maxY)
                )
              ],
            );
          }
        }
      }
    );
  }

  Widget barChart({
    required Size size, required  ListBarChartXY data, required double maxY
  }){
    return BarChart(
      BarChartData(
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true, 
              getTitlesWidget: getBottomTitle,
              
            )
          ),
          rightTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: getRightTitle,
              reservedSize: 40,
              interval: maxY == 0? 1000000 : maxY / 5
            )
          ),
          leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false))
        ),
        gridData: const FlGridData(show: false, drawVerticalLine: false),
        barGroups: 
         data.map(
            (e) {
              return BarChartGroupData(
                x: e.xValue.toInt(), 
                barRods: [
                  BarChartRodData(
                    color: ApplicationColors.secondaryOrange,
                    borderRadius: BorderRadius.circular(5),
                    toY: e.yValue,
                    width: (size.width * 0.65) /data.length
                  )  
                ]
              );
            }
          ).toList()
      )
    );
  }

  Widget buildBody(Size size) => firstStep(size);

  @override
  Widget build(BuildContext context) {
    final icon = SvgPicture.asset(
      "assets/icons/statistik.svg",
      height: 35,
    );
    final size = MediaQuery.sizeOf(context);

    return makeCenterWithRow(
      child: KCard(
        title: "Statistik",
        width: size.width * 0.875,
        icon: icon, 
        child: buildBody(size)
      ),
    );
  }
}