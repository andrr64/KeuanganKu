import 'package:flutter/material.dart';
import 'package:keuanganku/ui/pages/main/util.dart';
import 'package:keuanganku/ui/state_bridge.dart';
import 'package:keuanganku/ui/application_colors.dart';

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
  dynamic titleAndSelectBox(Size size){
    return
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          width: size.width * 0.9,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Daftar Transaksi",
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: "QuickSand_Bold",
                  color: ApplicationColors.primary
                ),
              ),
              DropdownButton(
                value: DaftarTransaksi.data.dropDownChoosed,
                items: DaftarTransaksi.data.dropwDownMenu.map<DropdownMenuItem<String>>((e) {
                  return DropdownMenuItem<String>(
                    value: e,
                    child: Text(e, style: const TextStyle(color: ApplicationColors.primary, fontSize: 16,fontFamily: "QuickSand_Medium"),),
                  );
                }).toList(),
                onChanged: (newVal){
                  DaftarTransaksi.data.dropDownChoosed = newVal!;
                  DaftarTransaksi.state.update!();
                }
              )
            ],
            ),
          ),
      );
  }
  dynamic listTransaksi(){
    return Container(height: 400,);
  }
}

class DaftarTransaksi extends StatefulWidget {
  const DaftarTransaksi({super.key});

  static Widgets widgets = Widgets();
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
    return wrapWithPadding(
      context,
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DaftarTransaksi.widgets.titleAndSelectBox(size),
          DaftarTransaksi.widgets.listTransaksi()
        ],
      ) 
    );
  }
}