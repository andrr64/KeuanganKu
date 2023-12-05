import 'package:flutter/material.dart';
import 'package:keuanganku/database/model/data_transaksi.dart';
import 'package:keuanganku/enum/data_transaksi.dart';
import 'package:keuanganku/app/app_colors.dart';
import 'package:keuanganku/app/reusable_components/card_data_transaksi/card_data_transaksi.dart';
import 'package:keuanganku/main.dart';
import 'package:keuanganku/util/dummy.dart';

class Data {
  
}

class Properties {
  SortirTransaksi sortir = SortirTransaksi.Terbaru;
  List<String> menuSortir = [
    "Terbaru",
    "Terlama",
    "Tertinggi",
    "Terendah"
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

class RuCDaftarTransaksi {
  Properties properties = Properties();
  BuildContext context;
  String? judul;
  RuCDaftarTransaksi(this.context, {
    required this.listData, 
    required this.eventDropDown,
    required this.onClicked,
    this.judul,}
  );
  void Function() eventDropDown;
  void Function() onClicked;

  List<DataTransaksi> listData;

  Widget getWidget(){
    var size = MediaQuery.sizeOf(context);
    
    // EVENTS
    void ketikaDropDownBerubah(dynamic newVal) {
      properties.sortir = properties.getEnumSortir(newVal);
      
    }

    // WIDGETS
    List<DropdownMenuItem> getDropDownMenuItems(){
      return SortirTransaksi.values.map<DropdownMenuItem<String>>((item){
        return DropdownMenuItem<String>(
          value: item.enumValue,
          child: Text(
            item.enumValue, 
            style: const TextStyle(
              color: ApplicationColors.primary, 
              fontSize: 16,
              fontFamily: "QuickSand_Medium"
            ),
          ), 
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
                onClicked();
              },
              kategori: listData[index].judul!,
              title: listData[index].judul!,
              waktu: listData[index].waktuTerformat,
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
      Text(judul ?? "Daftar Transaksi",
        style: const TextStyle(
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
          dummyPadding(height: 10),
          widgetListTransaksi()
        ],
      ),
    );
  }
}