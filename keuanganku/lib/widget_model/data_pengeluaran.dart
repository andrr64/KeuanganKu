import 'package:keuanganku/app/reusable_components/bar_chart/data.dart';
import 'package:keuanganku/database/helper/data_pengeluaran.dart';
import 'package:keuanganku/enum/data_transaksi.dart';
import 'package:keuanganku/main.dart';
import 'package:keuanganku/util/date_util.dart';
import 'package:keuanganku/util/vector_operation.dart';

class WidgetModelDataPengeluaran {
  Future<List<BarChartXY>> listBarChartPengeluaran(WaktuTransaksi waktuTransaksi) async {
  Future<List<BarChartXY>> getHarian() async {
    List<DateTime> listHari = getHariMingguan();
    return [
      for(int i = 0; i < 7; i++)
        BarChartXY(
          xValue: i.toDouble(), 
          yValue: sumList(
            (await SQLDataPengeluaran().readDataByDate(listHari[i], db: db.database))
            .map((e) => e.nilai!)
              .toList()
          )
        )
    ];
  }
  Future<List<BarChartXY>> getBulanan() async {
    int tahun = DateTime.now().year;
    return [
      for(int i = 0; i < 12; i++)
        BarChartXY(
          xValue: i.toDouble(), 
          yValue: sumList(
            (await SQLDataPengeluaran().readDataByMonth(tahun, i + 1, db: db.database))
            .map((e) => e.nilai!)
              .toList()
          )
        )
    ];
  }

  switch (waktuTransaksi) {
    case WaktuTransaksi.MingguIni:
      return await getHarian();
    case WaktuTransaksi.TahunIni:
      return await getBulanan(); 
    default:
      return [];
  }
}
}