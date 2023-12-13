import 'package:flutter/material.dart';
kAppBarTitle(String title, {double? fontSz, Color? fontColor}){
  
  return 
  Text(
    title,
    style: TextStyle(
        fontSize: fontSz ?? 24,
        fontFamily: "QuickSand_Bold",
        color: fontColor ?? Colors.white
      ),
    );
}