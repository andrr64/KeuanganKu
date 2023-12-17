import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keuanganku/app/app_colors.dart';
import 'package:keuanganku/app/routes/main/wallet/pages/detail_pemasukan/detail_pemasukan.dart';
import 'package:keuanganku/database/model/income.dart';
import 'package:keuanganku/util/font_style.dart';
import 'package:keuanganku/util/get_currency.dart';
import 'package:keuanganku/util/string_operation.dart';

class KPemasukanItem extends StatelessWidget {
  const KPemasukanItem({super.key, required this.size, required this.pemasukan, required this.callback});
  final Size size;
  final SQLModelIncome pemasukan;
  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => DetailPemasukan(pemasukan: pemasukan, callback: callback))
        );
      },
      child: IntrinsicHeight(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: SizedBox(
            width: size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FutureBuilder(
                          future: pemasukan.kategori, 
                          builder: (_, snapshot){
                            if (snapshot.hasData && snapshot.connectionState == ConnectionState.done){
                              return Text(
                                truncateString(snapshot.data!.judul, 16, isEndWith: true, endWith: "..."), 
                                style: kFontStyle(fontSize: 16));
                            }
                            return Text("...", style: kFontStyle(fontSize: 12, color: Colors.black45),);
                          } 
                        ),
                        Text(truncateString(pemasukan.judul, 18, isEndWith: true, endWith: ".."), style: kFontStyle(fontSize: 15, family: "QuickSand_Medium"),),
                      ],
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(formatCurrency(pemasukan.nilai), style: kFontStyle(fontSize: 15),),
                        Text(pemasukan.formatWaktu(), style: kFontStyle(fontSize: 12, family: "QuickSand_Medium"),)
                      ],
                    ),
                    const SizedBox(width: 5,),
                    const Icon(
                      CupertinoIcons.arrow_right,
                      color: ApplicationColors.primary,
                      size: 17.5,
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}