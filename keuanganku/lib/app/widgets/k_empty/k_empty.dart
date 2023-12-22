import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:keuanganku/util/dummy.dart';
import 'package:keuanganku/util/font_style.dart';

class KEmpty extends StatelessWidget {
  const KEmpty({super.key, this.variant});
  final int? variant;

  

  @override
  Widget build(BuildContext context) {
    // const listVariant = [
    //   "assets/lotties/animation/empty.json",
    //   "assets/lotties/animation/empty1.json",
    //   "assets/lotties/animation/empty2.json",
    //   "assets/lotties/animation/empty3.json",
    // ];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: makeCenterWithRow(
        child: Column(
          children: [
            Text("Kosong", style: kFontStyle(fontSize: 15, color: Colors.black45),),
            const SizedBox(height: 15,),
            makeCenterWithRow(child: SvgPicture.asset("assets/svg/not_found.svg", height: 175,)),
          ],
        ),
      ),
    );
  }
}