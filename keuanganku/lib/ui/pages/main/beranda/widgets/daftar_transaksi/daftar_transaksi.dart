// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:keuanganku/database/model/data_transaksi.dart';
import 'package:keuanganku/database/model/kategori.dart';
import 'package:keuanganku/enum/data_transaksi.dart';
import 'package:keuanganku/ui/application_colors.dart';
import 'package:keuanganku/ui/pages/main/beranda/widgets/daftar_transaksi/widgets/card_data_transaksi.dart';
import 'package:keuanganku/ui/pages/main/wrap.dart';
import 'package:keuanganku/ui/state_bridge.dart';

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

  String getSortirString(SortirTransaksi val) {
    switch (val) {
      case SortirTransaksi.Terbaru:
        return "Terbaru";
      case SortirTransaksi.Terlama:
        return "Terlama";
      case SortirTransaksi.Tertinggi:
        return "Tertinggi";
      case SortirTransaksi.Terendah:
        return "Terendah";
    }
  }
}

class DaftarTransaksi extends StatefulWidget {
  const DaftarTransaksi({super.key});
  
  static Data data = Data();
  static StateBridge state = StateBridge();

  @override
  State<DaftarTransaksi> createState() => _DaftarTransaksiState();
}

class _DaftarTransaksiState extends State<DaftarTransaksi> {
  @override
  Widget build(BuildContext context) {
    DaftarTransaksi.state.init(() {
      setState(() {
        
      });
    });
    
    var size = MediaQuery.sizeOf(context);
    
    // EVENTS
    void ketikaDropDownBerubah(String newVal) => DaftarTransaksi.data.sortir = DaftarTransaksi.data.getEnumSortir(newVal);

    // WIDGETS
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
        value: DaftarTransaksi.data.getSortirString(DaftarTransaksi.data.sortir),
        items: DaftarTransaksi.data.menuSortir.map<DropdownMenuItem<String>>((e) {
          return DropdownMenuItem<String>(
            value: e,
            child: Text(e, style: const TextStyle(color: ApplicationColors.primary, fontSize: 16,fontFamily: "QuickSand_Medium"),),
          );
        }).toList(),
        onChanged: (newVal){
          ketikaDropDownBerubah(newVal!);
          DaftarTransaksi.state.update!();
        }
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