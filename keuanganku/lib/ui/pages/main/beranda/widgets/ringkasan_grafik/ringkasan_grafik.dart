// ignore_for_file: non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:keuanganku/enum/data_transaksi.dart';
import 'package:keuanganku/ui/pages/main/beranda/widgets/ringkasan_grafik/widgets/grafik_bar/grafik_bar.dart';
import 'package:keuanganku/ui/pages/main/beranda/widgets/ringkasan_grafik/widgets/tab_jenis_transaksi/tab_jenis_transaksi.dart';
import 'package:keuanganku/ui/pages/main/beranda/widgets/ringkasan_grafik/widgets/tab_waktu_transaksi/tab_waktu_transaksi.dart';
import 'package:keuanganku/ui/reusable%20_components/bar_chart/data.dart';
import 'package:keuanganku/ui/state_bridge.dart';
import 'package:keuanganku/util/get_currency.dart';
import 'package:keuanganku/util/random_algo.dart';

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

  String get total {
    return formatCurrency(12000000);
  }
}

class RingkasanGrafik extends StatefulWidget {
  const RingkasanGrafik({super.key});

  static StateBridge state = StateBridge();
  static Data data = Data();
  
  @override
  State<RingkasanGrafik> createState() => _RingkasanGrafikState();
}

class _RingkasanGrafikState extends State<RingkasanGrafik> {
  void updateState(){
    setState(() {
      
    });
  }

  @override
  void initState() {
    super.initState();
    RingkasanGrafik.state.init(updateState);
  }
  
  @override
  Widget build(BuildContext context) {
    // WIDGETS
    WIDGET_tabJenisTransaksi(){
      return TabJenisTransaksi(indeksTabJenisTransaksi: RingkasanGrafik.data.indeksTabJenisTransaksi);
    }
    WIDGET_tabWaktuTransaksi(){
      return TabWaktuTransaksi(indeksWaktuTransaksi: RingkasanGrafik.data.indeksTabWaktuTransaksi,);
    }
    WIDGET_grafikBar(){
      return GrafikBar(
        jenisTransaksi: RingkasanGrafik.data.jenisTransaksi, 
        waktuTransaksi: RingkasanGrafik.data.waktuTransaksi,
        dataBarChart: RingkasanGrafik.data.arrayBarChart
      );
    }
    //+-----------------------------
    
    return Column(
      children: [
        WIDGET_tabJenisTransaksi(),
        WIDGET_tabWaktuTransaksi(),
        WIDGET_grafikBar()
      ],
    );
  }
}