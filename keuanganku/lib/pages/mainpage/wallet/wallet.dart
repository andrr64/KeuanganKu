import 'package:flutter/material.dart';
import 'package:keuanganku/pages/warna_aplikasi.dart';

class HalamanWallet extends StatefulWidget {
  const HalamanWallet({super.key});

  @override
  State<HalamanWallet> createState() => _HalamanWalletState();
}

class _HalamanWalletState extends State<HalamanWallet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Warna.warna_primer,
        title: const Text(
          "Wallet",
          style: TextStyle(
              color: Colors.white, fontSize: 24, fontFamily: "QuickSand_Bold"),
        ),
      ),
    );
  }
}
