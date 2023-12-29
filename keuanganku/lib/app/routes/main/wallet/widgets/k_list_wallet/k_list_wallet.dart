import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:keuanganku/app/widgets/k_empty/k_empty.dart';
import 'package:keuanganku/app/routes/main/wallet/pages/form_input_wallet/form_wallet.dart';
import 'package:keuanganku/app/widgets/k_button/k_button.dart';
import 'package:keuanganku/app/widgets/k_card/k_card.dart';
import 'package:keuanganku/database/model/wallet.dart';
import 'package:keuanganku/app/routes/main/wallet/widgets/k_wallet_item/k_wallet_item.dart';
import 'package:keuanganku/util/dummy.dart';

class DataHelper {
  static Future<double> totalUangWallet(List<SQLModelWallet> wallets) async{
    double _ = 0;
    for (var i = 0; i < wallets.length; i++) {
      _ += (await wallets[i].totalUang());
    }
    return _;
  }

}

class KListWallet extends StatefulWidget {
  const KListWallet({
    super.key, 
    required this.wallets, 
    required this.callback
  });
  final List<SQLModelWallet> wallets;
  final VoidCallback callback;

  @override
  State<KListWallet> createState() => _KListWalletState();
}

class _KListWalletState extends State<KListWallet> {
  void updateState(){setState(() {});}

  @override
  Widget build(BuildContext context) {
    // Variable
    final icon = SvgPicture.asset(
      "assets/icons/wallet.svg",
      height: 35,
    );
   
    // Events
    void tambahData(BuildContext context){
      Navigator.push(
        context, 
        MaterialPageRoute(
          builder: (_){
          return FormWallet(
            callback: (){
              Navigator.pop(_);
              widget.callback();
          });
        })
      );
    }

    Widget normalBuild(List<SQLModelWallet> wallets){
      return Column(
        children: [
          for(int i = 0; i < wallets.length; i++)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: KWalletItem(
                wallet: wallets[i],
                callback: widget.callback
              ),
            ),
        ],
      );
    }
    Widget emptyBuild(){
      return
      makeCenterWithRow(
        child: const KEmpty() 
      );
    }  
    Widget tombolTambahWallet (){
      return KButton(
        title: "Tambah",
        icon: const Padding(
          padding: EdgeInsets.only(right: 5),
          child: Icon(CupertinoIcons.add),
        ),
        onTap: (){
          tambahData(context);
        },
      );
    }
    Widget buildBody(){
      return widget.wallets.isEmpty? 
        emptyBuild() : 
        normalBuild(widget.wallets);
    }

    return 
    KCard(
      title: "Wallet",
      icon: icon,
      button: tombolTambahWallet(),
      child: buildBody() 
    );
  }
}