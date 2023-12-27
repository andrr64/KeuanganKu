import 'package:flutter/material.dart';
import 'package:keuanganku/app/routes/perkenalan/halaman_getting_started.dart';
import 'package:keuanganku/app/routes/main/main_page.dart';

class Routes {
  final mainPage = "/mainpage";
  final gettingStarted = "/gettingStarted";

  late Map<String, WidgetBuilder> _pagesMaps;

  void initializePages(BuildContext context) {
    _pagesMaps = {
      mainPage: (context) => const MainPage(),
      gettingStarted: (context) => const GettingStartedPage()
    };
  }

  dynamic get routeMap => _pagesMaps;

  getPages(String routeName) {
    return _pagesMaps[routeName];
  }
}