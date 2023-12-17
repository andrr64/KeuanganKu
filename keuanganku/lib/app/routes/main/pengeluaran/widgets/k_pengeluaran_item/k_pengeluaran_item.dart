import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keuanganku/app/app_colors.dart';
import 'package:keuanganku/app/routes/main/pengeluaran/pages/detail_pengeluaran/detail_pengeluaran.dart';
import 'package:keuanganku/app/widgets/k_empty/k_empty.dart';
import 'package:keuanganku/app/widgets/k_future_builder/k_future.dart';
import 'package:keuanganku/database/model/data_pengeluaran.dart';
import 'package:keuanganku/util/font_style.dart';
import 'package:keuanganku/util/get_currency.dart';
import 'package:keuanganku/util/string_operation.dart';

class KPengeluaranItem extends StatefulWidget {
  const KPengeluaranItem({super.key, required this.pengeluaran, required this.callback});
  final SQLModelPengeluaran pengeluaran;
  final VoidCallback callback;

  @override
  State<KPengeluaranItem> createState() => _KPengeluaranItemState();
}

class _KPengeluaranItemState extends State<KPengeluaranItem> {
  Color mapValueToColor(double value) {
    if (value == -1) {
      return Colors.grey;
    }
    if (value < 1.0 || value > 5.0) {
      throw ArgumentError('Nilai harus di antara 1 dan 5');
    }

    // Hitung nilai Hue untuk gradient dari merah ke hijau
    double hue = (value - 1.0) / 4.0 * 120.0;

    // Ubah nilai Hue menjadi warna menggunakan HSLColor
    HSLColor color = HSLColor.fromAHSL(1.0, hue, 1.0, 0.5);

    // Konversi HSLColor menjadi Color
    return color.toColor();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context){
              return DetailPengeluaran(
                pengeluaran: widget.pengeluaran,
                callback: widget.callback,
              );
            }
          ),
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 25,
                height: 25,
                decoration: BoxDecoration(
                  color: mapValueToColor(widget.pengeluaran.rating),
                  borderRadius: BorderRadius.circular(25/2),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              SizedBox(
                width: 150,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    KFutureBuilder.build(
                      context: context,
                      future: widget.pengeluaran.kategori,
                      buildWhenSuccess: (val) => Text(truncateString(val.judul, 16, isEndWith: true, endWith:  "..."), style: kFontStyle(fontSize: 15),),
                      buildWhenEmpty: () => const KEmpty(),
                      buildWhenError: () => const KEmpty()
                    ),
                    Text(truncateString(widget.pengeluaran.judul, 15, isEndWith: true, endWith: "..."), style: kFontStyle(fontSize: 15, family: "QuickSand_Medium"),),
                  ],
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(formatCurrency(widget.pengeluaran.nilai), style: kFontStyle(fontSize: 15),),
              const SizedBox(width: 5,),
              const Icon(
                CupertinoIcons.arrow_right,
                color: ApplicationColors.primary,
                size: 15,
              )
            ],
          )
        ],
      ),
    );
  }
}