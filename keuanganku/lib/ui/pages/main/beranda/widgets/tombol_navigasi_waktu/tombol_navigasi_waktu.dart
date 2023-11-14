// ignore: file_names
// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

class ObjectProperty {
 Color warna_background_tombol_terpilih = const Color(0xff464D77);
 Color warna_background_tombol_tdkterpilh = const Color(0xffE0E4F5);
  
 final Color warna_font = Colors.white;
 final Color warna_font_tdkterpilh = const Color(0xff868996);

 buttonStyle(bool what) => FilledButton.styleFrom(
    backgroundColor: what? 
      warna_background_tombol_terpilih : 
      warna_background_tombol_tdkterpilh,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10)
    ),
  );

 textStyle(bool what) => TextStyle(
    fontFamily: "QuickSand_Medium",
    fontSize: 13,
    color: what? warna_font :  warna_font_tdkterpilh
  );

 final buttonPadding = const EdgeInsets.only(right: 10);
}

class Data {
  List<bool> buttonBoolean = [true, false];
}

class TombolNavigasiWaktu extends StatefulWidget {
  TombolNavigasiWaktu({super.key, required this.onChange});
  
  final Data data = Data();
  final ObjectProperty objectProperty = ObjectProperty();
  final void Function(int index) onChange;

  @override
  State<TombolNavigasiWaktu> createState() => _TombolNavigasiWaktuState();
}

class _TombolNavigasiWaktuState extends State<TombolNavigasiWaktu> {
  void _onChanged(int index){
    setState(() {
      // task 1
      widget.data.buttonBoolean = [false, false];
      widget.data.buttonBoolean[index] = true;      

      // task 2
      widget.onChange(index);
    });
  }

  Widget getButton(int index, String judul){
    const double ukuranTinggiTombol = 30;
    return Padding(
     padding: widget.objectProperty.buttonPadding,
      child: SizedBox(
        height: ukuranTinggiTombol,
        child: FilledButton(
          onPressed: (){
            _onChanged(index);
          }, 
          style: widget.objectProperty.buttonStyle(widget.data.buttonBoolean[index]),
          child: Text(
            judul, 
            style: widget.objectProperty.textStyle(widget.data.buttonBoolean[index]),
          )
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          getButton(0, "Minggu Ini"),
          getButton(1, "Bulan Ini")
        ],
      ),
    );
  }
}
