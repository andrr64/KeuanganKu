import 'package:flutter/material.dart';
import 'package:keuanganku/ui/pages/main/main_bottom_navigation_bar.dart';
import 'package:keuanganku/ui/pages/main/main_app_bar.dart';
import 'package:keuanganku/ui/pages/main/keep_alive.dart';
import 'package:keuanganku/ui/pages/main/beranda/beranda.dart';
import 'package:keuanganku/ui/pages/main/main_body.dart';
import 'package:keuanganku/ui/pages/main/main_drawer.dart';
import 'package:keuanganku/ui/pages/main/pengeluaran/pengeluaran.dart';
import 'package:keuanganku/ui/pages/main/to_pay/to_pay.dart';
import 'package:keuanganku/ui/pages/main/wallet/wallet.dart';

class Properties {
  Color primaryColor = const Color(0xff383651);
}

class Data {
  final List<Widget> listRootPageChild = [
    KeepAlivePage(child: HalamanRingkasan()),
    const KeepAlivePage(child: HalamanPengeluaran()),
    const KeepAlivePage(child: HalamanWallet()),
    const KeepAlivePage(child: Scaffold()),
  ];
  int indeksTerbaru = 0;
  final List<String> appBarTitle = [
    "Ringkasan",
    "Pengeluaran",
    "Wallet",
    "To-Do"
  ];
}

class MainPage extends StatefulWidget {
  MainPage({super.key});
  final Properties properties = Properties();
  final Data data = Data();

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final PageController _pageController = PageController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final List<Widget> _listBody = [
    KeepAlivePage(child: HalamanRingkasan()),
    const KeepAlivePage(child: HalamanPengeluaran()),
    const KeepAlivePage(child: HalamanWallet()),
    const KeepAlivePage(child: HalamanToPay())
  ];

  dynamic onPageChanged(int index) {
    setState(() {
      widget.data.indeksTerbaru = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: DrawerAplikasi(),
      appBar: BarAplikasi(scaffoldKey: _scaffoldKey, index: widget.data.indeksTerbaru).getWidget(context),
      body: MainBody(
        onPageChanged: onPageChanged, 
        pageController: _pageController, 
        body: _listBody,
      ).getWidget(),
      bottomNavigationBar: AppBottomNavigationBar(widget.data.indeksTerbaru, _pageController).getWidget()
    );
  }
}