import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keuanganku/app/app_colors.dart';
import 'package:keuanganku/util/font_style.dart';
import 'package:keuanganku/util/get_currency.dart';

class KWalletItem extends StatelessWidget {
  const KWalletItem({super.key, required this.size});
  final Size size;
  
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
                Text("Wallet", style: kFontStyle(fontSize: 15)),
                Text("Dummy", style: kFontStyle(fontSize: 15, family: "QuickSand_Medium"),),
              ],
            ),
            Row(
              children: [
                Text(formatCurrency(25000.0), style: kFontStyle(fontSize: 14),),
                const SizedBox(width: 5,),
                const Icon(
                  CupertinoIcons.arrow_right,
                  color: ApplicationColors.primary,
                  size: 20,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}