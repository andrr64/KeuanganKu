// ignore_for_file: library_prefixes

import 'package:flutter/material.dart';
import 'package:keuanganku/app/app_colors.dart';
import 'package:keuanganku/app/routes/main/beranda/widgets/distribusi/distribusi_transaksi.dart' as distribusiTx;
import 'package:keuanganku/app/routes/main/pengeluaran/widgets/list_pengeluaran/list_pengeluaran.dart';
import 'package:keuanganku/app/routes/main/wallet/pages/detail_wallet/widgets/tombol_menu/tombol_ubah.dart';
import 'package:keuanganku/app/routes/main/wallet/widgets/k_list_pemasukan/k_list_pemasukan.dart';
import 'package:keuanganku/app/snack_bar.dart';
import 'package:keuanganku/app/widgets/k_app_bar/k_app_bar.dart';
import 'package:keuanganku/app/widgets/k_future_builder/k_future.dart';
import 'package:keuanganku/database/helper/income.dart';
import 'package:keuanganku/database/helper/expense.dart';
import 'package:keuanganku/database/model/expense.dart';
import 'package:keuanganku/database/model/wallet.dart';
import 'package:keuanganku/enum/status.dart';
import 'package:keuanganku/k_typedef.dart';
import 'package:keuanganku/main.dart';
import 'package:keuanganku/util/dummy.dart';
import 'package:keuanganku/util/font_style.dart';
import 'package:keuanganku/util/get_currency.dart';

class Data {
  distribusiTx.WidgetData distribusiTxData = distribusiTx.WidgetData();
}

class DetailWallet extends StatefulWidget {
  DetailWallet({super.key, required this.wallet, required this.callback});
  final SQLModelWallet wallet;
  final Data data = Data();
  final VoidCallback callback;
  
  @override
  State<DetailWallet> createState() => _DetailWalletState();
}

class _DetailWalletState extends State<DetailWallet> {
  // Events
  KEventHandler updateState(){
    setState(() {
      
    });
  }
  KEventHandler callback(){
    updateState();
    widget.callback();
  }
  
  // Widgets
  KWidget         buildDistribusiPengeluaran  (BuildContext context){
    return distribusiTx.DistribusiTransaksi(
        widgetData: widget.data.distribusiTxData,
        getter: (){
          return widget.data.distribusiTxData.getDataByWalletId(widget.wallet.id);
        },
    );
  }
  KWidget         listPengeluaran             (BuildContext context){
    return KFutureBuilder.build<List<SQLModelExpense>>(
      future: SQLHelperExpense().readByWalletId(widget.wallet.id, db.database), 
      whenError: ListPengeluaran(
        listPengeluaran: const [], 
        callback: callback
      ), 
      whenWaiting: ListPengeluaran(
        listPengeluaran: const [], 
        callback: callback
      ),
      whenSuccess: (data){
        return ListPengeluaran(
          listPengeluaran: data, 
          callback: callback
        );
      }
    );
  }
  KWidget         listPemasukan               (BuildContext context){
    return FutureBuilder(
          future: SQLHelperIncome().readDataByWalletId(widget.wallet.id, db.database),
          builder: (_, snapshot){
            if (snapshot.connectionState == ConnectionState.waiting){
              return makeCenterWithRow(child: const CircularProgressIndicator());
            } else if (snapshot.hasError){
              return makeCenterWithRow(child: const Text("Sadly, something wrong..."));
            } else {
              return KListPemasukan(
                listPemasukan: snapshot.data!, 
                callback: callback
              );
            }
          }
      );
  }
  KWidget         ringkasanWallet             (BuildContext context){
    const double ukuranH1 = 20;
    const double ukuranh2 = ukuranH1 - 5;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 25),
      child: Container(
          alignment: Alignment.topLeft,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(widget.wallet.tipe, style: kFontStyle(fontSize: ukuranh2, color: Colors.white, family: "QuickSand_Medium"),),
                      Text(widget.wallet.judul, style: kFontStyle(fontSize: ukuranH1, color: Colors.white,),)
                    ],
                  ),
                  FutureBuilder(
                      future: widget.wallet.totalUang(),
                      builder: (_, snapshot){
                        if (snapshot.connectionState == ConnectionState.waiting){
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text("Total Dana", style: kFontStyle(fontSize: ukuranh2, color: Colors.white, family: "QuickSand_Medium"),),
                              Text(formatCurrency(0), style: kFontStyle(fontSize: ukuranH1, color: Colors.white,),)
                            ],
                          );
                        } else if (snapshot.hasError){
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text("Total Dana", style: kFontStyle(fontSize: ukuranh2, color: Colors.white, family: "QuickSand_Medium"),),
                              Text("Undefined", style: kFontStyle(fontSize: ukuranH1, color: Colors.white,),)
                            ],
                          );
                        } else {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text("Total Dana", style: kFontStyle(fontSize: ukuranh2, color: Colors.white, family: "QuickSand_Medium"),),
                              Text(formatCurrency(snapshot.data!), style: kFontStyle(fontSize: ukuranH1, color: Colors.white,),)
                            ],
                          );
                        }
                      }
                  ),
                ],
              )
            ],
        )
      ),
    );
  }
  KWidget         appBarLeading               (BuildContext context){
    return GestureDetector(
      onTap: (){
        Navigator.pop(context);
      },
      child: const Icon(Icons.arrow_back_ios_new, color: Colors.white,),
    );
  }
  List<Widget>    appBarAction                (BuildContext context){
    return [
      TombolMenu(
        onNameChanged: (){
          callback();
          tampilkanSnackBar(
            context, 
            jenisPesan: Pesan.Success, 
            msg: "Data berhasil diperbaharui"
          );
        }, 
        wallet: widget.wallet,
        context: context,
        onWalletDeleted: (){
          widget.callback(); // Update halaman Beranda, Wallet dan Pengeluaran
          Navigator.pop(context); // Pop halaman 'DetailWallet'
        },
      ).getWidget(),
    ];
  }
  KApplicationBar appBar                      (BuildContext context){
    return KAppBar(
      title: "Detail Wallet", 
      centerTitle: true, 
      fontColor: Colors.white, 
      backgroundColor: KColors.backgroundPrimary,
      leading: appBarLeading(context),
      action: appBarAction(context),
    ).getWidget();
  }

  @override
  Widget build(BuildContext context) {
   return Scaffold(
      backgroundColor: KColors.backgroundPrimary,
      appBar: appBar(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ringkasanWallet(context),
              listPemasukan(context),
              dummyHeight(),
              listPengeluaran(context),
              dummyHeight(),
              buildDistribusiPengeluaran(context),
              dummyHeight(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}