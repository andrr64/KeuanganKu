import 'package:flutter/material.dart';
import 'package:keuanganku/android_system.dart';
import 'package:keuanganku/app/routes.dart';

extension EnumToString on Enum {
  String get enumValue => toString().split('.').last;
}

Routes routes = Routes();

void main() {
  AndroidSys.setNotificationBarColor(); // Berfungsi untuk mengubah warna bar notifikasi android
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    routes.initializePages(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'KeuanganKu',
      routes: routes.getRoutes(), 
      initialRoute: routes.mainPage,
      theme: ThemeData(appBarTheme: const AppBarTheme(elevation: 0)),
    );
  }
}