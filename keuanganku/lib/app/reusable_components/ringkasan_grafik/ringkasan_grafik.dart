import 'package:flutter/material.dart';
import 'package:keuanganku/enum/data_transaksi.dart';
import 'package:keuanganku/app/reusable_components/ringkasan_grafik/widgets/grafik_bar/grafik_bar.dart';
import 'package:keuanganku/app/reusable_components/ringkasan_grafik/widgets/tab_jenis_transaksi/tab_jenis_transaksi.dart';
import 'package:keuanganku/app/reusable_components/ringkasan_grafik/widgets/tab_waktu_transaksi/tab_waktu_transaksi.dart';
import 'package:keuanganku/app/reusable_components/bar_chart/data.dart';
import 'package:keuanganku/util/dummy.dart';
import 'package:keuanganku/util/get_currency.dart';
import 'package:keuanganku/util/vector_operation.dart';
import 'package:keuanganku/widget_model/data_pengeluaran.dart';

class RuCRingkasanGrafikData {
  // Variabel
  int indeksTabJenisTransaksi = 0;
  int indeksTabWaktuTransaksi = 0;

  Future<List<BarChartXY>> get arrayBarChart async{
    switch (jenisTransaksi) {
      case JenisTransaksi.PEMASUKAN:
        return await WidgetModelDataPengeluaran().listBarChartPengeluaran(waktuTransaksi);
      case JenisTransaksi.PENGELUARAN:
        return await WidgetModelDataPengeluaran().listBarChartPengeluaran(waktuTransaksi);
      default:
        return [];
    }
  }

  JenisTransaksi jenisTransaksi = JenisTransaksi.PEMASUKAN;
  WaktuTransaksi waktuTransaksi = WaktuTransaksi.MingguIni;

  Future<String> get total async {
    return formatCurrency(12000);
  }
}

class RuCRingkasanGrafik{
  RuCRingkasanGrafik(this.context,{required this.data, this.isSingleTransaction, required this.onUpdate});
  RuCRingkasanGrafikData data;
  BuildContext context;
  bool? isSingleTransaction;
  VoidCallback onUpdate;

  Widget getWidget(){
    // WIDGETS
    widgetTabJenisTransaksi() => TabJenisTransaksi(indeksTab: data.indeksTabJenisTransaksi, data: data, onUpdate: onUpdate,);
    widgetTabWaktuTransaksi() => TabWaktuTransaksi(indeksWaktuTransaksi: data.indeksTabWaktuTransaksi, data: data, onUpdate: onUpdate).getWidget(context);
    widgetGrafikBar() {
      return FutureBuilder(
        future: data.arrayBarChart, 
        builder: (context, snapshot){
          if (snapshot.hasData){
            return GrafikBar(
                jenisTransaksi: data.jenisTransaksi, 
                waktuTransaksi: data.waktuTransaksi,
                dataBarChart: snapshot.data!,
                totalNilai: sumList((snapshot.data!).map((e) => e.yValue).toList()),
            );
          } else {
            return const CircularProgressIndicator();
          }
        }
      );
    }
    
    List<Widget> ifSingleTransaction(){
      return [
        widgetTabWaktuTransaksi(),
        dummyPadding(height: 10),
        widgetGrafikBar(),
      ];
    }

    List<Widget> ifNotSingleTransaction(){
      return [
        widgetTabJenisTransaksi(),
        dummyPadding(height: 10),
        widgetTabWaktuTransaksi(),
        dummyPadding(height: 10),
        widgetGrafikBar(),
      ];
    }

    return Column(
      children: (isSingleTransaction != null && isSingleTransaction == true) ? ifSingleTransaction() : ifNotSingleTransaction()
    );
  }
}