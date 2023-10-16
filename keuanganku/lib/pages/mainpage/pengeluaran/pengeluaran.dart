import 'package:flutter/material.dart';
import 'package:keuanganku/pages/warna_aplikasi.dart';

class HalamanPengeluaran extends StatefulWidget {
  const HalamanPengeluaran({super.key});

  @override
  State<HalamanPengeluaran> createState() => _HalamanPengeluaranState();
}

class _HalamanPengeluaranState extends State<HalamanPengeluaran> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Warna.warna_primer,
        title: const Text(
          "Pengeluaran",
          style: TextStyle(
              color: Colors.white, fontSize: 24, fontFamily: "QuickSand_Bold"),
        ),
      ),
    );
  }
}
