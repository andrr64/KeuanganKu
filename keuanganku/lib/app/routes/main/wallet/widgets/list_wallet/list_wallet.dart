import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:keuanganku/app/widgets/k_empty/k_empty.dart';
import 'package:keuanganku/app/routes/main/wallet/pages/form_input_wallet/form_wallet.dart';
import 'package:keuanganku/app/widgets/k_button/k_button.dart';
import 'package:keuanganku/app/widgets/k_card/k_card.dart';
import 'package:keuanganku/database/model/wallet.dart';
import 'package:keuanganku/app/widgets/k_wallet_item/k_wallet_item.dart';
import 'package:keuanganku/util/dummy.dart';
import 'package:keuanganku/util/font_style.dart';
import 'package:keuanganku/util/get_currency.dart';

class DataHelper {
  static Future<double> totalUangWallet(List<SQLModelWallet> wallets) async{
    double _ = 0;
    for (var i = 0; i < wallets.length; i++) {
      _ += (await wallets[i].totalUang());
    }
    return _;
  }

}

class ListWallet extends StatefulWidget {
  const ListWallet({
    super.key, 
    required this.wallets, 
    required this.callback
  });
  final List<SQLModelWallet> wallets;
  final VoidCallback callback;

  @override
  State<ListWallet> createState() => _ListWalletState();
}

class _ListWalletState extends State<ListWallet> {
  void updateState(){setState(() {});}

  @override
  Widget build(BuildContext context) {
    
    // Variable
    final icon = SvgPicture.asset(
      "assets/icons/wallet.svg",
      height: 35,
    );
    final size = MediaQuery.sizeOf(context);
    final width = size.width * 0.875;
   
    // Events
    void tambahData(BuildContext context){
      Navigator.push(
        context, 
        MaterialPageRoute(
          builder: (_){
          return FormWallet(
            onFinished: (){
              Navigator.pop(_);
              widget.callback();
          });
        })
      );
    }

    // Widgets
    Widget teksTotalUangWallet(){
      return FutureBuilder(
        future: DataHelper.totalUangWallet(widget.wallets), 
        builder: ((_, snapshot){
          if (snapshot.connectionState == ConnectionState.waiting){
            return makeCenterWithRow(child: const CircularProgressIndicator());
          } else if (snapshot.hasError){
            return makeCenterWithRow(child: const Text("Something wrong..."));
          } else {
            return Text(formatCurrency(snapshot.data!), style: kFontStyle(fontSize: 15, color: Colors.blue),);
          }
        })
      );
    }

    Widget normalBuild(List<SQLModelWallet> wallets){
      return Column(
        children: [
          for(int i = 0; i < wallets.length; i++)
            KWalletItem(size: Size(width, 55), wallet: wallets[i], callback: widget.callback,),
          const Divider(color: Colors.black26,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Total", style: kFontStyle(fontSize: 15),),
              teksTotalUangWallet()
            ],
          )
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

    return makeCenterWithRow(
      child: KCard(
        title: "Wallet",
        width: size.width * 0.875,
        icon: icon,
        button: tombolTambahWallet(),
        child: buildBody() 
      ),
    );
  }
}