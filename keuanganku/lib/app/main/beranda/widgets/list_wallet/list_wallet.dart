import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:keuanganku/app/main/wallet/pages/form_input_wallet/form_wallet.dart';
import 'package:keuanganku/app/reusable%20widgets/k_button/k_button.dart';
import 'package:keuanganku/app/reusable%20widgets/k_card/k_card.dart';
import 'package:keuanganku/database/model/data_wallet.dart';
import 'package:keuanganku/model/k_wallet_item/k_wallet_item.dart';
import 'package:keuanganku/util/dummy.dart';

class Data {
  List<SQLModelWallet> get listWallet {
    return [
      SQLModelWallet(
        id: 1, 
        tipe: "Wallet", 
        judul: "Dompet Utama"
      ), 
      SQLModelWallet(
        id: 1, 
        tipe: "Wallet", 
        judul: "Dompet Utama"
      ), 
      SQLModelWallet(
        id: 1, 
        tipe: "Wallet", 
        judul: "Dompet Utama"
      ), 
    ];
  }
}

class ListWallet extends StatelessWidget {
  ListWallet({super.key});
  final Data data = Data();

  @override
  Widget build(BuildContext context) {
    // Variable
    final icon = SvgPicture.asset(
      "assets/icons/wallet.svg",
      height: 35,
    );
    final size = MediaQuery.sizeOf(context);

    // Widgets

    // Events
    void tambahData(){
      showModalBottomSheet(
        context: context, 
        isScrollControlled: true,
        builder: (context) => const FormWallet()
      );
    }

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
          onTap: tambahData,
        ),
        child: Column(
          children: [
            for(int i = 0; i < data.listWallet.length; i++)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: KWalletItem(
                  wallet: data.listWallet[i], 
                  size: Size(size.width * 0.875, 50)
                ),
              ),
            const Divider(color: Colors.black26,),
          ],
        )
      ),
    );
  }
}