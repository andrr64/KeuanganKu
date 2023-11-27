import 'package:flutter/material.dart';
import 'package:keuanganku/database/model/data_pengeluaran.dart';
import 'package:keuanganku/app/app_colors.dart';
import 'package:keuanganku/util/get_currency.dart';

class CardPengeluaran extends StatefulWidget {
  const CardPengeluaran(this.icon, {
    super.key,
    required this.dataTransaksi,
    this.width,
    this.height,
  });

  final Icon icon;
  final double? width;
  final double? height;
  final ModelDataPengeluaran dataTransaksi;

  @override
  State<CardPengeluaran> createState() => _CardPengeluaranState();
}

class _CardPengeluaranState extends State<CardPengeluaran> {
  Color bgColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    Widget widgetIkonKategoriDeskripsi() {
      return Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: widget.icon,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text("DUMMY", style: TextStyle(fontFamily: "QuickSand_Bold", color: ApplicationColors.primary, fontSize: 15),),
              Text(widget.dataTransaksi.deskripsi, style: const TextStyle(fontFamily: "QuickSand_Medium", color: ApplicationColors.primary,fontSize: 12),),
            ],
          )
        ],
      );
    }

    Widget widgetNilaiWaktu() {
      return Padding(
        padding: const EdgeInsets.only(right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(formatCurrency(widget.dataTransaksi.nilai), style: const TextStyle(fontFamily: "QuickSand_Bold", color: ApplicationColors.primary, fontSize: 15),),
            Text(widget.dataTransaksi.formatWaktu(), style: const TextStyle(fontFamily: "QuickSand_Medium", color: ApplicationColors.primary,fontSize: 12),)
          ],
        ),
      );
    }

    return InkWell(
      hoverColor: ApplicationColors.primaryColorWidthPercentage(percentage: 5),
      onTap: () {
        // Aksi yang dijalankan ketika ditekan
        setState(() {

        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 7.5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            widgetIkonKategoriDeskripsi(),
            widgetNilaiWaktu(),
          ],
        ),
      ),
    );
  }
}
