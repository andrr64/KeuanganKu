import 'package:flutter/material.dart';
import 'package:keuanganku/database/model/data_transaksi.dart';
import 'package:keuanganku/app/app_colors.dart';
import 'package:keuanganku/util/get_currency.dart';

class CardTransaksi extends StatefulWidget {
  const CardTransaksi(this.icon, {
    super.key,
    required this.dataTransaksi,
    required this.width,
    required this.height,
  });

  final Icon icon;
  final double width;
  final double height;
  final DataTransaksi dataTransaksi;

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
            children: [
              Text(
                widget.dataTransaksi.judul,
                style: const TextStyle(
                  fontFamily: "QuickSand_Bold",
                  fontSize: 16,
                  color: ApplicationColors.primary,
                ),
              ),
              Text(
                widget.dataTransaksi.limitedDeskripsi(23),
                style: const TextStyle(
                  fontFamily: "QuickSand_Medium",
                  fontSize: 11,
                  color: ApplicationColors.primary,
                ),
              ),
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
            Text(
              formatCurrency(widget.dataTransaksi.nilai),
              style: const TextStyle(
                fontFamily: "QuickSand_Bold",
                fontSize: 16,
                color: ApplicationColors.primary,
              ),
            ),
            Text(
              widget.dataTransaksi.dateTime,
              style: const TextStyle(
                fontFamily: "QuickSand_Medium",
                fontSize: 11,
                color: ApplicationColors.primary,
              ),
            ),
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
