import 'package:flutter/material.dart';
import 'package:keuanganku/app/routes/perkenalan/pages/form_input_username/form_input_username.dart';
import 'package:keuanganku/app/routes/perkenalan/halaman_1.dart';
import 'package:keuanganku/app/routes/perkenalan/halaman_2.dart';
import 'package:keuanganku/app/routes/perkenalan/halaman_akhir.dart';
import 'package:keuanganku/app/app_colors.dart';
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
  final listHalaman = [
    const Halaman1(), 
    const Halaman2(), 
    const HalamanAkhir()
  ];
  
  @override
  Widget build(BuildContext context) {
  final halamanTerakhir = listHalaman.length-1;

    return Scaffold(
      body: Stack(children: [
        PageView(
          controller: _pageController,
          children: const [
            Halaman1(), 
            Halaman2(), 
            HalamanAkhir()
          ],
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
                          _pageController.animateToPage(halamanTerakhir,
                              duration: _animationDuration,
                              curve: _animationCurve);
                        },
                        child: const Text(
                          "Skip",
                          style: TextStyle(
                              fontFamily: "Quicksand_Medium",
                              fontSize: 14,
                              color: KColors.fontPrimaryBlack),
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
                effect: WormEffect(
                    dotWidth: 8,
                    dotHeight: 8,
                    dotColor: KColors.primaryColorWidthPercentage(percentage: 50),
                    activeDotColor: KColors.fontPrimaryBlack),
              ),
              !halamanAkhir
                  ? SizedBox(
                      height: 30,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: KColors.fontPrimaryBlack,
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
                      height: 30,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: KColors.fontPrimaryBlack,
                        ),
                        child: const Text(
                          "Let's go",
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          Navigator.pushReplacement(context, (
                            MaterialPageRoute(builder: (context) => const FormInputUsername())
                          ));
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
