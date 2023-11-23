import 'package:flutter/material.dart';
import 'package:keuanganku/ui/reusable%20_components/app_bar/app_bar_title.dart';

class KAppBar {
  KAppBar({
    required this.title,
    this.leading,
    this.centerTitle,
    this.backgroundColor,
    this.shadowColor,
    this.elevation
  });

  Widget? leading;
  String title;
  bool? centerTitle;
  Color? backgroundColor = Colors.white;
  Color? shadowColor = Colors.transparent;
  double? elevation = 0;

  AppBar getWidget(){
    return AppBar(
      leading: leading,
      title: kAppBarTitle(title),
      centerTitle: centerTitle,
      backgroundColor: backgroundColor,
      shadowColor: shadowColor,
      elevation: elevation,
    );
  }
}