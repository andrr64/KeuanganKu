import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  static final List<Widget> _screens = [
    const HalamanBeranda(),
    const HalamanPengeluaran(),
    const HalamanWallet(),
    const HalamanTentang(),
  ];

  Color? warna = Colors.grey[800];

  static int _currentIndex = 0;
  static final List<BottomNavigationBarItem> _listButton = [
    const BottomNavigationBarItem(
        backgroundColor: Warna.warna_primer,
        icon: Icon(CupertinoIcons.home),
        label: "Beranda"),
    const BottomNavigationBarItem(
        backgroundColor: Warna.warna_primer,
        icon: Icon(CupertinoIcons.money_dollar),
        label: "Pengeluaran"),
    const BottomNavigationBarItem(
        backgroundColor: Warna.warna_primer,
        icon: Icon(Icons.wallet),
        label: "Wallet"),
    const BottomNavigationBarItem(
        backgroundColor: Warna.warna_primer,
        icon: Icon(CupertinoIcons.info),
        label: "Tentang"),
  ];

  void _onButtonChange(int index) {
    setState(() {
      const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
      );
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Warna.warna_primer,
          selectedLabelStyle:
              const TextStyle(fontFamily: "Quicksand", fontSize: 12),
          currentIndex: _currentIndex,
          onTap: (index) => _onButtonChange(index),
          items: _listButton),
    );
  }
}
