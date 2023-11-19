import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keuanganku/ui/pages/main/main_list_judul_menu.dart';

class Properties {
  Color primaryColor = const Color(0xff383651);
}

class Data {
  int currentIndex = 0;
  final List<String> appBarTitle = [
    "Ringkasan",
    "Pengeluaran",
    "Wallet",
    "To-Do"
  ];
}

class ApplicatioBottomNavBar{
  final Data data = Data();
  final Properties properties = Properties();
  late final PageController pageController;

  ApplicatioBottomNavBar(int index, this.pageController){
    data.currentIndex = index;
  }

  dynamic getWidget(){
    List<BottomNavigationBarItem> bottomNavBarItems = [
      BottomNavigationBarItem(
        icon: Icon(data.currentIndex == 0? Icons.analytics : Icons.analytics_outlined),
        label: menuTitle[0]),
      BottomNavigationBarItem(
        icon: Icon(data.currentIndex == 1? CupertinoIcons.money_dollar_circle_fill : CupertinoIcons.money_dollar_circle),
        label: menuTitle[1]),
      BottomNavigationBarItem(
        icon: Icon(data.currentIndex == 2? Icons.account_balance_wallet : Icons.account_balance_wallet_outlined),
        label: menuTitle[2]),
      BottomNavigationBarItem(
        icon: Icon(data.currentIndex == 3? CupertinoIcons.pencil_circle_fill : CupertinoIcons.pencil_circle),
        label: menuTitle[3]),
    ];

    return BottomNavigationBar(

      backgroundColor: Colors.white,
      type:BottomNavigationBarType.fixed ,
      selectedItemColor: properties.primaryColor,
      unselectedItemColor: Colors.grey[0],
      currentIndex: data.currentIndex,
      items: bottomNavBarItems,
      onTap: (index) => pageController.jumpToPage(index),
      selectedFontSize: 12,
      unselectedFontSize: 12,
    );
  }
}