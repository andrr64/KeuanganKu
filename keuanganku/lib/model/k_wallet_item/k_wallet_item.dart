import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keuanganku/app/app_colors.dart';
import 'package:keuanganku/database/model/data_wallet.dart';
import 'package:keuanganku/util/font_style.dart';

class KWalletItem extends StatelessWidget {
  const KWalletItem({super.key, required this.size, required this.wallet});
  final Size size;
  final SQLModelWallet wallet;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => Scaffold()));
      },
      child: SizedBox(
        width: size.width,
        height: size.height,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(wallet.tipe, style: kFontStyle(fontSize: 15)),
                Text(wallet.judul, style: kFontStyle(fontSize: 15, family: "QuickSand_Medium"),),
              ],
            ),
            Row(
              children: [
                Text(wallet.nilaiString, style: kFontStyle(fontSize: 14),),
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
    );
  }
}