import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:keuanganku/app/reusable%20widgets/k_card/k_card.dart';
import 'package:keuanganku/util/dummy.dart';

class DistribusiTransaksi extends StatelessWidget {
  const DistribusiTransaksi({super.key});

  @override
  Widget build(BuildContext context) {
    // Variable
    final icon = SvgPicture.asset(
      "assets/icons/distribusi.svg",
      height: 35,
    );
    final size = MediaQuery.sizeOf(context);

    // Events

    return makeCenterWithRow(
      child: KCard(
        title: "Distribusi",
        width: size.width * 0.875,
        icon: icon,
        child: Column(
          children: [

          ],
        )
      ),
    );
  }
}