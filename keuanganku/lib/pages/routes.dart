import 'package:flutter/material.dart';
import 'package:keuanganku/pages/getting_started/halaman_getting_started.dart';
import 'package:keuanganku/pages/mainpage/mainpage.dart';

class Routes {
  static const beranda = "/beranda";
  static const perkenalan = "/getting_started";
  
  // ignore: constant_identifier_names
  static const perkenalan_inputNama = "/getting_started/input_name";

  static Map<String, WidgetBuilder>? _pagesMaps;

  static void initializePages(BuildContext context) {
    _pagesMaps = {
      Routes.perkenalan: (context) => const GettingStartedPage(),
      Routes.perkenalan_inputNama: (context) => const GettingStartedPage(),
      Routes.beranda: (context) => const MainPage()
    };
  }

  static getRoutes(){
    return _pagesMaps!;
  }

  static getPages(String routeName) {
    // Artinya apa bang mesi?
    // pageMaps! => sudah pasti pageMaps tidak null
    return _pagesMaps![routeName]!;
  }
}
