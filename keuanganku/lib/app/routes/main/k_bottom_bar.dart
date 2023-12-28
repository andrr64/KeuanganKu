import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keuanganku/app/app_colors.dart';
import 'package:keuanganku/app/routes/main/page_titles.dart';

class Data {
  int currentIndex = 0;

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
    ];
  }

}

class KeuanganKuBottomNavBar{
  final Data data = Data();
  late final PageController pageController;

  KeuanganKuBottomNavBar(int index, this.pageController){
    data.currentIndex = index;
  }

  Widget getWidget(){
    return BottomNavigationBar(
      backgroundColor: KColors.backgroundPrimary,
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