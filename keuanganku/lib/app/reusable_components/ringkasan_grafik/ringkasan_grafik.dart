import 'package:flutter/material.dart';
import 'package:keuanganku/app/app_colors.dart';
import 'package:keuanganku/app/reusable_components/ringkasan_grafik/widgets/grafik_bar/grafik_bar_mingguan.dart';
import 'package:keuanganku/app/reusable_components/ringkasan_grafik/widgets/grafik_bar/grafik_bar_tiap_bulan.dart';
import 'package:keuanganku/enum/data_transaksi.dart';
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
      case JenisTransaksi.Pemasukan:
        return await WidgetModelDataPengeluaran().listBarChartPengeluaran(waktuTransaksi);
      case JenisTransaksi.Pengeluaran:
        return await WidgetModelDataPengeluaran().listBarChartPengeluaran(waktuTransaksi);
      default:
        return [];
    }
  }

  JenisTransaksi jenisTransaksi = JenisTransaksi.Pemasukan;
  WaktuTransaksi waktuTransaksi = WaktuTransaksi.Mingguan;
}

class RuCGrafikBarRingkasanTransaksi{
  RuCGrafikBarRingkasanTransaksi(this.context,
    {
      required this.title,
      required this.data, 
      this.isSingleTransaction, 
      required this.onUpdate
    });
  RuCRingkasanGrafikData data;
  BuildContext context;
  bool? isSingleTransaction;
  VoidCallback onUpdate;
  String title;

  Widget getWidget(){
    // WIDGETS
    widgetTabJenisTransaksi() => TabJenisTransaksi(indeksTab: data.indeksTabJenisTransaksi, data: data, onUpdate: onUpdate,);
    widgetTabWaktuTransaksi() => TabWaktuTransaksi(indeksWaktuTransaksi: data.indeksTabWaktuTransaksi, data: data, onUpdate: onUpdate).getWidget(context);
    Widget getTitleWidget(List<BarChartXY> data) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontFamily: "QuickSand_Medium",
              fontSize: 15,
              color: ApplicationColors.primary
            ),
          ), 
          Text(
            formatCurrency(sumList(data.map((e) => e.yValue).toList())),
            style: const TextStyle(
              fontFamily: "QuickSand_Bold",
              fontSize: 15,
              color: ApplicationColors.primary
            ),
          ),
        ],
      );
    }

    Widget widgetGrafikBar() {
      Widget widgetLoading() {
        return const SizedBox(
          height: 200,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      }
      Widget buildBody(List<BarChartXY> chartData){
        Widget whatGraph(){
          if (data.waktuTransaksi == WaktuTransaksi.Mingguan){
            return GrafikBarMingguan(dataBarChart: chartData);
          } else {
            return GrafikBarTahunan(dataBarChart: chartData);
          }
        }
        return 
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            getTitleWidget(chartData),
            dummyPadding(height: 20),
            whatGraph(),
          ],
        );
      }
      
      return FutureBuilder(
        future: data.arrayBarChart,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<BarChartXY> chartData = snapshot.data!;
            if (chartData.length == 7 && data.waktuTransaksi == WaktuTransaksi.Mingguan) {
              return buildBody(chartData);
            } else if (chartData.length == 12 && data.waktuTransaksi == WaktuTransaksi.Tahunan) {
              return buildBody(chartData);
            } else {
              return widgetLoading();
            }
          } else {
            return const CircularProgressIndicator();
          }
        },
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