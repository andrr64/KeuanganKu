// ignore_for_file: non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:keuanganku/database/helper/data_pemasukan_x_pengeluaran.dart';
import 'package:keuanganku/database/model/data_transaksi.dart';
import 'package:keuanganku/app/main/wrap.dart';
import 'package:keuanganku/enum/data_transaksi.dart';
import 'package:keuanganku/app/main/beranda/widgets/ringkasan_grafik/widgets/grafik_bar/grafik_bar.dart';
import 'package:keuanganku/app/main/beranda/widgets/ringkasan_grafik/widgets/tab_jenis_transaksi/tab_jenis_transaksi.dart';
import 'package:keuanganku/app/main/beranda/widgets/ringkasan_grafik/widgets/tab_waktu_transaksi/tab_waktu_transaksi.dart';
import 'package:keuanganku/app/reusable_components/bar_chart/data.dart';
import 'package:keuanganku/util/get_currency.dart';
import 'package:keuanganku/util/random_algo.dart';
import 'package:keuanganku/util/vector_operation.dart';

class Data {
  // Variabel
  int indeksTabJenisTransaksi = 0;
  int indeksTabWaktuTransaksi = 0;

  List<BarChartXY> get _dataBarChartPengeluaran {
    //TODO: API_GET_Database_dataBarChartPengeluaran(x)
    switch (waktuTransaksi) {
      case WaktuTransaksi.MINGGUAN:
        return [
          BarChartXY(xValue: 0, yValue: generateRandomNumber(10000, 10000000)),
          BarChartXY(xValue: 1, yValue: generateRandomNumber(10000, 10000000)),
          BarChartXY(xValue: 2, yValue: generateRandomNumber(10000, 10000000)),
          BarChartXY(xValue: 4, yValue: generateRandomNumber(10000, 10000000)),
          BarChartXY(xValue: 5, yValue: generateRandomNumber(10000, 10000000)),
          BarChartXY(xValue: 6, yValue: generateRandomNumber(10000, 10000000)),
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

  List<BarChartXY> get _barChartPemasukan {
    //TODO: API_GET_Database_dataBarChartPemasuakn(x)
    switch (waktuTransaksi) {
      case WaktuTransaksi.MINGGUAN:
        return [
          BarChartXY(xValue: 0, yValue: generateRandomNumber(10000, 10000000)),
          BarChartXY(xValue: 1, yValue: generateRandomNumber(10000, 10000000)),
          BarChartXY(xValue: 2, yValue: generateRandomNumber(10000, 10000000)),
          BarChartXY(xValue: 4, yValue: generateRandomNumber(10000, 10000000)),
          BarChartXY(xValue: 5, yValue: generateRandomNumber(10000, 10000000)),
          BarChartXY(xValue: 6, yValue: generateRandomNumber(10000, 10000000)),
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

  List<BarChartXY> get arrayBarChart {
    switch (jenisTransaksi) {
      case JenisTransaksi.PEMASUKAN:
        return _dataBarChartPengeluaran;
      case JenisTransaksi.PENGELUARAN:
        return _barChartPemasukan;
      default:
        return [];
    }
  }

  JenisTransaksi jenisTransaksi = JenisTransaksi.PENGELUARAN;
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
    widgetGrafikBar() => GrafikBar(
        jenisTransaksi: RingkasanGrafik.data.jenisTransaksi, 
        waktuTransaksi: RingkasanGrafik.data.waktuTransaksi,
        dataBarChart: RingkasanGrafik.data.arrayBarChart
    );
    
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