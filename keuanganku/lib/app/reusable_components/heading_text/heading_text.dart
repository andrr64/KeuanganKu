import 'package:flutter/material.dart';
import 'package:keuanganku/app/app_colors.dart';

class HeadingText {
  Widget h1(String title, {String? fontFamily}){
    return Text(
      title,
      style: TextStyle(
        fontFamily: fontFamily ?? "QuickSand_Bold",
        fontSize: 20,
        color: ApplicationColors.primary
      ),
    );
  }
}