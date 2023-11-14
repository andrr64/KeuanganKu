import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keuanganku/ui/keep_alive.dart';
import 'package:keuanganku/ui/pages/main/beranda/beranda.dart';
import 'package:keuanganku/ui/pages/main/maindrawer.dart';
import 'package:keuanganku/ui/pages/main/pengeluaran/pengeluaran.dart';
import 'package:keuanganku/ui/pages/main/wallet/wallet.dart';

class ObjectProperty {
  Color primaryColor = const Color(0xff3F4245);
}

class MainPage extends StatefulWidget {
  MainPage({super.key});
  final ObjectProperty property = ObjectProperty();
  
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final PageController _pageController = PageController();
  final List<Widget> _screens = [
    KeepAlivePage(child: PageBeranda()),
    const KeepAlivePage(child: HalamanPengeluaran()),
    const KeepAlivePage(child: HalamanWallet()),
    const KeepAlivePage(child: Scaffold()),
  ];
  final List<String> _title = [
    "Ringkasan",
    "Pengeluaran",
    "Wallet",
    "To-Do"
  ];
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  int _currentIndex = 0;

  // ignore: non_constant_identifier_names, unused_element
  void _state_onIndexChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Variable : List tombol bottom navbar
    List<BottomNavigationBarItem> bottomNavBarItems = [
      BottomNavigationBarItem(
        icon: Icon(_currentIndex == 0? Icons.analytics : Icons.analytics_outlined),
        label: _title[0]),
        
      BottomNavigationBarItem(
        icon: Icon(_currentIndex == 1? CupertinoIcons.money_dollar_circle_fill : CupertinoIcons.money_dollar_circle),
        label: _title[1]),

      BottomNavigationBarItem(
        icon: Icon(_currentIndex == 2? Icons.account_balance_wallet : Icons.account_balance_wallet_outlined),
        label: _title[2]),

      BottomNavigationBarItem(
        icon: Icon(_currentIndex == 3? CupertinoIcons.pencil_circle_fill : CupertinoIcons.pencil_circle),
        label: _title[3]),
    ];

    return Scaffold(
      key: _key,
      drawer: MainDrawer(),
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            _key.currentState!.openDrawer();
          }, 
          icon: const Icon(Icons.menu), color: widget.property.primaryColor,),
        title: Text(
          _title[_currentIndex],
          style: TextStyle(
            fontSize: 18,
            fontFamily: "Inter_Medium",
            color: widget.property.primaryColor
            ),
          ),
        centerTitle: true,
        backgroundColor: Colors.white,
        shadowColor: Colors.black,
        elevation: 1,

      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: _state_onIndexChanged,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        type:BottomNavigationBarType.fixed ,
        selectedItemColor: widget.property.primaryColor,
        unselectedItemColor: Colors.grey[0],
        currentIndex: _currentIndex,
        items: bottomNavBarItems,
        onTap: (index) => _pageController.jumpToPage(index),
        selectedFontSize: 12,
        unselectedFontSize: 12,
      ),
    );
  }
}
