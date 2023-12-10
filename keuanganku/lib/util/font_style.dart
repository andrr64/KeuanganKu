import 'package:flutter/material.dart';
import 'package:keuanganku/app/app_colors.dart';

TextStyle kFontStyle({required double fontSize, String? family}){
  return TextStyle(
    fontFamily: family ?? "QuickSand_Bold",
    color: ApplicationColors.primary,
    fontSize: fontSize,
  );
}