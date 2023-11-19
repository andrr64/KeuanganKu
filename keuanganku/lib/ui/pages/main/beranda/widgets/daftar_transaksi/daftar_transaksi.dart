import 'package:flutter/material.dart';
import 'package:keuanganku/ui/pages/main/util.dart';
import 'package:keuanganku/ui/warna_aplikasi.dart';

class Data {
  Data(){
    dropDownChoosed = dropwDownMenu[0];
  }
  List dropwDownMenu = [
    "Terbaru",
    "Terlama",
    "Tertinggi",
    "Terendah"
  ];
  String dropDownChoosed = "";
}

class Widgets {
  dynamic getTitleAndSelectBox(Size size, Function() updateState){
    return
      SizedBox(
        width: size.width * 0.9,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Daftar Transaksi",
              style: TextStyle(
                fontSize: 20,
                fontFamily: "QuickSand_Bold",
                color: Warna.primaryColor
              ),
            ),
            DropdownButton(
              value: DaftarTransaksi.data.dropDownChoosed,
              items: DaftarTransaksi.data.dropwDownMenu.map<DropdownMenuItem<String>>((e) {
                return DropdownMenuItem<String>(
                  value: e,
                  child: Text(e, style: const TextStyle(color: Warna.primaryColor, fontSize: 16,fontFamily: "QuickSand_Medium"),),
                );
              }).toList(),
              onChanged: (newVal){
                DaftarTransaksi.data.dropDownChoosed = newVal!;
                updateState();
              }
            )
          ],
          ),
        );
  }
  dynamic getListTransaksi(){
    return Container(height: 400,);
  }
}

class DaftarTransaksi extends StatefulWidget {
  const DaftarTransaksi({super.key, required this.updateRootState});
  final void Function() updateRootState;
  
  static Widgets widgets = Widgets();
  static Data data = Data();

  @override
  State<DaftarTransaksi> createState() => _DaftarTransaksiState();
}

class _DaftarTransaksiState extends State<DaftarTransaksi> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return wrapWithPadding(
      context,
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DaftarTransaksi.widgets.getTitleAndSelectBox(size, widget.updateRootState),
          DaftarTransaksi.widgets.getListTransaksi()
        ],
      ) 
    );
  }
}