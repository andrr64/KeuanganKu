import 'package:flutter/material.dart';
import 'package:keuanganku/pages/warna_aplikasi.dart';

class HalamanTentang extends StatefulWidget {
  const HalamanTentang({super.key});

  @override
  State<HalamanTentang> createState() => _HalamanTentangState();
}

class _HalamanTentangState extends State<HalamanTentang> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Warna.warna_primer,
        title: const Text(
          "Tentang",
          style: TextStyle(
              color: Colors.white, fontSize: 24, fontFamily: "QuickSand_Bold"),
        ),
      ),
    );
  }
}
