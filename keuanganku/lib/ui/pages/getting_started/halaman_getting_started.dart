import 'package:flutter/material.dart';
import 'package:keuanganku/main.dart';
import 'package:keuanganku/ui/pages/getting_started/halaman_1.dart';
import 'package:keuanganku/ui/pages/getting_started/halaman_2.dart';
import 'package:keuanganku/ui/pages/getting_started/halaman_akhir.dart';
import 'package:keuanganku/ui/warna_aplikasi.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class GettingStartedPage extends StatefulWidget {
  const GettingStartedPage({super.key});

  @override
  State<GettingStartedPage> createState() => _GettingStartedPageState();
}

class _GettingStartedPageState extends State<GettingStartedPage> {
  final PageController _pageController = PageController();
  final Duration _animationDuration = const Duration(milliseconds: 1000);
  final Curve _animationCurve = Curves.easeOutQuint;
  bool halamanAkhir = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        PageView(
          controller: _pageController,
          children: const [Halaman1(), Halaman2(), HalamanAkhir()],
          onPageChanged: (value) {
            setState(() {
              halamanAkhir = value == 2;
            });
          },
        ),
        Container(
          alignment: const Alignment(0, 0.85),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              !halamanAkhir
                  ? Container(
                      alignment: Alignment.center,
                      width: 70,
                      height: 30,
                      child: GestureDetector(
                        onTap: () {
                          _pageController.animateToPage(2,
                              duration: _animationDuration,
                              curve: _animationCurve);
                        },
                        child: const Text(
                          "Skip",
                          style: TextStyle(
                              fontFamily: "Quicksand_Medium",
                              fontSize: 14,
                              color: Warna.warna_primer),
                        ),
                      ),
                    )
                  : const SizedBox(
                      width: 70,
                      height: 30,
                    ),
              SmoothPageIndicator(
                controller: _pageController,
                count: 3,
                effect: const WormEffect(
                    dotWidth: 8,
                    dotHeight: 8,
                    dotColor: Warna.warna_indikator_nonaktif,
                    activeDotColor: Warna.warna_primer),
              ),
              !halamanAkhir
                  ? SizedBox(
                      width: 70,
                      height: 30,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Warna.warna_primer,
                        ),
                        onPressed: () {
                          _pageController.nextPage(
                              duration: _animationDuration,
                              curve: _animationCurve);
                        },
                        child: const Icon(
                          Icons.arrow_right_alt,
                          color: Colors.white,
                        ),
                      ),
                    )
                  : SizedBox(
                      width: 70,
                      height: 30,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Warna.warna_primer,
                        ),
                        child: const Text(
                          "Done",
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, routes.root);
                        },
                      ),
                    )
            ],
          ),
        ),
      ]),
    );
  }
}
