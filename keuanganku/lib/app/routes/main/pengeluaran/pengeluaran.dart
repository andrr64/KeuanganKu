// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:keuanganku/app/app_colors.dart';
import 'package:keuanganku/app/reusable_widgets/k_app_bar/k_app_bar.dart';
import 'package:keuanganku/app/reusable_widgets/k_dialog/k_dialog_info.dart';
import 'package:keuanganku/app/routes/main/beranda/beranda.dart';
import 'package:keuanganku/app/routes/main/pengeluaran/pages/form_data_pengeluaran/form_data_pengeluaran.dart';
import 'package:keuanganku/app/routes/main/wallet/wallet.dart';
import 'package:keuanganku/app/state_bridge.dart';
import 'package:keuanganku/database/helper/data_kategori.dart';
import 'package:keuanganku/database/helper/data_wallet.dart';
import 'package:keuanganku/database/model/data_kategori.dart';
import 'package:keuanganku/database/model/data_wallet.dart';
import 'package:keuanganku/enum/status.dart';
import 'package:keuanganku/main.dart';
import 'package:keuanganku/util/dummy.dart';


class HalamanPengeluaran extends StatefulWidget {
  const HalamanPengeluaran({super.key, required this.parentScaffoldKey});
  static StateBridge state = StateBridge();
  final GlobalKey<ScaffoldState> parentScaffoldKey;

  @override
  State<HalamanPengeluaran> createState() => _HalamanPengeluaranState();
}

class _HalamanPengeluaranState extends State<HalamanPengeluaran> {

  @override
  void initState() {
    super.initState();
    HalamanPengeluaran.state.init(() { 
      setState(() {
        
      });
    });
  }

  void updateState(){
    setState(() {});
  }
  
  void tambahDataBaru(BuildContext cntx) async {
    List<SQLModelWallet> listWallet = await SQLHelperWallet().readAll(db.database);
    if(listWallet.isEmpty){
      KDialogInfo(title: "Wallet Kosong", info: "Anda tidak memiliki wallet :(", jenisPesan: Pesan.Warning).tampilkanDialog(context);
      return;
    }
    List<SQLModelKategoriTransaksi> listKategori = await SQLHelperKategori().readAll(db: db.database);
    Navigator.push(cntx, MaterialPageRoute(builder: (context){
      return FormDataPengeluaran(
        onSaveCallback: (){
          HalamanPengeluaran.state.update!();
          HalamanBeranda.state.update!();
          HalamanWallet.state.update!();
        }, 
        listWallet: listWallet,
        listKategori: listKategori,
      );
    }));
  }

  Widget drawerButton(){
    return GestureDetector(
      onTap: (){
        widget.parentScaffoldKey.currentState!.openDrawer();
      },
      child: const Icon(
        Icons.menu, 
        size: 30, 
        color: Colors.white,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: ApplicationColors.primary,
      floatingActionButton: ElevatedButton(
        onPressed: (){
          tambahDataBaru(context);
        }, 
        child: Icon(Icons.add)
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            dummyPadding(height: 50),
            KPageAppBar(
              title: "Pengeluaran", 
              menuButton: drawerButton()
            )
          ],
        ),
      )
    );
  }
}