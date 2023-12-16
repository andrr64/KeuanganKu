import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:keuanganku/app/reusable_widgets/k_card/k_card.dart';
import 'package:keuanganku/app/reusable_widgets/k_empty/k_empty.dart';
import 'package:keuanganku/enum/data_transaksi.dart';

class WidgetData{
  JenisTransaksi jenisTransaksi = JenisTransaksi.Pengeluaran;
}

class DistribusiTransaksi extends StatelessWidget {
  const DistribusiTransaksi({super.key, required this.widgetData});
  final WidgetData widgetData;

  @override
  Widget build(BuildContext context) {
    // Variable
    final icon = SvgPicture.asset(
      "assets/icons/distribusi.svg",
      height: 35,
    );
    final size = MediaQuery.sizeOf(context);

    // Events

    return KCard(
        title: "Distribusi",
        width: size.width * 0.875,
        icon: icon,
        child: const SizedBox(
          child: KEmpty()
        )
    );
  }
}