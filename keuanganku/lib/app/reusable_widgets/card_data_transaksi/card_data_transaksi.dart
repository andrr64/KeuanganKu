import 'package:flutter/material.dart';
import 'package:keuanganku/app/app_colors.dart';
import 'package:keuanganku/util/get_currency.dart';

class CardTransaksi extends StatefulWidget {
  const CardTransaksi(
    this.icon, 
    {
      super.key,
      required this.onPressed,
      required this.title,
      required this.kategori,
      required this.waktu,
      required this.jumlah,
      this.width,
      this.height,
    }
  );

  final VoidCallback onPressed;
  final Icon icon;
  final String kategori;
  final String title;
  final String waktu;
  final double jumlah;
  final double? width;
  final double? height;

  @override
  State<CardTransaksi> createState() => _CardTransaksiState();
}

class _CardTransaksiState extends State<CardTransaksi> {
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
              Text(widget.kategori, style: const TextStyle(fontFamily: "QuickSand_Bold", color: ApplicationColors.primary, fontSize: 15),),
              Text(widget.title, style: const TextStyle(fontFamily: "QuickSand_Medium", color: ApplicationColors.primary,fontSize: 12),),
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
            Text(formatCurrency(widget.jumlah), style: const TextStyle(fontFamily: "QuickSand_Bold", color: ApplicationColors.primary, fontSize: 15),),
            Text(widget.waktu, style: const TextStyle(fontFamily: "QuickSand_Medium", color: ApplicationColors.primary,fontSize: 12),)
          ],
        ),
      );
    }

    return InkWell(
      hoverColor: ApplicationColors.primaryColorWidthPercentage(percentage: 5),
      onTap: () {
        widget.onPressed();
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
