import 'package:flutter/material.dart';


class _StateCache {
  static List<bool> buttonBoolean = [true, false];
}

class _ObjectProperty {
  // ignore: non_constant_identifier_names
  static Color warna_background_tombol_terpilih = const Color(0xff3D4E89);
  // ignore: non_constant_identifier_names
  static Color warna_background_tombol_tdkterpilh = const Color(0xffE0E4F5);
  
  // ignore: non_constant_identifier_names, constant_identifier_names
  static const Color warna_font = Colors.white;
  // ignore: constant_identifier_names
  static const Color warna_font_tdkterpilh = Color(0xff868996);

  static buttonStyle(bool what) => FilledButton.styleFrom(
    backgroundColor: what? 
      warna_background_tombol_terpilih : 
      warna_background_tombol_tdkterpilh,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10)
    ),
  );

  static textStyle(bool what) => TextStyle(
    fontFamily: "QuickSand_Medium",
    fontSize: 13,
    color: what? warna_font :  warna_font_tdkterpilh
  );

  static const buttonPadding = EdgeInsets.only(right: 10);
}

class TombolWaktu extends StatefulWidget {
  const TombolWaktu({super.key, required this.onChange});
  final void Function(int index) onChange;

  @override
  State<TombolWaktu> createState() => _TombolWaktuState();
}

class _TombolWaktuState extends State<TombolWaktu> {
  void _onChanged(int index){
    setState(() {
      // task 1
      _StateCache.buttonBoolean = [false, false];
      _StateCache.buttonBoolean[index] = true;      

      // task 2
      widget.onChange(index);
    });
  }

  Widget getButton(int index, String judul){
    const double ukuranTinggiTombol = 30;
    return Padding(
     padding: _ObjectProperty.buttonPadding,
      child: SizedBox(
        height: ukuranTinggiTombol,
        child: FilledButton(
          onPressed: (){
            _onChanged(index);
          }, 
          style: _ObjectProperty.buttonStyle(_StateCache.buttonBoolean[index]),
          child: Text(
            judul, 
            style: _ObjectProperty.textStyle(_StateCache.buttonBoolean[index]),
          )
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        getButton(0, "Minggu Ini"),
        getButton(1, "Bulan Ini")
      ],
    );
  }
}
