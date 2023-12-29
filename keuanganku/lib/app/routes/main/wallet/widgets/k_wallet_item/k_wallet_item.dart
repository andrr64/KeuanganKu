import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:keuanganku/app/app_colors.dart';
import 'package:keuanganku/app/routes/main/wallet/pages/detail_wallet/detail_wallet.dart';
import 'package:keuanganku/database/model/wallet.dart';
import 'package:keuanganku/k_typedef.dart';
import 'package:keuanganku/util/dummy.dart';
import 'package:keuanganku/util/font_style.dart';
import 'package:keuanganku/util/get_currency.dart';

class KWalletItem extends StatefulWidget {
  const KWalletItem({super.key, required this.wallet, required this.callback});
  final SQLModelWallet wallet;
  final VoidCallback callback;

  @override
  State<KWalletItem> createState() => _KWalletItemState();
}

class _KWalletItemState extends State<KWalletItem> {
  KEventHandler onTap(BuildContext context){
    Navigator.push(context, MaterialPageRoute(builder: (context) => DetailWallet(callback: widget.callback, wallet: widget.wallet,)));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(context),
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
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FutureBuilder(
                future: widget.wallet.totalUang(),
                builder: ((context, snapshot) {
                  if (snapshot.hasData){
                    return Container(
                      alignment: Alignment.centerRight,
                      height: 30,
                      child: Text(
                        formatCurrency(snapshot.data!),
                        style: kFontStyle(fontSize: 15),
                        overflow: TextOverflow.ellipsis,
                      ),
                    );
                  } else {
                    return makeCenterWithRow(child: const SizedBox(height: 35, child: CircularProgressIndicator(),));
                  }
                })
              ),
              const SizedBox(width: 5,),
              const Icon(
                Icons.arrow_forward_ios,
                color: KColors.fontPrimaryBlack,
                size: 17.5,
              )
            ],
          )
        ],
      ),
    );
  }
}