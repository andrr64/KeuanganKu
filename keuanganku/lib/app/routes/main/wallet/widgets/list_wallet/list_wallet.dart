import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:keuanganku/app/reusable_widgets/k_future_builder/k_future.dart';
import 'package:keuanganku/app/routes/main/wallet/pages/form_input_wallet/form_wallet.dart';
import 'package:keuanganku/app/reusable_widgets/k_button/k_button.dart';
import 'package:keuanganku/app/reusable_widgets/k_card/k_card.dart';
import 'package:keuanganku/database/helper/data_wallet.dart';
import 'package:keuanganku/database/model/data_wallet.dart';
import 'package:keuanganku/main.dart';
import 'package:keuanganku/app/reusable_widgets/k_wallet_item/k_wallet_item.dart';
import 'package:keuanganku/util/dummy.dart';
import 'package:keuanganku/util/font_style.dart';
import 'package:keuanganku/util/get_currency.dart';

class Data {
  List<SQLModelWallet> _listWallet = [];
  double totalDana = 0;
  
  Future<List<SQLModelWallet>> get wallets async {
    _listWallet = await SQLHelperWallet().readAll(db.database);
    totalDana = 0;
    for (var i = 0; i < _listWallet.length; i++) {
      totalDana += await _listWallet[i].totalUang();
    }
    return _listWallet;
  }

}

class ListWallet extends StatefulWidget {
  const ListWallet({super.key, required this.callback});
  final VoidCallback callback;

  @override
  State<ListWallet> createState() => _ListWalletState();
}

class _ListWalletState extends State<ListWallet> {
  final Data data = Data();
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
              updateState();
          });
        })
      );
    }

    // Widgets
    Widget futureBuildWhenDataIsNtEmpty(List<SQLModelWallet> wallets){
      return Column(
        children: [
          for(int i = 0; i < wallets.length; i++)
            KWalletItem(size: Size(width, 55), wallet: wallets[i]),
          const Divider(color: Colors.black26,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Total", style: kFontStyle(fontSize: 15),),
              Text(formatCurrency(data.totalDana), style: kFontStyle(fontSize: 17, color: const Color(0xff275EA6)),)
            ],
          )
        ],
      );
    }
    Widget futureBuildWhenDataEmpty(){
      return
      makeCenterWithRow(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50),
          child: Text("Empty", style: kFontStyle(fontSize: 15),),
        ) 
      );
    }  
    Widget tombolTambahWallet (){
      return KButton(
        title: "Tambah",
        icon: const Padding(
          padding: EdgeInsets.only(right: 5),
          child: Icon(CupertinoIcons.add, size: 15,),
        ),
        onTap: (){
          tambahData(context);
        },
      );
    }
    Widget buildBody(){
      return KFutureBuilder.build(
        context: context, 
        future: data.wallets, 
        buildWhenSuccess: futureBuildWhenDataIsNtEmpty, 
        buildWhenEmpty: futureBuildWhenDataEmpty, 
        buildWhenError: (){
          return const Text("Something wrong..");
        }
      );
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