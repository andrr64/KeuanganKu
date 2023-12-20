import 'package:flutter/material.dart';
import 'package:keuanganku/app/app_colors.dart';
import 'package:keuanganku/app/routes/main/beranda/beranda.dart';
import 'package:keuanganku/app/routes/main/pengeluaran/pengeluaran.dart';
import 'package:keuanganku/app/routes/main/wallet/widgets/list_pemasukan/k_list_pemasukan.dart';
import 'package:keuanganku/app/routes/main/wallet/widgets/list_wallet/list_wallet.dart';
import 'package:keuanganku/app/state_bridge.dart';
import 'package:keuanganku/database/helper/income.dart';
import 'package:keuanganku/database/helper/wallet.dart';
import 'package:keuanganku/enum/data_transaksi.dart';
import 'package:keuanganku/main.dart';
import 'package:keuanganku/util/dummy.dart';

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

  @override
  Widget build(BuildContext context) {
    HalamanWallet.state.init(updateState);
    Widget listWallet() {
      void callback(){
        updateState();
        HalamanBeranda.state.update();
        HalamanPengeluaran.state.update();
        HalamanWallet.state.update();
      }
      return FutureBuilder(
        future: SQLHelperWallet().readAll(db.database), 
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return makeCenterWithRow(child: const CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return makeCenterWithRow(child: const Text("Something wrong..."));
          } else {
            return ListWallet(
              wallets: snapshot.data!, 
              callback: (){
                callback();
              }
            );
          }
        },
      );
    }
    Widget listPemasukan(){
      void callback(){
        HalamanWallet.state.update();
        HalamanBeranda.state.update();
        HalamanPengeluaran.state.update();
      }
      return FutureBuilder(
        future: SQLHelperIncome().readWeekly(DateTime.now(), db: db.database, sortirBy: SortirTransaksi.Terbaru), 
        builder: (_, snapshot){
          if (snapshot.connectionState == ConnectionState.waiting){
            return makeCenterWithRow(child: const CircularProgressIndicator());
          } else if (snapshot.hasError){
            return makeCenterWithRow(child: const Text("Sadly, something wrong..."));
          } else {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: KListPemasukan(
                listPemasukan: snapshot.data!, 
                callback: callback
              ),
            );
          }
        }
      );
    }
    const double paddingBottom = 15;

    return Scaffold(
      backgroundColor: ApplicationColors.primary,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
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
      )
    );
  }
}
