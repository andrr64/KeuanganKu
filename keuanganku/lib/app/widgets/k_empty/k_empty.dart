import 'package:flutter/material.dart';
import 'package:keuanganku/util/dummy.dart';
import 'package:keuanganku/util/font_style.dart';
import 'package:lottie/lottie.dart';

class KEmpty extends StatelessWidget {
  const KEmpty({super.key, this.variant});
  final int? variant;

  

  @override
  Widget build(BuildContext context) {
    const listVariant = [
      "assets/lotties/animation/empty.json",
      "assets/lotties/animation/empty1.json",
      "assets/lotties/animation/empty2.json",
      "assets/lotties/animation/empty3.json",
    ];

    return makeCenterWithRow(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 25),
        child: IntrinsicHeight(
          child: SizedBox(
            width: 200,
            child: Column(
              children: [
                Text("Nothing in here...", style: kFontStyle(fontSize: 15, color: Colors.black45),),
                Lottie.asset(
                  variant == null? listVariant[2] : listVariant[variant!],
                  repeat: false,
                  height: 150
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}