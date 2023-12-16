import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:keuanganku/app/reusable_widgets/k_card/k_card.dart';
import 'package:keuanganku/database/model/data_pengeluaran.dart';
import 'package:keuanganku/enum/data_transaksi.dart';
import 'package:keuanganku/util/dummy.dart';
import 'package:keuanganku/util/font_style.dart';
import 'package:keuanganku/util/get_currency.dart';
import 'package:keuanganku/util/vector_operation.dart';

class WidgetData{
  JenisTransaksi jenisTransaksi = JenisTransaksi.Pengeluaran;
}

class DistribusiTransaksi extends StatelessWidget {
  const DistribusiTransaksi({super.key, required this.widgetData});
  final WidgetData widgetData;

  Widget normalBuildAsPengeluaran(List<SQLModelPengeluaran> data){
    return Stack(
      alignment: Alignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 150,
              child: Text(
                formatCurrency(sumList(data.map((e) => e.nilai).toList())),
                textAlign: TextAlign.center,
                style: kFontStyle(fontSize: 16),),
            ),
            Text("Total Pengeluaran",
              style: kFontStyle(
                fontSize: 12,
                family: "QuickSand_Medium"
              ),
            ),
          ],
        ),
        PieChart(
          PieChartData(
            sections: [
              PieChartSectionData(
                color: Colors.blue,
                value: 500,
                showTitle: false
              ),
              PieChartSectionData(
                color: Colors.red,
                value: 40,
                showTitle: false
              ),
              PieChartSectionData(
                color: Colors.green,
                value: 30,
                showTitle: false
              ),
            ],
            borderData: FlBorderData(show: false),
            centerSpaceRadius: 80, // Jari-jari ruang di tengah pie chart
            sectionsSpace: 2.5,
          ),
          swapAnimationDuration: const Duration(milliseconds: 500),
          swapAnimationCurve: Curves.easeInOutCirc,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // Variable
    final icon = SvgPicture.asset(
      "assets/icons/distribusi.svg",
      height: 35,
    );
    final size = MediaQuery.sizeOf(context);
    final width = size.width * 0.875;

    return KCard(
        title: "Distribusi",
        width: width,
        icon: icon,
        child: Column(
          children: [
            Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque nec interdum arcu. In quis erat lacus. Praesent ac cursus arcu, quis congue libero. Praesent viverra laoreet tortor ut sagittis. Nunc iaculis neque ut interdum convallis. ",
              textAlign: TextAlign.justify,
              style: kFontStyle(fontSize: 14, family: "QuickSand_Medium"),
            ),
            dummyPadding(height: 25),
            SizedBox(
              width: width,
              height: 275,
              child: normalBuildAsPengeluaran([]),
            ),
          ],
        )
    );
  }
}