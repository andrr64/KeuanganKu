import 'package:flutter/material.dart';
kAppBarTitle(String title, {double? fontSz, Color? bgColor}){
  
  return 
  Text(
    title,
    style: TextStyle(
        fontSize: fontSz ?? 24,
        fontFamily: "QuickSand_Bold",
        color: bgColor ?? Colors.white
      ),
    );
}