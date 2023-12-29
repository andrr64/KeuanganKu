import 'package:flutter/material.dart';
import 'package:keuanganku/app/app_colors.dart';
import 'package:keuanganku/app/routes/main/k_bottom_bar.dart';
import 'package:keuanganku/app/routes/main/beranda/beranda.dart';
import 'package:keuanganku/app/routes/main/k_drawer.dart';
import 'package:keuanganku/app/routes/main/keep_alive.dart';
import 'package:keuanganku/app/routes/main/pengeluaran/pengeluaran.dart';
import 'package:keuanganku/app/routes/main/wallet/wallet.dart';
import 'package:keuanganku/app/widgets/k_app_bar/k_app_bar.dart';
import 'package:keuanganku/k_typedef.dart';

class Data {
  bool _init = false;
  init(GlobalKey<ScaffoldState> scState, Function() callback){
    if(_init) return;
    listMainPagePages = [
        KeepAlivePage(
          child: HalamanBeranda(
            callback: callback,
          )),
        KeepAlivePage(
          child: HalamanPengeluaran(parentScaffoldKey: scState,)
        ),
        KeepAlivePage(
          child: HalamanWallet(parentScaffoldKey: scState,)),
    ];
    _init = true;
  }
  List<String> menu = [
    'Beranda',
    'Pengeluaran',
    'Wallet'
  ];
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
  final PageController _pageController = PageController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  KEventHandler     onPageChanged (int index) {
    setState(() {
      MainPage.data.currentIndex = index;
    });
  }
  KApplicationBar   appBar        (){
    return KAppBar(
        title: MainPage.data.menu[MainPage.data.currentIndex],
        backgroundColor: KColors.backgroundPrimary,
        centerTitle: true,
        leading: GestureDetector(
          onTap: (){
            _scaffoldKey.currentState!.openDrawer();
          },
          child: const Icon(Icons.menu, color: Colors.white,),
        )
    ).getWidget();
  }
  KEventHandler     callback      (){
    setState(() {
      _pageController.jumpToPage(MainPage.data.currentIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    MainPage.data.init(_scaffoldKey, callback);
    return Scaffold(
        appBar: appBar(),
        key: _scaffoldKey,
        drawer: const KeuanganKuDrawer(),
        // appBar: AppTopBar(scaffoldKey: _scaffoldKey, index: MainPage.data.currentIndex).getWidget(context),
        body: PageView(
          controller: _pageController,
          onPageChanged: onPageChanged,
          children: MainPage.data.listMainPagePages,
        ),
        bottomNavigationBar:KeuanganKuBottomNavBar(MainPage.data.currentIndex, _pageController).getWidget()
    );
  }
}