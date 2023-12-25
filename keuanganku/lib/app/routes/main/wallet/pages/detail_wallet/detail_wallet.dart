// ignore_for_file: library_prefixes

import 'package:flutter/material.dart';
import 'package:keuanganku/app/app_colors.dart';
import 'package:keuanganku/app/routes/main/beranda/widgets/distribusi/distribusi_transaksi.dart' as distribusiTx;
import 'package:keuanganku/app/routes/main/pengeluaran/widgets/k_pengeluaran_item/k_pengeluaran_item.dart';
import 'package:keuanganku/app/routes/main/pengeluaran/widgets/list_pengeluaran/list_pengeluaran.dart';
import 'package:keuanganku/app/routes/main/wallet/widgets/k_pemasukan_item/k_pemasukan_item.dart';
import 'package:keuanganku/app/routes/main/wallet/widgets/list_pemasukan/k_list_pemasukan.dart';
import 'package:keuanganku/app/widgets/app_bar/app_bar.dart';
import 'package:keuanganku/app/widgets/k_empty/k_empty.dart';
import 'package:keuanganku/app/widgets/k_future_builder/k_future.dart';
import 'package:keuanganku/database/helper/income.dart';
import 'package:keuanganku/database/helper/expense.dart';
import 'package:keuanganku/database/model/income.dart';
import 'package:keuanganku/database/model/expense.dart';
import 'package:keuanganku/database/model/wallet.dart';
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
  
  // Builder
  Widget buildListPemasukan(BuildContext context, List<SQLModelIncome> listPemasukan){
    if (listPemasukan.isEmpty){
      return makeCenterWithRow(child: const KEmpty());
    }
    return Column(
          children: [
            for(int i=0;i < listPemasukan.length; i++)
              KPemasukanItem(
                callback: callback,
                size: Size(MediaQuery.sizeOf(context).width * 0.875, 40), 
                pemasukan: listPemasukan[i]
              ),
          ],
        );
  }
  Widget buildListPengeluaran(BuildContext context, List<SQLModelExpense> listPengeluaran){
    if (listPengeluaran.isEmpty){
      return makeCenterWithRow(child: const KEmpty());
    }

    return Column(
      children: [
        for(int i=0;i < listPengeluaran.length; i++)
          KPengeluaranItem(pengeluaran: listPengeluaran[i],
          callback: callback
        ),
      ],
    );
  }
  Widget buildDistribusiPengeluaran(BuildContext context){
    return makeCenterWithRow(
      child: distribusiTx.DistribusiTransaksi(
        widgetData: widget.data.distribusiTxData,
        getter: (){
          return widget.data.distribusiTxData.getDataByWalletId(widget.wallet.id);
        },
      ),
    );
  }
  
  // Widgets
  KWidget         listPengeluaran(BuildContext context){
    return KFutureBuilder.build<List<SQLModelExpense>>(
      future: SQLHelperExpense().readByWalletId(widget.wallet.id, db.database), 
      whenError: ListPengeluaran(
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
  KWidget         listPemasukan(BuildContext context){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: FutureBuilder(
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
        ),
    );
  }
  KWidget         ringkasanWallet(BuildContext context){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
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
                      Text(widget.wallet.tipe, style: kFontStyle(fontSize: 15, color: Colors.white, family: "QuickSand_Medium"),),
                      Text(widget.wallet.judul, style: kFontStyle(fontSize: 20, color: Colors.white, family: "QuickSand_Medium"),),
                    ],
                  ),
                  FutureBuilder(
                      future: widget.wallet.totalUang(),
                      builder: (_, snapshot){
                        if (snapshot.connectionState == ConnectionState.waiting){
                          return const CircularProgressIndicator();
                        } else if (snapshot.hasError){
                          return const Text("Sadly, something wrong");
                        } else {
                          return Text(formatCurrency(snapshot.data!), style: kFontStyle(fontSize: 25, color: Colors.white),);
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
  KApplicationBar appBar(BuildContext context){
    return KAppBar(
      title: "Detail Wallet", 
      centerTitle: true, 
      fontColor: Colors.white, 
      backgroundColor: ApplicationColors.primary,
      leading: appBarLeading(context)
    ).getWidget();
  }
  KWidget         appBarLeading(BuildContext context){
    return GestureDetector(
      onTap: (){
        Navigator.pop(context);
      },
      child: const Icon(Icons.arrow_back_ios_new, color: Colors.white,),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ApplicationColors.primary,
      appBar: appBar(context),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ringkasanWallet(context),
            listPemasukan(context),
            dummyHeight(height: 25),
            listPengeluaran(context),
            dummyHeight(height: 25),
            buildDistribusiPengeluaran(context),
            dummyHeight(height: 25)
          ],
        ),
      ),
    );
  }
}
