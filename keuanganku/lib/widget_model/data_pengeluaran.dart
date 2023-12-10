import 'package:keuanganku/app/reusable_components/bar_chart/data.dart';
import 'package:keuanganku/database/helper/data_pengeluaran.dart';
import 'package:keuanganku/enum/data_transaksi.dart';
import 'package:keuanganku/main.dart';
import 'package:keuanganku/util/date_util.dart';
import 'package:keuanganku/util/vector_operation.dart';

class WidgetHelperDataPengeluaran {
  Future<List<BarChartXY>> listBarChartPengeluaran(WaktuTransaksi waktuTransaksi) async {
  Future<List<BarChartXY>> getHarian() async {
    List<DateTime> listHari = getHariMingguan();
    List<BarChartXY> data = [
      for(int i = 0; i < 7; i++)
        BarChartXY(
          xValue: i.toDouble(), 
          yValue: sumList(
            (await SQLHelperPengeluaran().readDataByDate(listHari[i], db: db.database))
            .map((e) => e.nilai)
              .toList()
          )
        )
    ];
    return data;
  }

  Future<List<BarChartXY>> getBulanan() async {
    int tahun = DateTime.now().year;
    return [
      for(int i = 0; i < 12; i++)
        BarChartXY(
          xValue: i.toDouble(), 
          yValue: sumList(
            (await SQLHelperPengeluaran().readDataByMonth(tahun, i + 1, db: db.database))
            .map((e) => e.nilai)
              .toList()
          )
        )
    ];
  }

  switch (waktuTransaksi) {
    case WaktuTransaksi.Mingguan:
      return await getHarian();
    case WaktuTransaksi.Tahunan:
      return await getBulanan(); 
    default:
      return [];
  }
}
}