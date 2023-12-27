import 'package:flutter/material.dart';
import 'package:keuanganku/app/routes/perkenalan/widget_splashscreen.dart';

class Halaman1 extends StatelessWidget {
  const Halaman1({super.key});

  final String judul = "KeuanganKu";
  final String info ="Aplikasi yang akan membantu anda mengelola pengeluaran dengan mudah dan efisien.";
  final String pathImage ="assets/images/getting_started/keuanganku_onboarding_image.png";

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: getSplashInfo(judul: judul, info: info, pathImage: pathImage));
  }
}
