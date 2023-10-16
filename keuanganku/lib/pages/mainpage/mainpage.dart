import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keuanganku/pages/mainpage/beranda/beranda.dart';
import 'package:keuanganku/pages/mainpage/pengeluaran/pengeluaran.dart';
import 'package:keuanganku/pages/mainpage/tentang/tentang.dart';
import 'package:keuanganku/pages/mainpage/wallet/wallet.dart';
import 'package:keuanganku/pages/warna_aplikasi.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  static final List<Widget> _buildScreens = [
    const HalamanBeranda(),
    const HalamanPengeluaran(),
    const HalamanWallet(),
    const HalamanTentang(),
  ];

  Color? warna = Colors.grey[800];

  static int currentIndex = 0;
  static final List<BottomNavigationBarItem> _listButton = [
    const BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.home), label: "Beranda"),
    const BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.money_dollar), label: "Pengeluaran"),
    const BottomNavigationBarItem(icon: Icon(Icons.wallet), label: "Wallet"),
    const BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.info), label: "Tentang"),
  ];

  void _onButtonChange(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildScreens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Warna.warna_primer,
          unselectedItemColor: warna,
          selectedLabelStyle:
              const TextStyle(fontFamily: "Quicksand", fontSize: 12),
          currentIndex: currentIndex,
          onTap: (index) => _onButtonChange(index),
          items: _listButton),
    );
  }
}
