// ignore: file_names
import 'package:flutter/material.dart';

class StateCache {
  static List<bool> buttonBoolean = [true, false, false];
}

class ObjectProperty {
  // ignore: non_constant_identifier_names
  static Color warna_background_tombol_terpilih = const Color(0xff3F4245);
  // ignore: non_constant_identifier_names
  static Color warna_background_tombol_tdkterpilh = const Color(0xffE0E4F5);
  
  // ignore: non_constant_identifier_names, constant_identifier_names
  static const Color warna_font = Colors.white;
  // ignore: constant_identifier_names
  static const Color warna_font_tdkterpilh = Color(0xff3F4245);

  static buttonStyle(bool what) => FilledButton.styleFrom(
    backgroundColor: what? 
      warna_background_tombol_terpilih : 
      warna_background_tombol_tdkterpilh,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10)
    ),
  );

  static textStyle(bool what) => TextStyle(
    fontFamily: "Inter",
    fontSize: 13,
    color: what? warna_font :  warna_font_tdkterpilh
  );

  static const buttonPadding = EdgeInsets.only(right: 10);
}

class TombolNavigasiWaktu extends StatefulWidget {
  const TombolNavigasiWaktu({super.key});

  @override
  State<TombolNavigasiWaktu> createState() => _TombolNavigasiWaktuState();
}

class _TombolNavigasiWaktuState extends State<TombolNavigasiWaktu> {
  void _onChanged(int index){
    setState(() {
      // task 1
      StateCache.buttonBoolean = [false, false, false];
      StateCache.buttonBoolean[index] = true;      

      // task 2
      switch (index) {
        case 0:
          break;
        case 1:
          break;
        case 2:
          break;
        default:
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding (
          padding: ObjectProperty.buttonPadding,
          child: SizedBox(
            height: 30,
            child: FilledButton(
              onPressed: (){
                _onChanged(0);
              }, 
              style: ObjectProperty.buttonStyle(StateCache.buttonBoolean[0]),
              child: Text(
                "Harian", 
                style: ObjectProperty.textStyle(StateCache.buttonBoolean[0]),
              )
            ),
          ),
        ),
        
        Padding (
          padding: ObjectProperty.buttonPadding,
          child: SizedBox(
            height: 30,
            child: FilledButton(
              onPressed: (){
                _onChanged(1);
              }, 
              style: ObjectProperty.buttonStyle(StateCache.buttonBoolean[1]),
              child: Text(
                "Mingguan", 
                style: ObjectProperty.textStyle(StateCache.buttonBoolean[1]),
              )
            ),
          ),
        ),
        
        Padding (
          padding: ObjectProperty.buttonPadding,
          child: SizedBox(
            height: 30,
            child: FilledButton(
              onPressed: (){
                _onChanged(2);
              }, 
              style: ObjectProperty.buttonStyle(StateCache.buttonBoolean[2]),
              child: Text(
                "Bulanan", 
                style: ObjectProperty.textStyle(StateCache.buttonBoolean[2]),
              )
            ),
          )
        ),
      ],
    );
  }
}