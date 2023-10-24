import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ObjectProperty {
  // ignore: non_constant_identifier_names
  // static Color warna_background_scaffold = const Color(0xffEFF4F8);
  // ignore: non_constant_identifier_names
  static Color warna_background_scaffold = Colors.white;
  static Color warnaFont = const Color(0xff3F4245);
  static AppBar appBar = AppBar(
        systemOverlayStyle: 
          const SystemUiOverlayStyle(
            statusBarColor:  Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
          ),
        title: Text(
            "Pengeluaran",
            style: TextStyle(
              color: ObjectProperty.warnaFont,
              fontFamily: "Inter_Bold",
              fontSize: 34,
            ),
          ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      );

}

class HalamanPengeluaran extends StatefulWidget {
  const HalamanPengeluaran({super.key});

  @override
  State<HalamanPengeluaran> createState() => _HalamanPengeluaranState();
}

class _HalamanPengeluaranState extends State<HalamanPengeluaran> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ObjectProperty.appBar
    );
  }
}
