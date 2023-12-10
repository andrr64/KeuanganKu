import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:keuanganku/app/app_colors.dart';
import 'package:keuanganku/app/reusable_components/k_button/k_button.dart';
import 'package:keuanganku/app/reusable_components/k_card/k_card.dart';
import 'package:keuanganku/model/k_wallet_item/k_wallet_item.dart';
import 'package:keuanganku/util/dummy.dart';
import 'package:keuanganku/util/font_style.dart';

class Data {
  
}

class ListWallet extends StatelessWidget {
  const ListWallet({super.key});

  @override
  Widget build(BuildContext context) {
    // Variable
    final icon = SvgPicture.asset(
      "assets/icons/wallet.svg",
      height: 35,
    );
    final size = MediaQuery.sizeOf(context);

    // Widgets
    Widget showAllButton(){
      return FilledButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => Scaffold( )));
        }, 
        style: FilledButton.styleFrom(
          elevation: 0,
          backgroundColor: ApplicationColors.buttonBgColor,
        ),
        child: Text("Tampilkan Semuanya", style: kFontStyle(fontSize: 12),),
      );
    }

    // Events

    return makeCenterWithRow(
      child: KCard(
        title: "Wallet",
        width: size.width * 0.875,
        icon: icon,
        button: KButton(
          title: "Tambah",
          icon: const Padding(
            padding: EdgeInsets.only(right: 5),
            child: Icon(CupertinoIcons.add, size: 15,),
          ),
          onTap: (){
            
          },
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: KWalletItem(size: Size(size.width * 0.875, 50)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: KWalletItem(size: Size(size.width * 0.875, 50)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: KWalletItem(size: Size(size.width * 0.875, 50)),
            ),
            showAllButton(),
            const Divider(color: Colors.black26,),
          ],
        )
      ),
    );
  }
}