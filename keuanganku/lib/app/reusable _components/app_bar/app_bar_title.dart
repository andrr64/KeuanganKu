import 'package:flutter/material.dart';
import 'package:keuanganku/app/app_colors.dart';
kAppBarTitle(String title, {double? fontSz}){
  return 
  Text(
    title,
    style: TextStyle(
        fontSize: fontSz ?? 24,
        fontFamily: "QuickSand_Bold",
        color: ApplicationColors.primary
      ),
    );
}