import 'package:flutter/material.dart';
import 'package:keuanganku/app/main/list_feature.dart';
import 'package:keuanganku/app/reusable%20_components/app_bar/app_bar.dart';

class Properties {
  final Color primaryColor = const Color(0xff383651);
}

class AppTopBar{
  AppTopBar({required this.scaffoldKey, required this.index});
  final Properties properties = Properties();
  final GlobalKey<ScaffoldState> scaffoldKey;
  final int index;

  dynamic getWidget(BuildContext context) {
    return KAppBar(
      leading: IconButton(
        onPressed: (){
          scaffoldKey.currentState!.openDrawer();
        }, 
        icon: const Icon(Icons.menu), 
        color: properties.primaryColor,
      ),
      title: listFeature[index],
      centerTitle: true,
      backgroundColor: Colors.white,
      shadowColor: Colors.transparent,
      elevation: 0,
    ).getWidget();
  }
}