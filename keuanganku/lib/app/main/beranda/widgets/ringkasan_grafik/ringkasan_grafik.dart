// ignore_for_file: non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:keuanganku/database/helper/data_pemasukan_x_pengeluaran.dart';
import 'package:keuanganku/database/helper/data_pengeluaran.dart';
import 'package:keuanganku/database/model/data_pengeluaran.dart';
import 'package:keuanganku/database/model/data_transaksi.dart';
import 'package:keuanganku/app/main/wrap.dart';
import 'package:keuanganku/enum/data_transaksi.dart';
import 'package:keuanganku/app/main/beranda/widgets/ringkasan_grafik/widgets/grafik_bar/grafik_bar.dart';
import 'package:keuanganku/app/main/beranda/widgets/ringkasan_grafik/widgets/tab_jenis_transaksi/tab_jenis_transaksi.dart';
import 'package:keuanganku/app/main/beranda/widgets/ringkasan_grafik/widgets/tab_waktu_transaksi/tab_waktu_transaksi.dart';
import 'package:keuanganku/app/reusable_components/bar_chart/data.dart';
import 'package:keuanganku/main.dart';
import 'package:keuanganku/util/date_util.dart';
import 'package:keuanganku/util/get_currency.dart';
import 'package:keuanganku/util/random_algo.dart';
import 'package:keuanganku/util/vector_operation.dart';

class Data {
  // Variabel
  int indeksTabJenisTransaksi = 0;
  int indeksTabWaktuTransaksi = 0;

  Future<List<BarChartXY>> get _barChartPemasukan async {
    List<DateTime> tanggalSeninKeMinggu = getRangeTanggalSeninKeMinggu();
    Future<List<double>> getDataMingguan(DateTime tanggal) async {
      final List<ModelDataPengeluaran> data = await SQLDataPengeluaran().readWithClause(clause: SQLDataPengeluaran().waktuClauseTanggal(tanggal), db: db.database);
      final List<double> filteredData = data
          .where((e) => e.nilai != null) // Filter nilai yang bukan null
          .map((e) => e.nilai!) // Mengonversi nilai nullable menjadi non-nullable
          .toList();
      return filteredData;
    }

    switch (waktuTransaksi) {
      case WaktuTransaksi.MINGGUAN:
        return [
          BarChartXY(xValue: 0, yValue: 0),
          BarChartXY(xValue: 1, yValue: 0),
          BarChartXY(xValue: 2, yValue: 0),
          BarChartXY(xValue: 3, yValue: 0),
          BarChartXY(xValue: 4, yValue: 0),
          BarChartXY(xValue: 5, yValue: 0),
          BarChartXY(xValue: 6, yValue: 0),
        ];
      case WaktuTransaksi.TAHUNAN:
        return [
          BarChartXY(xValue: 0, yValue: generateRandomNumber(1000000, 1000000000)),
          BarChartXY(xValue: 1, yValue: generateRandomNumber(1000000, 1000000000)),
          BarChartXY(xValue: 2, yValue: generateRandomNumber(1000000, 1000000000)),
          BarChartXY(xValue: 4, yValue: generateRandomNumber(1000000, 1000000000)),
          BarChartXY(xValue: 5, yValue: generateRandomNumber(1000000, 1000000000)),
          BarChartXY(xValue: 6, yValue: generateRandomNumber(1000000, 1000000000)),
          BarChartXY(xValue: 7, yValue: generateRandomNumber(1000000, 1000000000)),
          BarChartXY(xValue: 8, yValue: generateRandomNumber(1000000, 1000000000)),
          BarChartXY(xValue: 9, yValue: generateRandomNumber(1000000, 1000000000)),
          BarChartXY(xValue: 10, yValue: generateRandomNumber(1000000, 1000000000)),
          BarChartXY(xValue: 11, yValue: generateRandomNumber(1000000, 1000000000)),
        ];
      default:
        return [];
    }
  }

