import 'package:flutter/material.dart';
import 'package:keuanganku/app/routes/main/bottom_bar.dart';
import 'package:keuanganku/app/routes/main/beranda/beranda.dart';
import 'package:keuanganku/app/routes/main/body.dart';
import 'package:keuanganku/app/routes/main/drawer.dart';
import 'package:keuanganku/app/routes/main/pengeluaran/pengeluaran.dart';
import 'package:keuanganku/app/routes/main/wallet/wallet.dart';

class Data {
  bool _init = false;
  init(GlobalKey<ScaffoldState> scState, void Function() updateState){
    if(_init) return;
    listMainPagePages = [
        HalamanBeranda(
          parentScaffoldKey: scState,
          updateParentState: updateState,),
        HalamanPengeluaran(
          parentScaffoldKey: scState,
        ),
        HalamanWallet(
          parentScaffoldKey: scState,
        ),
    ];
    _init = true;
  }
  
  /// Variabel ini menyimpan list halaman untuk halaman 'MainPage'
  late final List<Widget> listMainPagePages;

  /// Indeks halaman terbaru
  int currentIndex = 0;
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  static Data data = Data();

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    super.initState();
  }
 
  /// Controller untuk mengatur halaman
  final PageController _pageController = PageController();

  /// Kunci scaffold
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void updateThisState(){
    setState(() {
      HalamanBeranda.state.update!();
      HalamanPengeluaran.state.update!();
    });
  }

  /// Fungsi yang dipanggil ketika indeks/halaman berubah
  void onPageChanged(int index) {
    setState(() {
      MainPage.data.currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    MainPage.data.init(_scaffoldKey, updateThisState);
    return Scaffold(
        key: _scaffoldKey,
        drawer: const AppDrawer(),
        // appBar: AppTopBar(scaffoldKey: _scaffoldKey, index: MainPage.data.currentIndex).getWidget(context),
        body: AppBody(
          onPageChanged: onPageChanged,
          pageController: _pageController,
          body: MainPage.data.listMainPagePages,
        ).getWidget(),
        bottomNavigationBar:AppBottomNavBar(MainPage.data.currentIndex, _pageController).getWidget()
    );
  }
}