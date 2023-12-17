// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:keuanganku/app/app_colors.dart';
import 'package:keuanganku/app/routes/main/beranda/beranda.dart';
import 'package:keuanganku/app/routes/main/beranda/widgets/distribusi/distribusi_transaksi.dart' as distribusiTx;
import 'package:keuanganku/app/routes/main/pengeluaran/pages/form_data_pengeluaran/form_data_pengeluaran.dart';
import 'package:keuanganku/app/routes/main/pengeluaran/pengeluaran.dart';
import 'package:keuanganku/app/routes/main/pengeluaran/widgets/k_pengeluaran_item/k_pengeluaran_item.dart';
import 'package:keuanganku/app/routes/main/wallet/pages/form_data_pemasukan/form_data_pemasukan.dart';
import 'package:keuanganku/app/routes/main/wallet/wallet.dart';
import 'package:keuanganku/app/routes/main/wallet/widgets/k_pemasukan_item/k_pemasukan_item.dart';
import 'package:keuanganku/app/widgets/k_app_bar/k_app_bar.dart';
import 'package:keuanganku/app/widgets/k_button/k_button.dart';
import 'package:keuanganku/app/widgets/k_card/k_card.dart';
import 'package:keuanganku/app/widgets/k_empty/k_empty.dart';
import 'package:keuanganku/database/helper/data_kategori_pemasukan.dart';
import 'package:keuanganku/database/helper/data_kategori_pengeluaran.dart';
import 'package:keuanganku/database/helper/data_pemasukan.dart';
import 'package:keuanganku/database/helper/data_pengeluaran.dart';
import 'package:keuanganku/database/model/data_kategori.dart';
import 'package:keuanganku/database/model/data_pemasukan.dart';
import 'package:keuanganku/database/model/data_pengeluaran.dart';
import 'package:keuanganku/database/model/data_wallet.dart';
import 'package:keuanganku/main.dart';
import 'package:keuanganku/util/dummy.dart';
import 'package:keuanganku/util/font_style.dart';
import 'package:keuanganku/util/get_currency.dart';

class Data {
  distribusiTx.WidgetData distribusiTxData = distribusiTx.WidgetData();
}

class DetailWallet extends StatefulWidget {
  DetailWallet({super.key, required this.wallet});
  final SQLModelWallet wallet;
  final Data data = Data();

  @override
  State<DetailWallet> createState() => _DetailWalletState();
}

class _DetailWalletState extends State<DetailWallet> {
  Widget heading(BuildContext context){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
      child: IntrinsicHeight(
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
                    )
                  ],
                )
              ],
          )
        ),
      ),
    );
  }

  Widget buildListPemasukan(BuildContext context, List<SQLModelPemasukan> listPemasukan){
    final icon = SvgPicture.asset("assets/icons/pemasukan.svg");
    if (listPemasukan.isEmpty){
      return makeCenterWithRow(child: const KEmpty());
    }
    return KCard(
        width: MediaQuery.sizeOf(context).width * 0.875,
        title: "Pemasukan",
        icon: icon,
        button: KButton(
            onTap: () async {
              List<SQLModelWallet> listWallet = [widget.wallet];
              List<SQLModelKategoriTransaksi> listKategoriPemasukan = await SQLHelperKategoriPemasukan().readAll(db: db.database);
              Navigator.push(context, MaterialPageRoute(builder: (_) => FormInputPemasukan(
                  listKategori: listKategoriPemasukan,
                  listWallet: listWallet,
                  callback: (){
                    setState(() {

                    });
                    HalamanPengeluaran.state.update();
                    HalamanWallet.state.update();
                    HalamanBeranda.state.update();
                  }
              )));
            },
            title: "Tambah",
            icon: Icon(Icons.add)
        ),
        child: Column(
          children: [
            for(int i=0;i < listPemasukan.length; i++)
              KPemasukanItem(size: Size(MediaQuery.sizeOf(context).width * 0.875, 40), pemasukan: listPemasukan[i]),
          ],
        )
    );
  }
  Widget buildListPengeluaran(BuildContext context, List<SQLModelPengeluaran> listPengeluaran){
    if (listPengeluaran.isEmpty){
      return makeCenterWithRow(child: const KEmpty());
    }

    return Column(
      children: [
        for(int i=0;i < listPengeluaran.length; i++)
          KPengeluaranItem(pengeluaran: listPengeluaran[i]),
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
  
  Widget listPengeluaran(BuildContext context){
    final icon = SvgPicture.asset("assets/icons/pengeluaran.svg");
    return makeCenterWithRow(
        child: FutureBuilder(
            future: SQLHelperPengeluaran().readByWalletId(widget.wallet.id, db.database),
            builder: (_, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return const Text("Sadly, something wrong...");
              } else {
                return KCard(
                    width: MediaQuery.sizeOf(context).width * 0.875,
                    title: "Pengeluaran",
                    icon: icon,
                    button: KButton(
                        onTap: () async {
                          List<SQLModelWallet> listWallet = [widget.wallet];
                          List<SQLModelKategoriTransaksi> listKategoriPemasukan = await SQLHelperKategoriPengeluaran().readAll(db: db.database);
                          Navigator.push(context, MaterialPageRoute(builder: (_) => FormDataPengeluaran(
                              listKategori: listKategoriPemasukan,
                              listWallet: listWallet,
                              callback: (){
                                setState(() {

                                });
                                HalamanPengeluaran.state.update();
                                HalamanWallet.state.update();
                                HalamanBeranda.state.update();
                              }
                          )));
                        },
                        title: "Tambah",
                        icon: Icon(Icons.add)
                    ),
                    child: buildListPengeluaran(context, snapshot.data!)
                );
              }
            }
        )
    );
  }
  Widget listPemasukan(BuildContext context){
    return makeCenterWithRow(
      child: FutureBuilder(
          future: SQLHelperPemasukan().readDataByWalletId(widget.wallet.id, db.database),
          builder: (_, snapshot){
            if (snapshot.connectionState == ConnectionState.waiting){
              return makeCenterWithRow(child: const CircularProgressIndicator());
            } else if (snapshot.hasError){
              return makeCenterWithRow(child: const Text("Sadly, something wrong..."));
            } else {
              return buildListPemasukan(context, snapshot.data!);
            }
          }
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ApplicationColors.primary,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dummyPadding(height: 50),
              KPageAppBar(
                title: "Detail Wallet",
                menuButton: GestureDetector(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.arrow_back_ios, color: Colors.white,),
                ),
              ),
              heading(context),
              listPemasukan(context),
              dummyPadding(height: 25),
              listPengeluaran(context),
              dummyPadding(height: 25),
              buildDistribusiPengeluaran(context),
              dummyPadding(height: 100)
            ],
          ),
        ),
      ),
    );
  }
}
