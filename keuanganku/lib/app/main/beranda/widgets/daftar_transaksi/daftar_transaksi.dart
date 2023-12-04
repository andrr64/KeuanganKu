import 'package:flutter/material.dart';
import 'package:keuanganku/app/reusable_components/app_bar/app_bar.dart';
import 'package:keuanganku/database/model/data_pengeluaran.dart';
import 'package:keuanganku/app/main/beranda/beranda.dart';
import 'package:keuanganku/app/main/wrap.dart';
import 'package:keuanganku/database/model/data_transaksi.dart';
import 'package:keuanganku/enum/data_transaksi.dart';
import 'package:keuanganku/app/app_colors.dart';
import 'package:keuanganku/app/reusable_components/card_data_transaksi/card_data_transaksi.dart';
import 'package:keuanganku/main.dart';

class Properties {
  SortirTransaksi sortir = SortirTransaksi.Terbaru;
  List<String> menuSortir = [
    "Terbaru",
    "Terlama",
    "Tertinggi",
    "Terendah"
  ];
  List<ModelDataPengeluaran> listTransaksi = [

  ];

  SortirTransaksi getEnumSortir(String val){
    switch(val){
      case "Terbaru":
        return SortirTransaksi.Terbaru;
      case "Terlama":
        return SortirTransaksi.Terlama;
      case "Tertinggi":
        return SortirTransaksi.Tertinggi;
      case "Terendah":
        return SortirTransaksi.Terendah;
      default:
        return SortirTransaksi.Terbaru;
    }
  }
}

class DaftarTransaksi {
  static Properties properties = Properties();
  BuildContext context;
  DaftarTransaksi(this.context, {required this.listData});

  List<DataTransaksi> listData;

  Widget getWidget(){
    var size = MediaQuery.sizeOf(context);
    
    // EVENTS
    void ketikaDropDownBerubah(dynamic newVal) {
      properties.sortir = properties.getEnumSortir(newVal);
      HalamanBeranda.state.update!();
    }

    // WIDGETS
    List<DropdownMenuItem> getDropDownMenuItems(){
      return SortirTransaksi.values.map<DropdownMenuItem<String>>((item){
        return DropdownMenuItem<String>(
          value: item.enumValue,
          child: Text(item.enumValue, style: const TextStyle(color: ApplicationColors.primary, fontSize: 16,fontFamily: "QuickSand_Medium"),), 
        );
      }).toList();
    }
    
    Widget widgetCardListTransaksi(){
      Widget ketikaAdaData(){
        return
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: listData.length,
            itemBuilder: (context, index) => 
            CardTransaksi(
              const Icon(Icons.store),
              onPressed: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context){
                    return Scaffold(
                      appBar: KAppBar(title: "Detail Transaksi").getWidget(),
                    );
                  })
                );
              },
              kategori: listData[index].judul!,
              title: listData[index].judul!,
              waktu: listData[index].waktu!.toIso8601String(),
              jumlah: listData[index].nilai!,
            ),
          );
      }

      Widget ketikaTidakAdaData(){
        return SizedBox(
          height: 100,
          width: 0.9 * MediaQuery.sizeOf(context).width,
          child: Center(
            child: Text("Tidak ada data",
              style: TextStyle(
                  fontFamily: "QuickSand_Bold",
                  fontSize: 16,
                  color: ApplicationColors.primaryColorWidthPercentage(percentage: 75)
              ),
            ),
          ),
        );
      }

      return listData.isNotEmpty? ketikaAdaData() : ketikaTidakAdaData();
    }

    Widget widgetJudul (){
      return  
      const Text("Daftar Transaksi",
        style: TextStyle(
          fontSize: 20,
          fontFamily: "QuickSand_Bold",
          color: ApplicationColors.primary
        )
      );
    }
    Widget widgetTombolDropDown(){
       return 
       DropdownButton(
        value: properties.sortir.enumValue,
        items: getDropDownMenuItems(),
        onChanged: ketikaDropDownBerubah
      );
    }
    Widget widgetListTransaksi() => widgetCardListTransaksi();
    
    return
    SizedBox(
      width: size.width * 0.9,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              widgetJudul(),
              widgetTombolDropDown(),
            ],
          ),
          padding(),
          widgetListTransaksi()
        ],
      ),
    );
  }
}