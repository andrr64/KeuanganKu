import 'package:flutter/material.dart';
import 'package:keuanganku/ui/pages/main/main_list_judul_menu.dart';

class Properties {
  final Color primaryColor = const Color(0xff383651);
}

class BarAplikasi{
  BarAplikasi({required this.scaffoldKey, required this.index});
  final Properties properties = Properties();
  final GlobalKey<ScaffoldState> scaffoldKey;
  final int index;
  
  Text getTitle(int index){
    return Text(
      menuTitle[index],
      style: TextStyle(
          fontSize: 24,
          fontFamily: "QuickSand_Bold",
          color: properties.primaryColor
        ),
      );
  }

  dynamic getWidget(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: (){
          scaffoldKey.currentState!.openDrawer();
        }, 
        icon: const Icon(Icons.menu), 
        color: properties.primaryColor,
      ),
      title: getTitle(index),
      centerTitle: true,
      backgroundColor: Colors.white,
      shadowColor: Colors.transparent,
      elevation: 0,
    );
  }
}