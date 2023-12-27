import 'package:keuanganku/app/widgets/k_bar_chart_data/k_bar_chart_data.dart';
import 'package:keuanganku/database/helper/income.dart';
import 'package:keuanganku/enum/data_transaksi.dart';
import 'package:keuanganku/main.dart';
import 'package:keuanganku/util/date_util.dart';
import 'package:keuanganku/util/vector_operation.dart';

class WidgetHelperDataPemasukan {
  Future<List<KBarChartXY>> listBarChartPemasukan(WaktuTransaksi waktuTransaksi) async {
    Future<List<KBarChartXY>> getHarian() async {
      List<DateTime> listHari = getHariMingguan();
      List<KBarChartXY> data = [
        for (int i = 0; i < 7; i++)
          KBarChartXY(
            xValue: i.toDouble(),
            yValue: sumList(
              (await SQLHelperIncome()
                      .readDataByDate(listHari[i], db: db.database))
                  .map((e) => e.nilai)
                  .toList(),
            ),
          ),
      ];
      return data;
    }

    Future<List<KBarChartXY>> getBulanan() async {
      int tahun = DateTime.now().year;
      return [
        for (int i = 0; i < 12; i++)
          KBarChartXY(
            xValue: i.toDouble(),
            yValue: sumList(
              (await SQLHelperIncome()
                      .readDataByMonth(tahun, i + 1, db: db.database))
                  .map((e) => e.nilai)
                  .toList(),
            ),
          ),
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
