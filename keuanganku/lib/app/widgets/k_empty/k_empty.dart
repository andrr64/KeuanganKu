import 'package:flutter/cupertino.dart';
import 'package:keuanganku/util/dummy.dart';
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
      child: SizedBox(
        height: 200,
        width: 200,
        child: Column(
          children: [
            Lottie.asset(
              variant == null? listVariant[2] : listVariant[variant!],
              repeat: false
            ),
          ],
        ),
      )
    );
  }
}