import 'package:flutter/material.dart';
import 'package:keuanganku/pages/routes.dart';
import 'package:keuanganku/pages/warna_aplikasi.dart';

class HalamanBeranda extends StatefulWidget {
  const HalamanBeranda({super.key});

  @override
  State<HalamanBeranda> createState() => _HalamanBerandaState();
}

class _HalamanBerandaState extends State<HalamanBeranda> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Warna.warna_primer,
        title: const Text(
          "Beranda",
          style: TextStyle(
              color: Colors.white, fontSize: 24, fontFamily: "QuickSand_Bold"),
        ),
      ),
    );
  }
}
