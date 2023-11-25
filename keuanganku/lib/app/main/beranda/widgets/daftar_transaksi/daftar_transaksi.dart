import 'package:flutter/material.dart';
import 'package:keuanganku/app/main/beranda/beranda.dart';
import 'package:keuanganku/database/model/data_transaksi.dart';
import 'package:keuanganku/database/model/kategori.dart';
import 'package:keuanganku/enum/data_transaksi.dart';
import 'package:keuanganku/app/app_colors.dart';
import 'package:keuanganku/app/main/beranda/widgets/daftar_transaksi/widgets/card_data_transaksi/card_data_transaksi.dart';
import 'package:keuanganku/app/main/wrap.dart';
import 'package:keuanganku/main.dart';

class Data {
  SortirTransaksi sortir = SortirTransaksi.Terbaru;
  List<String> menuSortir = [
    "Terbaru",
    "Terlama",
    "Tertinggi",
    "Terendah"
  ];
  List<DataTransaksi> listTransaksi = [
    DataTransaksi(
      id: 1, 
      judul: "Mama Mia", 
      deskripsi: "Beli mama mia lezatos", 
      nilai: 200000, 
      waktu: DateTime(2003, 12, 15, 23, 0), 
      kategoriTransaksi: KategoriTransaksi(
          id:1,
          judul: "Mama Mia"
      ),
      jenisTransaksi: JenisTransaksi.PEMASUKAN
    ),
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
  static Data data = Data();
  BuildContext context;
  DaftarTransaksi(this.context);

  Widget getWidget(){
    var size = MediaQuery.sizeOf(context);
    
    // EVENTS
    void ketikaDropDownBerubah(dynamic newVal) {
      DaftarTransaksi.data.sortir = DaftarTransaksi.data.getEnumSortir(newVal);
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
        value: DaftarTransaksi.data.sortir.enumValue,
        items: getDropDownMenuItems(),
        onChanged: ketikaDropDownBerubah
      );
    }
    
    return
    wrapWithPadding(
      context,
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(
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
              const SizedBox(height: 15,),
              for(int i = 0; i < DaftarTransaksi.data.listTransaksi.length; i++) 
                CardTransaksi(const Icon(Icons.store), dataTransaksi: DaftarTransaksi.data.listTransaksi[i], width: 40, height: 40,),
            ],
          ),
          ),
      ),
    );
  }
}