import 'package:flutter/material.dart';
import 'package:keuanganku/app/main/main_page.dart';

class Routes {
  final mainPage = "/mainpage";

  late Map<String, WidgetBuilder> _pagesMaps;

  void initializePages(BuildContext context) {
    _pagesMaps = {
      mainPage: (context) => const MainPage()
    };
  }

  dynamic get routeMap => _pagesMaps;

  getPages(String routeName) {
    // Artinya apa bang mesi?
    // pageMaps! => sudah pasti pageMaps tidak null
    return _pagesMaps[routeName];
  }
}