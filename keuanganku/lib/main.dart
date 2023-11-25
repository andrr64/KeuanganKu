import 'package:flutter/material.dart';
import 'package:keuanganku/android_system.dart';
import 'package:keuanganku/app/routes.dart';

extension EnumToString on Enum {
  String get enumValue => toString().split('.').last;
}

Routes routes = Routes();

void main() {
  AndroidSys.setNotificationBarColor(); // Berfungsi untuk mengubah warna bar notifikasi android
  runApp(const KeuanganKu());
}

class KeuanganKu extends StatelessWidget {
  const KeuanganKu({super.key});

  ThemeData get tema => ThemeData(
    appBarTheme: const AppBarTheme(elevation: 0),
  );

  @override
  Widget build(BuildContext context) {
    routes.initializePages(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'KeuanganKu',
      routes: routes.routeMap, 
      initialRoute: routes.mainPage,
      theme: tema,
    );
  }
}