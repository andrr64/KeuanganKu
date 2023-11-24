import 'package:flutter/material.dart';
import 'package:keuanganku/app/app_colors.dart';
kAppBarTitle(String title){
  return 
  Text(
    title,
    style: const TextStyle(
        fontSize: 24,
        fontFamily: "QuickSand_Bold",
        color: ApplicationColors.primary
      ),
    );
}