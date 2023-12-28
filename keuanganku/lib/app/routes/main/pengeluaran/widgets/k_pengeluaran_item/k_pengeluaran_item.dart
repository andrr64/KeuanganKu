import 'package:flutter/material.dart';
import 'package:keuanganku/app/app_colors.dart';
import 'package:keuanganku/app/routes/main/pengeluaran/pages/detail_pengeluaran/detail_pengeluaran.dart';
import 'package:keuanganku/app/widgets/k_empty/k_empty.dart';
import 'package:keuanganku/app/widgets/k_future_builder/k_future.dart';
import 'package:keuanganku/database/model/expense.dart';
import 'package:keuanganku/k_typedef.dart';
import 'package:keuanganku/util/dummy.dart';
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
  KWidget     lingkaranRating   (){
    return Container(
      width: 25,
      height: 25,
      decoration: BoxDecoration(
        color: mapValueToColor(widget.pengeluaran.rating),
        borderRadius: BorderRadius.circular(25/2),
      ),
    );
  }
  KWidget     ringkasanWallet   (Size size){
    return SizedBox(
      width: 150,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          KFutureBuilder.build(
            future: widget.pengeluaran.kategori,
            whenSuccess: (val) {
              return Text(
                  truncateString(val.judul, 16, isEndWith: true, endWith:  "..."),
                  style: kFontStyle(fontSize: 15)
              );
            },
            whenError: const KEmpty(),
          ),
          Text(truncateString(widget.pengeluaran.judul, 15, isEndWith: true, endWith: "..."), style: kFontStyle(fontSize: 14, family: "QuickSand_Medium"),),
          Text(widget.pengeluaran.formatWaktu(), style: kFontStyle(fontSize: 12, family: "QuickSand_Medium"),)
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

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
              lingkaranRating(),
              dummyWidth(10),
              ringkasanWallet(size)
            ],
          ),
          Row(
            children: [
              SizedBox(
                  child: Text(
                    truncateString(formatCurrency(widget.pengeluaran.nilai), 13, isEndWith: true, endWith: "..."),
                    style: kFontStyle(fontSize: 15),
                  )
              ),
              const SizedBox(width: 5,),
              const Icon(
                Icons.arrow_forward_ios,
                color: KColors.fontPrimaryBlack,
                size: 15,
              )
            ],
          )
        ],
      ),
    );
  }
}