import 'package:flutter/material.dart';
import 'package:keuanganku/ui/application_colors.dart';
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