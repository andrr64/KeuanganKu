import 'package:flutter/material.dart';
import 'package:keuanganku/database/model/data_pengeluaran.dart';
import 'package:keuanganku/app/app_colors.dart';

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
  final ModelDataPengeluaran dataTransaksi;

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
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            
            ],
          )
        ],
      );
    }

    Widget widgetNilaiWaktu() {
      return const Padding(
        padding: EdgeInsets.only(right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

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
