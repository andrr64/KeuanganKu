import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:keuanganku/app/widgets/k_bar_chart_data/k_bar_chart_data.dart';
import 'package:keuanganku/app/widgets/k_card/k_card.dart';
import 'package:keuanganku/app/widgets/k_empty/k_empty.dart';
import 'package:keuanganku/database/helper/expense.dart';
import 'package:keuanganku/database/model/expense.dart';
import 'package:keuanganku/main.dart';
import 'package:keuanganku/util/dummy.dart';
import 'package:keuanganku/enum/data_transaksi.dart';
import 'package:keuanganku/util/font_style.dart';
import 'package:keuanganku/util/get_currency.dart';
import 'package:keuanganku/util/search_algo.dart';
import 'package:keuanganku/util/vector_operation.dart';

class WidgetData{
  WaktuTransaksi waktuTransaksi = WaktuTransaksi.Mingguan;
  SortirTransaksi sortirTransaksi = SortirTransaksi.Terbaru;
  List<SQLModelExpense> dataPengeluaran = [];
  List<KBarChartXY>? _dataBar(List<SQLModelExpense> data){
    List<KBarChartXY> barChartMingguan(List<SQLModelExpense> listPengeluaran) {
      List<KBarChartXY> result = [];
      DateTime now = DateTime.now();

      // Mencari tahu tanggal hari Senin ini
      DateTime monday = now.subtract(Duration(days: now.weekday - 1));

      // Iterasi untuk 7 hari dari Senin hingga Minggu
      for (var i = 0; i < 7; i++) {
        // Menghitung tanggal untuk setiap hari dalam minggu
        DateTime currentDate = monday.add(Duration(days: i));

        // Memanggil fungsi totalPengeluaranByDate untuk setiap hari
        double totalNilaiPengeluaran = SQLModelExpense.totalPengeluaranByDate(currentDate, listPengeluaran);

        // Menambahkan data ke list result
        result.add(
          KBarChartXY(
            xValue: i.toDouble(),
            yValue: totalNilaiPengeluaran,
          ),
        );
      }

      return result;
    }
    List<KBarChartXY> barChartTahun(List<SQLModelExpense> listPengeluaran) {
        List<KBarChartXY> result = [];
        DateTime now = DateTime.now();

        // Iterasi untuk 12 bulan
        for (var i = 1; i <= 12; i++) {
          // Memanggil fungsi totalPengeluaranByDate untuk setiap bulan dalam tahun ini
          double totalNilaiPengeluaran = SQLModelExpense.totalPengeluaranByMonth(
            now.year, 
            i,
            listPengeluaran,
          );

          // Menambahkan data ke list result
          result.add(
            KBarChartXY(
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
    dataPengeluaran = await SQLHelperExpense().readByWaktu(waktuTransaksi, db: db.database);
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
    Future<Map<String, dynamic>> getData() async {
      return {
        'barChartData' : await widgetData.barChart,
        'dataPengeluaran' : widgetData.dataPengeluaran
      };
    }
    return FutureBuilder(
      future: getData(), 
      builder: (_, snapshot){
        if (snapshot.connectionState == ConnectionState.waiting){
          return makeCenterWithRow(child: const CircularProgressIndicator());
        } else if (snapshot.hasError){
          return makeCenterWithRow(child: const Text("Sadly, something wrong..."));
        } else {
          if (snapshot.data!['barChartData'].isEmpty || snapshot.data == null){
            return makeCenterWithRow(child: const KEmpty());
          } else {
            final dataPengeluaran = snapshot.data!['dataPengeluaran'] as List<SQLModelExpense>;
            final dataBarChart = snapshot.data!['barChartData'] as List<KBarChartXY>;

            final maxY = findLargestValue(dataBarChart.map((e) => e.yValue).toList());
            final ratingAvg = sumList(dataPengeluaran.map((e) => e.rating).toList()) / dataPengeluaran.length;
            final totalPengeluaran = sumList(dataPengeluaran.map((e) => e.nilai).toList());

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  SQLModelExpense.getInfoBasedOnRating(ratingAvg), 
                  style: kFontStyle(fontSize: 14,),
                ),
                dummyHeight(height: 15),
                Text("Rating Rata-Rata: ${ratingAvg.toStringAsFixed(1)}", style: kFontStyle(fontSize: 14,family: "QuickSand_Mediu"),),
                Text("Total Pengeluaran: ${formatCurrency(totalPengeluaran)}", style: kFontStyle(fontSize: 14,family: "QuickSand_Mediu"),),
                dummyHeight(height: 20),
                SizedBox(
                  width: size.width * 0.875,
                  height: 275,
                  child: barChart(size: size, data: dataBarChart, maxY: maxY)
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
                    color: Colors.red,
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
        icon: icon,
        child: buildBody(size)
      ),
    );
  }
}