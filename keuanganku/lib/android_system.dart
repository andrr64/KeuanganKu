import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AndroidSys {
  // ignore: non_constant_identifier_names
  static setNotificationBarColor({
    Color? bgColor, 
    Brightness? iconColor, 
    Color? navbarColor,
    Brightness? navBarIconColor
  }) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: bgColor ?? Colors.transparent,
      statusBarIconBrightness: iconColor?? Brightness.dark,
      systemNavigationBarColor: navbarColor?? Colors.black,
      systemNavigationBarIconBrightness: navBarIconColor?? Brightness.light
    ));
  }
}
