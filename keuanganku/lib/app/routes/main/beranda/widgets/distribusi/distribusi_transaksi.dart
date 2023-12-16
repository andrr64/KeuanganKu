import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:keuanganku/app/reusable_widgets/k_card/k_card.dart';
import 'package:keuanganku/app/reusable_widgets/k_empty/k_empty.dart';
import 'package:keuanganku/database/helper/data_pengeluaran.dart';
import 'package:keuanganku/database/model/data_kategori.dart';
import 'package:keuanganku/database/model/data_pengeluaran.dart';
import 'package:keuanganku/enum/data_transaksi.dart';
import 'package:keuanganku/main.dart';
import 'package:keuanganku/util/dummy.dart';
import 'package:keuanganku/util/font_style.dart';
import 'package:keuanganku/util/get_currency.dart';
import 'package:keuanganku/util/vector_operation.dart';

class WidgetData{
  JenisTransaksi jenisTransaksi = JenisTransaksi.Pengeluaran;
  WaktuTransaksi waktuTransaksi = WaktuTransaksi.Mingguan;
  List<Map<String, dynamic>> infoPieChar = [
    // it's just example
     {
      "nama" : 'Transportasi',
      "persentase" : 23.2,
      "nilai" : 200000,
      "warna" : Colors.white
    }
  ];
  Future<dynamic> getData() async {
    return SQLHelperPengeluaran().readByWaktu(waktuTransaksi, db: db.database);
  }
  Color _randomColor() {
    Random random = Random();
    return Color.fromARGB(
      255,
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
    );
  }
    
  Future<List<PieChartSectionData>> getPieData(List<SQLModelPengeluaran> pengeluaran) async {
    Map<String, double> pieMap = {};
    double totalPengeluaran = sumList(pengeluaran.map((e) => e.nilai).toList());
    infoPieChar = [];

    for (var i = 0; i < pengeluaran.length; i++) {
      SQLModelKategoriTransaksi? ktg = await pengeluaran[i].kategori;
      
      if (pieMap.containsKey(ktg.judul)) {
        pieMap[ktg.judul] = pieMap[ktg.judul]! + pengeluaran[i].nilai;
      } else {
        pieMap[ktg.judul] = pengeluaran[i].nilai;
      }
    }
    return pieMap.entries.map((entry) {
      final Color color = _randomColor();
      double persentase = (entry.value / totalPengeluaran) * 100;
      String  key  =  entry.key;
      infoPieChar.add({
        "nama": key,
        "persentase" : persentase,
        "warna": color,
        "nilai": entry.value
      });
      return PieChartSectionData(
        value: entry.value,
        title: entry.key,
        color: color,
        showTitle: false,
      );
    }).toList();
  }
}

class DistribusiTransaksi extends StatelessWidget {
  const DistribusiTransaksi({super.key, required this.widgetData});
  final WidgetData widgetData;

  Widget secondStep(List<SQLModelPengeluaran> dataPengeluaran, List<PieChartSectionData> dataSection){
    return Column(
      children: [
        Container(
          alignment: Alignment.topCenter,
          height: 275,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 150,
                    child: Text(
                      formatCurrency(sumList(dataPengeluaran.map((e) => e.nilai).toList())),
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
                  sections: dataSection,
                  borderData: FlBorderData(show: false),
                  centerSpaceRadius: 80, // Jari-jari ruang di tengah pie chart
                  sectionsSpace: 2.5,
                ),
                swapAnimationDuration: const Duration(milliseconds: 500),
                swapAnimationCurve: Curves.easeInOutCirc,
              ),
            ],
          ),
        ),    
        SizedBox(
          child: Column(
            children: [
              for(int i = 0; i < widgetData.infoPieChar.length; i++)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(color: widgetData.infoPieChar[i]['warna'], width: 10, height: 10,),
                        const SizedBox(width: 10,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(widgetData.infoPieChar[i]['nama'], style: kFontStyle(fontSize: 14),),
                            Text(percentageFormat(widgetData.infoPieChar[i]['persentase']), style: kFontStyle(fontSize: 12, family: "QuickSand_Medium"),),
                          ],
                        ),
                      ],
                    ),
                    Text(formatCurrency(widgetData.infoPieChar[i]['nilai']), style: kFontStyle(fontSize: 15),)
                  ],
                )
            ],
          ),
        )
      ],
    );
  }
  Widget firstStep(List<SQLModelPengeluaran> dataPengeluaran){  
    return FutureBuilder(
      future: widgetData.getPieData(dataPengeluaran), 
      builder: (_, snapshot){
        if (snapshot.connectionState == ConnectionState.waiting){
          return makeCenterWithRow(child: const CircularProgressIndicator());
        } else if (snapshot.hasError){
          return makeCenterWithRow(child: const Text("Sadly, something wrong..."));
        } else {
          return snapshot.data!.isNotEmpty? secondStep(dataPengeluaran, snapshot.data!) : const KEmpty();
        }
      }
    );
  }
  Widget buildBody(){
    return FutureBuilder(
      future: widgetData.getData(), 
      builder: (_, snapshot){
        if(snapshot.connectionState == ConnectionState.waiting){
          return const CircularProgressIndicator();
        }
        else if (snapshot.hasError){
          return makeCenterWithRow(child: const Text("SQL Error :("));
        }
        else {
          return (snapshot.data! as List).isNotEmpty?
          firstStep(snapshot.data!) :
          const KEmpty();
        }
      }
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
        title: "Distribusi Pengeluaran",
        width: width,
        icon: icon,
        child: Column(
          children: [
            buildBody(),
          ],
        )
    );
  }
}