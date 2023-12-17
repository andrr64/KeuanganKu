import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:keuanganku/app/app_colors.dart';
import 'package:keuanganku/app/routes/main/wallet/pages/detail_wallet/detail_wallet.dart';
import 'package:keuanganku/database/model/data_wallet.dart';
import 'package:keuanganku/util/dummy.dart';
import 'package:keuanganku/util/font_style.dart';
import 'package:keuanganku/util/get_currency.dart';

class KWalletItem extends StatefulWidget {
  const KWalletItem({super.key, required this.size, required this.wallet, required this.callback});
  final Size size;
  final SQLModelWallet wallet;
  final VoidCallback callback;

  @override
  State<KWalletItem> createState() => _KWalletItemState();
}

class _KWalletItemState extends State<KWalletItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => DetailWallet(callback: widget.callback, wallet: widget.wallet,)));
      },
      child: SizedBox(
        width: widget.size.width,
        height: widget.size.height,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                SizedBox(
                  width: 25,
                  height: 25,
                  child: SvgPicture.asset(widget.wallet.iconPath)),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.wallet.tipe, style: kFontStyle(fontSize: 15)),
                    Text(widget.wallet.judul, style: kFontStyle(fontSize: 15, family: "QuickSand_Medium"),),
                  ],
                ),
              ],
            ),
            Row(
              children: [
                FutureBuilder(
                  future: widget.wallet.totalUang(), 
                  builder: ((context, snapshot) {
                    if (snapshot.hasData){
                      return Text(formatCurrency(snapshot.data!), style: kFontStyle(fontSize: 15),);
                    } else {
                      return makeCenterWithRow(child: const SizedBox(height: 35, child: CircularProgressIndicator(),));
                    }
                  })
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
    );
  }
}