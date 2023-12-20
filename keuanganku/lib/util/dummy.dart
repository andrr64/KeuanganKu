import 'package:flutter/material.dart';

dummyHeight({double height = 15}){
  return SizedBox(height: height,);
}

dummyWidth(double width){
  return SizedBox(width: width,);
}

makeCenterWithRow({required Widget child}){
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center, 
    children: [child],);
}