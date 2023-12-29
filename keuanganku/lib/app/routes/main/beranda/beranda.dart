import 'package:flutter/material.dart';
import 'package:keuanganku/app/app_colors.dart';
import 'package:keuanganku/app/routes/main/beranda/widgets/distribusi/distribusi_transaksi.dart';
import 'package:keuanganku/app/routes/main/beranda/widgets/ringkasan/k_ringkasan.dart';
import 'package:keuanganku/app/routes/main/main_page.dart';
import 'package:keuanganku/app/routes/main/pengeluaran/pengeluaran.dart';
import 'package:keuanganku/app/routes/main/pengeluaran/widgets/list_expenselimiter/list_expenselimiter.dart';
import 'package:keuanganku/app/routes/main/wallet/wallet.dart';
import 'package:keuanganku/app/routes/main/wallet/widgets/k_list_wallet/k_list_wallet.dart';
import 'package:keuanganku/app/routes/main/beranda/widgets/statistik/statistik.dart';
import 'package:keuanganku/app/state_bridge.dart';
import 'package:keuanganku/app/widgets/k_future_builder/k_future.dart';
import 'package:keuanganku/database/helper/user_data.dart';
import 'package:keuanganku/database/helper/wallet.dart';
import 'package:keuanganku/database/model/user_data.dart';
import 'package:keuanganku/k_typedef.dart';
import 'package:keuanganku/main.dart';
import 'package:keuanganku/util/dummy.dart';
import 'package:keuanganku/app/routes/main/beranda/widgets/distribusi/distribusi_transaksi.dart' as distribusi_tx;
import 'package:keuanganku/app/routes/main/beranda/widgets/statistik/statistik.dart' as statistik;
import 'package:keuanganku/app/routes/main/beranda/widgets/ringkasan/k_ringkasan.dart' as ringkasan;

import 'package:keuanganku/util/font_style.dart';
import 'package:keuanganku/util/get_currency.dart';

class WidgetData{
  distribusi_tx.WidgetData wxDataDistribusiTransaksi = distribusi_tx.WidgetData();
  statistik.WidgetData wxDataStatistik = statistik.WidgetData();
  ringkasan.Data wxDataRingkasan = ringkasan.Data();
}

class HalamanBeranda extends StatefulWidget {
  const HalamanBeranda({
    super.key, 
    required this.callback
  });

  final VoidCallback callback;
  static StateBridge state = StateBridge();
  static WidgetData widgetData = WidgetData();

  @override
  State<HalamanBeranda> createState() => _HalamanBerandaState();
}

class _HalamanBerandaState extends State<HalamanBeranda> {
  // Events
  KEventHandler updateState     () {
    setState(() {

    });
  }
  KEventHandler callback        () {
    updateState();
    HalamanPengeluaran.state.update();
    HalamanWallet.state.update();
  }

  // Widgets
  KWidget   ringkasanGrafik     () {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            dummyWidth(25,),
            Statistik(widgetData: HalamanBeranda.widgetData.wxDataStatistik,),
            dummyWidth(15),
            DistribusiTransaksi(
              widgetData: HalamanBeranda.widgetData.wxDataDistribusiTransaksi,
              getter: () => HalamanBeranda.widgetData.wxDataDistribusiTransaksi.getData(),
            ),
            dummyWidth(25,),
          ],
        )
    );
  }
  KWidget   listWallet          () {
    void callback(){
      updateState();
      HalamanWallet.state.update();
      HalamanPengeluaran.state.update();
    }

    return FutureBuilder(
      future: SQLHelperWallet().readAll(db.database), 
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return makeCenterWithRow(child: const CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return makeCenterWithRow(child: const Text("Something wrong..."));
        } else {
          return KListWallet(wallets: snapshot.data!, callback: callback);
        }
      },
    );
  }
  KWidget   headingUsername     () {
    KWidget   buildTotalDana           () {
      Future getData() async {
        return await SQLHelperWallet().readSeluruhTotalUangTersedia();
      }
      Widget build(double totalDana){
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text("Total Dana",
                style: kFontStyle(fontSize: 17, family: "QuickSand_Medium", color: Colors.white),
              ),
              Text(formatCurrency(totalDana),
                style: kFontStyle(fontSize: 24, color: Colors.white),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        );
      }
      return KFutureBuilder.build(
          future: getData(),
          whenError: build(0),
          whenWaiting: build(0),
          whenSuccess: (value) => build(value)
      );
    }
    KWidget    buildHeadingUsername(SQLModelUserdata? data){
      String username = "User";
      if (data != null){
        username = data.username ?? "User";
      }
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Hai,", style: kFontStyle(fontSize: 17, color: Colors.white, family: "QuickSand_Medium"),),
              Text(username, style: kFontStyle(fontSize: 24, color: Colors.white),),
            ],
          ),
          buildTotalDana()
        ],
      );
    }
    return KFutureBuilder.build(
        future: SQLHelperUserData().readById(db.database, 1),
        whenError: buildHeadingUsername(null),
        whenWaiting: makeCenterWithRow(child: const CircularProgressIndicator()),
        whenSuccess: (data) => buildHeadingUsername(data)
    );
  }
  KWidget   listExpenseLimiter  () {
    return ListExpenseLimiter(callback: callback);
  }
  KWidget   ringkasan           () {
    return KRingkasan(callback: callback, widgetData: HalamanBeranda.widgetData.wxDataRingkasan);
  }
  KWidget   fiturUtama          (BuildContext context){
    Widget    tombolBuild         ({
      required String title, 
      required String info, 
      required Color color,
      required Function() onTap
    }){
      return 
      GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center    ,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(title, style: kFontStyle(fontSize: 18, color: Colors.white),),
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width * 0.7,
                          child: Text(
                            info, 
                            style: kFontStyle(
                              fontSize: 14, 
                              family: "QuickSand_Medium", 
                              color: Colors.white
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                const Icon(Icons.arrow_forward_ios, color: Colors.white,)
              ],
            ),
          ),
        ),
      );
    }
    Widget    tombolWallet        () {
      void onTap (){
        MainPage.data.currentIndex = 2;
        widget.callback();
      }
      return tombolBuild(
        title: "Wallet", 
        info: "Fitur yang membantu anda untuk melihat dan menambahkan data pemasukan", 
        color: const Color(0xff1C9A3F), 
        onTap: onTap
      );
    }
    Widget    tombolPengeluaran   () {
      void onTap (){
        MainPage.data.currentIndex = 1;
        widget.callback();
      }
      return tombolBuild(
        title: "Pengeluaran", 
        info: "Menambah, melihat atau membatasi pengeluaran anda dengan sangat mudah", 
        color: const Color(0xffB11430),
        onTap: onTap
      );
    }  
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.star, color: Colors.orange,),
              dummyWidth(5),
              Text(
                "Fitur Utama", 
                style: kFontStyle(
                  fontSize: 22, 
                  color: Colors.white,
                ),
              ),
            ],
          ),
          dummyHeight(height: 15),
          tombolWallet(),
          dummyHeight(height: 15),
          tombolPengeluaran(),
        ],
      );
  }
  Widget    buildBody           (BuildContext context){
    const double paddingBottom = 15;
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          headingUsername(),
          dummyHeight(height: paddingBottom-10),
          ringkasan(),
          dummyHeight(height: paddingBottom),
          fiturUtama(context),
          dummyHeight(height: 25),
        ]
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    HalamanBeranda.state.init(updateState);
    return Scaffold(
      backgroundColor: KColors.backgroundPrimary,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: buildBody(context),
      )
    );
  }
}