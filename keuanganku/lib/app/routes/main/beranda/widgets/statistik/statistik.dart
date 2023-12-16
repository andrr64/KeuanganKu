import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:keuanganku/app/reusable_widgets/k_card/k_card.dart';
import 'package:keuanganku/app/reusable_widgets/k_empty/k_empty.dart';
import 'package:keuanganku/util/dummy.dart';

class WidgetData{

}

class Statistik extends StatelessWidget {
  const Statistik({super.key, required this.widgetData});
  final WidgetData widgetData;
  @override
  Widget build(BuildContext context) {
    final icon = SvgPicture.asset(
      "assets/icons/statistik.svg",
      height: 35,
    );
    final size = MediaQuery.sizeOf(context);

    return makeCenterWithRow(
      child: KCard(
        title: "Statistik",
        width: size.width * 0.875,
        icon: icon, 
        child: const SizedBox(
          height: 200, 
          child: KEmpty()
        )
      ),
    );
  }
}