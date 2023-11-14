import 'package:flutter/material.dart';
import 'package:keuanganku/ui/pages/getting_started/widget_splashscreen.dart';

class HalamanAkhir extends StatelessWidget {
  const HalamanAkhir({super.key});

  final String judul = "Let's get started.";
  final String info =
      "Aplikasi yang akan membantu anda mengelola pengeluaran dengan mudah dan efisien.";
  final String pathImage =
      "assets/images/getting_started/keuanganku_onboarding_image.png";
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Center(
          child: getJudul(judul),
        ));
  }
}
