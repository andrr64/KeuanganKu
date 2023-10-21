import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keuanganku/android_system.dart';
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
  final List<Widget> _screens = [
    const HalamanBeranda(),
    const HalamanPengeluaran(),
    const HalamanWallet(),
    const HalamanTentang(),
  ];
  int _currentIndex = 0;

  // ignore: non_constant_identifier_names, unused_element
  void _state_onIndexChanged(int index) {
    setState(() {
      AndroidSys.setNotificationBarColor();
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Variable : List tombol bottom navbar
    List<BottomNavigationBarItem> bottomNavBarItems = [
      BottomNavigationBarItem(
        icon: Icon(_currentIndex == 0? Icons.analytics : Icons.analytics_outlined),
        label: "Analisis"),
        
      BottomNavigationBarItem(
        icon: Icon(_currentIndex == 1? CupertinoIcons.money_dollar_circle_fill : CupertinoIcons.money_dollar_circle),
        label: "Pengeluaran"),

      BottomNavigationBarItem(
        icon: Icon(_currentIndex == 2? Icons.account_balance_wallet : Icons.account_balance_wallet_outlined),
        label: "Wallet"),

      BottomNavigationBarItem(
        icon: Icon(_currentIndex == 3? Icons.info : Icons.info_outline),
        label: "Tentang"),
    ];

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Warna.warna_primer,
        unselectedItemColor: Warna.warna_primer_50,
        currentIndex: _currentIndex,
        items: bottomNavBarItems,
        onTap: _state_onIndexChanged,
      ),
    );
  }
}
