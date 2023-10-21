import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AndroidSys {
  // ignore: non_constant_identifier_names
  static setNotificationBarColor({bool dark_bgColor = false}) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: dark_bgColor ? Colors.black : Colors.transparent,
      statusBarIconBrightness: dark_bgColor ? Brightness.light : Brightness.dark,
    ));
  }
}
