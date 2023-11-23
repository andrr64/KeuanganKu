import 'package:flutter/material.dart';
import 'package:keuanganku/ui/pages/main/main_bottom_navigation_bar.dart';
import 'package:keuanganku/ui/pages/main/main_app_bar.dart';
import 'package:keuanganku/ui/pages/main/keep_alive.dart';
import 'package:keuanganku/ui/pages/main/beranda/beranda.dart';
import 'package:keuanganku/ui/pages/main/main_body.dart';
import 'package:keuanganku/ui/pages/main/main_drawer.dart';
import 'package:keuanganku/ui/pages/main/pengeluaran/pengeluaran.dart';
import 'package:keuanganku/ui/pages/main/wallet/wallet.dart';

class Properties {
  Color primaryColor = const Color(0xff383651);
}

class Data {
  bool _init = false;
  init(void Function() updateState){
    if(_init) return;
    listMainPagePages = [
        KeepAlivePage(child: HalamanBeranda(updateParentState: updateState,)),
        KeepAlivePage(child: HalamanPengeluaran()),
        KeepAlivePage(child: HalamanWallet()),
        KeepAlivePage(child: Scaffold()),
    ];
    _init = true;
  }
  
  /// Variabel ini menyimpan list halaman untuk halaman 'MainPage'
  late final List<Widget> listMainPagePages;

  /// Indeks halaman terbaru
  int currentIndex = 0;
}

class MainPage extends StatefulWidget {
  MainPage({super.key});
  final Properties properties = Properties();
  
  static Data data = Data();

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    super.initState();
    MainPage.data.init(updateThisState);
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
  dynamic onPageChanged(int index) {
    setState(() {
      MainPage.data.currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        drawer: ApplicationDrawer(),
        appBar: ApplicationBar(scaffoldKey: _scaffoldKey, index: MainPage.data.currentIndex).getWidget(context),
        body: ApplicationMainBody(
          onPageChanged: onPageChanged,
          pageController: _pageController,
          body: MainPage.data.listMainPagePages,
        ).getWidget(),
        bottomNavigationBar:ApplicatioBottomNavBar(MainPage.data.currentIndex, _pageController).getWidget()
    );
  }
}