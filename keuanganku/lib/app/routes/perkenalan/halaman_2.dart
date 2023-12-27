import 'package:flutter/material.dart';
import 'package:keuanganku/app/routes/perkenalan/widget_splashscreen.dart';

class Halaman2 extends StatelessWidget {
  const Halaman2({super.key});

  final String judul = "Grafik Pengeluaran";
  final String info = " Membantu anda melihat tren pengeluaran anda sehingga analisis keuangan menjadi lebih intuitif dan informatif.";
  final String pathImage ="assets/images/getting_started/keuanganku_splashscreen_2.png";

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: getSplashInfo(judul: judul, info: info, pathImage: pathImage),
    );
  }
}
