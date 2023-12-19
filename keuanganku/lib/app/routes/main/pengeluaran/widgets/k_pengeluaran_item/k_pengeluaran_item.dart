import 'package:flutter/material.dart';
import 'package:keuanganku/app/app_colors.dart';
import 'package:keuanganku/app/routes/main/pengeluaran/pages/detail_pengeluaran/detail_pengeluaran.dart';
import 'package:keuanganku/app/widgets/k_empty/k_empty.dart';
import 'package:keuanganku/app/widgets/k_future_builder/k_future.dart';
import 'package:keuanganku/database/model/expense.dart';
import 'package:keuanganku/util/font_style.dart';
import 'package:keuanganku/util/generate_color.dart';
import 'package:keuanganku/util/get_currency.dart';
import 'package:keuanganku/util/string_operation.dart';

class KPengeluaranItem extends StatefulWidget {
  const KPengeluaranItem({super.key, required this.pengeluaran, required this.callback});
  final SQLModelExpense pengeluaran;
  final VoidCallback callback;

  @override
  State<KPengeluaranItem> createState() => _KPengeluaranItemState();
}

class _KPengeluaranItemState extends State<KPengeluaranItem> {

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
                    Text(truncateString(widget.pengeluaran.judul, 15, isEndWith: true, endWith: "..."), style: kFontStyle(fontSize: 14, family: "QuickSand_Medium"),),
                    Text(widget.pengeluaran.formatWaktu(), style: kFontStyle(fontSize: 12, family: "QuickSand_Medium"),)

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
                Icons.arrow_forward_ios,
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