import 'package:flutter/material.dart';
import 'package:keuanganku/app/app_colors.dart';
import 'package:keuanganku/app/routes/main/list_feature.dart';
import 'package:keuanganku/app/widgets/k_app_bar/k_app_bar.dart';


class AppTopBar{
  AppTopBar({required this.scaffoldKey, required this.index});
  final GlobalKey<ScaffoldState> scaffoldKey;
  final int index;

  dynamic getWidget(BuildContext context) {
    return KAppBar(
      leading: IconButton(
        onPressed: (){
          scaffoldKey.currentState!.openDrawer();
        }, 
        icon: const Icon(Icons.menu), 
        color: Colors.white,
      ),
      title: listFeature[index],
      centerTitle: true,
      backgroundColor: ApplicationColors.primary,
      shadowColor: Colors.transparent,
      elevation: 0,
    ).getWidget();
  }
}