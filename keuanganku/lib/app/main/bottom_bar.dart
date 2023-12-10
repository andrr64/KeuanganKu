import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keuanganku/app/app_colors.dart';
import 'package:keuanganku/app/main/list_feature.dart';

class Data {
  int currentIndex = 0;
  final List<String> appBarTitle = [
    "Ringkasan",
    "Pengeluaran",
    "Wallet",
    "To-Do"
  ];

  List<BottomNavigationBarItem> getItems () {
    return [
      BottomNavigationBarItem(
        icon: Icon(currentIndex == 0? Icons.analytics : Icons.analytics_outlined),
        label: listFeature[0]),
      BottomNavigationBarItem(
        icon: Icon(currentIndex == 1? CupertinoIcons.money_dollar_circle_fill : CupertinoIcons.money_dollar_circle),
        label: listFeature[1]),
      BottomNavigationBarItem(
        icon: Icon(currentIndex == 2? Icons.account_balance_wallet : Icons.account_balance_wallet_outlined),
        label: listFeature[2]),
      BottomNavigationBarItem(
        icon: Icon(currentIndex == 3? CupertinoIcons.pencil_circle_fill : CupertinoIcons.pencil_circle),
        label: listFeature[3]),
    ];
  }

}

class AppBottomNavBar{
  final Data data = Data();
  late final PageController pageController;

  AppBottomNavBar(int index, this.pageController){
    data.currentIndex = index;
  }

  Widget getWidget(){

    return BottomNavigationBar(
      backgroundColor: ApplicationColors.primaryBlue,
      type:BottomNavigationBarType.fixed ,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white70,
      currentIndex: data.currentIndex,
      items: data.getItems(),
      onTap: (index) => pageController.jumpToPage(index),
      selectedFontSize: 12,
      unselectedFontSize: 12,
    );
  }
}