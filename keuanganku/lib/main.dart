import 'package:flutter/material.dart';
import 'package:keuanganku/android_system.dart';
import 'package:keuanganku/pages/routes.dart';

void main() {
  AndroidSys.setNotificationBarColor();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Routes.initializePages(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'KeuanganKu',
      routes: Routes.getRoutes(),
      initialRoute: Routes.perkenalan,
      theme: ThemeData(appBarTheme: const AppBarTheme(elevation: 0)),
    );
  }
}
