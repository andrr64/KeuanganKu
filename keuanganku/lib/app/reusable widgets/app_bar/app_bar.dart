import 'package:flutter/material.dart';
import 'package:keuanganku/app/reusable%20widgets/app_bar/app_bar_title.dart';

class KAppBar {
  KAppBar({
    required this.title,
    this.leading,
    this.centerTitle,
    this.backgroundColor,
    this.shadowColor,
    this.elevation,
    this.fontSize,
    this.fontColor
  });

  Widget? leading;
  String title;
  bool? centerTitle;
  Color? backgroundColor = Colors.white;
  Color? shadowColor = Colors.transparent;
  Color? fontColor;
  double? elevation = 0;
  double? fontSize;

  AppBar getWidget(){
    return AppBar(
      leading: leading,
      title: kAppBarTitle(title, fontSz: fontSize, fontColor: fontColor),
      centerTitle: centerTitle,
      backgroundColor: backgroundColor,
      shadowColor: shadowColor,
      elevation: elevation,
    );
  }
}