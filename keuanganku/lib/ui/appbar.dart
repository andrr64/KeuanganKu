import 'package:flutter/material.dart';

getOtherPageAppBar(String title){
  const Color _color = const Color(0xff414A55);
  return AppBar(
    iconTheme: const IconThemeData(
      color: _color
    ),
    title: Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontFamily: "Inter_Medium",
        color: _color
        ),
      ),
    centerTitle: true,
    backgroundColor: Colors.white,
    shadowColor: Colors.black,
    elevation: 1,
  );
}