  Future<List<BarChartXY>> get _barChartPengeluaran async{
    List<DateTime> tanggalSeninKeMinggu = getRangeTanggalSeninKeMinggu();
    Future<List<double>> getDataMingguan(DateTime tanggal) async {
      final List<ModelDataPengeluaran> data = await SQLDataPengeluaran().readWithClause(clause: SQLDataPengeluaran().waktuClauseTanggal(tanggal), db: db.database);
      final List<double> filteredData = data
          .where((e) => e.nilai != null) // Filter nilai yang bukan null
          .map((e) => e.nilai!) // Mengonversi nilai nullable menjadi non-nullable
          .toList();
      return filteredData;
    }

    switch (waktuTransaksi) {
      case WaktuTransaksi.MINGGUAN:
        return [
          BarChartXY(xValue: 0, yValue: sumList(await getDataMingguan(tanggalSeninKeMinggu[0]))),
          BarChartXY(xValue: 1, yValue: sumList(await getDataMingguan(tanggalSeninKeMinggu[1]))),
          BarChartXY(xValue: 2, yValue: sumList(await getDataMingguan(tanggalSeninKeMinggu[2]))),
          BarChartXY(xValue: 3, yValue: sumList(await getDataMingguan(tanggalSeninKeMinggu[3]))),
          BarChartXY(xValue: 4, yValue: sumList(await getDataMingguan(tanggalSeninKeMinggu[4]))),
          BarChartXY(xValue: 5, yValue: sumList(await getDataMingguan(tanggalSeninKeMinggu[5]))),
          BarChartXY(xValue: 6, yValue: sumList(await getDataMingguan(tanggalSeninKeMinggu[6]))),
        ];
      case WaktuTransaksi.TAHUNAN:
        return [
          BarChartXY(xValue: 0, yValue: generateRandomNumber(1000000, 1000000000)),
          BarChartXY(xValue: 1, yValue: generateRandomNumber(1000000, 1000000000)),
          BarChartXY(xValue: 2, yValue: generateRandomNumber(1000000, 1000000000)),
          BarChartXY(xValue: 4, yValue: generateRandomNumber(1000000, 1000000000)),
          BarChartXY(xValue: 5, yValue: generateRandomNumber(1000000, 1000000000)),
          BarChartXY(xValue: 6, yValue: generateRandomNumber(1000000, 1000000000)),
          BarChartXY(xValue: 7, yValue: generateRandomNumber(1000000, 1000000000)),
          BarChartXY(xValue: 8, yValue: generateRandomNumber(1000000, 1000000000)),
          BarChartXY(xValue: 9, yValue: generateRandomNumber(1000000, 1000000000)),
          BarChartXY(xValue: 10, yValue: generateRandomNumber(1000000, 1000000000)),
          BarChartXY(xValue: 11, yValue: generateRandomNumber(1000000, 1000000000)),
        ];
      default:
        return [];
    }
  }

  Future<List<BarChartXY>> get arrayBarChart async{
    switch (jenisTransaksi) {
      case JenisTransaksi.PEMASUKAN:
        return await _barChartPemasukan;
      case JenisTransaksi.PENGELUARAN:
        return _barChartPengeluaran;
      default:
        return [];
    }
  }

  JenisTransaksi jenisTransaksi = JenisTransaksi.PEMASUKAN;
  WaktuTransaksi waktuTransaksi = WaktuTransaksi.MINGGUAN;

  Future<String> get total async {
    final List<DataTransaksi>listData = await readDataPengeluaranAtauPemasukan(RingkasanGrafik.data.jenisTransaksi, RingkasanGrafik.data.waktuTransaksi);
    final total = sumList(listData.map((e) => e.nilai!).toList());
    return formatCurrency(total);
  }
}

class RingkasanGrafik{
  static Data data = Data();
  BuildContext context;
  RingkasanGrafik(this.context);

  Widget getWidget(){
    // WIDGETS
    widgetTabJenisTransaksi() => TabJenisTransaksi(indeksTab: RingkasanGrafik.data.indeksTabJenisTransaksi);
    widgetTabWaktuTransaksi() => TabWaktuTransaksi(indeksWaktuTransaksi: RingkasanGrafik.data.indeksTabWaktuTransaksi,).getWidget(context);
    widgetGrafikBar() {
      return FutureBuilder(
        future: RingkasanGrafik.data.arrayBarChart, 
        builder: (context, snapshot){
          if (snapshot.hasData){
            return GrafikBar(
                jenisTransaksi: RingkasanGrafik.data.jenisTransaksi, 
                waktuTransaksi: RingkasanGrafik.data.waktuTransaksi,
                dataBarChart: snapshot.data!
            );
          } else {
            return const CircularProgressIndicator();
          }
        }
      );
    }
    
    return Column(
      children: [
        widgetTabJenisTransaksi(),
        padding(),
        widgetTabWaktuTransaksi(),
        padding(y: 5),
        widgetGrafikBar(),
      ],
    );
  }
}