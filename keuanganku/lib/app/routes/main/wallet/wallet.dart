import 'package:flutter/material.dart';
import 'package:keuanganku/app/app_colors.dart';
import 'package:keuanganku/app/routes/main/beranda/beranda.dart';
import 'package:keuanganku/app/routes/main/pengeluaran/pengeluaran.dart';
import 'package:keuanganku/app/routes/main/wallet/widgets/k_list_pemasukan/k_list_pemasukan.dart';
import 'package:keuanganku/app/routes/main/wallet/widgets/k_list_wallet/k_list_wallet.dart';
import 'package:keuanganku/app/state_bridge.dart';
import 'package:keuanganku/app/widgets/k_card/k_card.dart';
import 'package:keuanganku/app/widgets/k_future_builder/k_future.dart';
import 'package:keuanganku/database/helper/income.dart';
import 'package:keuanganku/database/helper/wallet.dart';
import 'package:keuanganku/enum/data_transaksi.dart';
import 'package:keuanganku/k_typedef.dart';
import 'package:keuanganku/main.dart';
import 'package:keuanganku/util/dummy.dart';
import 'package:keuanganku/util/font_style.dart';

class StateData {
  final Color backgroundColor = Colors.white;
}

class HalamanWallet extends StatefulWidget {
  const HalamanWallet({super.key, required this.parentScaffoldKey});
  static StateBridge state = StateBridge();
  final GlobalKey<ScaffoldState> parentScaffoldKey;

  @override
  State<HalamanWallet> createState() => _HalamanWalletState();
}

class _HalamanWalletState extends State<HalamanWallet> {

  void updateState(){
    setState(() {
      
    });
  }
  void callback(){
      HalamanBeranda.state.update();
      HalamanPengeluaran.state.update();
      HalamanWallet.state.update();
  }

  KWidget listWallet     () {
    return KFutureBuilder.build(
      future:       SQLHelperWallet().readAll(db.database), 
      whenError:    KCard(
        title: "Error :X", 
        child: makeCenterWithRow(child: Text("Sayangnya terdapat kesalahan.", style: kFontStyle(fontSize: 13)))
      ), 
      whenWaiting:  KCard(
        title: "Wait...", 
        child: makeCenterWithRow(child: const CircularProgressIndicator.adaptive())
      ),
      whenSuccess:  (snapshot) => KListWallet(wallets: snapshot, callback: callback)
    );
  }
  KWidget listPemasukan  (){
    return KFutureBuilder.build(
      future: SQLHelperIncome().readWeekly(DateTime.now(), db: db.database, sortirBy: SortirTransaksi.Terbaru), 
      whenError: KCard(
        title: "Error :X", 
        child: makeCenterWithRow(child: Text("Sayangnya terdapat kesalahan.", style: kFontStyle(fontSize: 13)))
      ),
      whenWaiting: KCard(
        title: "Wait...", 
        child: makeCenterWithRow(child: const CircularProgressIndicator.adaptive())
      ),
      whenSuccess: (snapshot) => KListPemasukan(listPemasukan: snapshot, callback: callback)
    );
  }
  
  @override
  Widget build(BuildContext context) {
    HalamanWallet.state.init(updateState);
    const double paddingBottom = 15;

    return Scaffold(
      backgroundColor: KColors.backgroundPrimary,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dummyHeight(height: paddingBottom),
              listWallet(),
              dummyHeight(height: paddingBottom),
              listPemasukan(),
              dummyHeight(height: paddingBottom),
            ],
          ),
        ),
      )
    );
  }
}
