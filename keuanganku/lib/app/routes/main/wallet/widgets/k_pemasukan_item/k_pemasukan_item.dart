import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keuanganku/app/app_colors.dart';
import 'package:keuanganku/app/routes/main/wallet/pages/detail_wallet/detail_wallet.dart';
import 'package:keuanganku/database/model/data_pemasukan.dart';
import 'package:keuanganku/util/font_style.dart';
import 'package:keuanganku/util/get_currency.dart';

class KPemasukanItem extends StatelessWidget {
  const KPemasukanItem({super.key, required this.size, required this.pemasukan});
  final Size size;
  final SQLModelPemasukan pemasukan;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => DetailWallet()));
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
                          future: pemasukan.wallet, 
                          builder: (_, snapshot){
                            if (snapshot.hasData && snapshot.connectionState == ConnectionState.done){
                              return Text(snapshot.data!.judul, style: kFontStyle(fontSize: 16));
                            }
                            return Text("...", style: kFontStyle(fontSize: 12, color: Colors.black45),);
                          } 
                        ),
                        Text(pemasukan.judul, style: kFontStyle(fontSize: 15, family: "QuickSand_Medium"),),
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