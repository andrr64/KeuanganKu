// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:keuanganku/app/app_colors.dart';
import 'package:keuanganku/app/routes/main/pengeluaran/pages/form_data_pengeluaran/form_data_pengeluaran.dart';
import 'package:keuanganku/app/state_bridge.dart';
import 'package:keuanganku/database/helper/data_wallet.dart';
import 'package:keuanganku/database/model/data_wallet.dart';
import 'package:keuanganku/main.dart';
import 'package:keuanganku/util/dummy.dart';


class HalamanPengeluaran extends StatefulWidget {
  const HalamanPengeluaran({super.key});
  static StateBridge state = StateBridge();


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
  
  void tambahDataBaru() async {
    List<SQLModelWallet> listWallet = await SQLHelperWallet().readAll(db.database);
    showModalBottomSheet(
      context: context, 
      isScrollControlled: true,
      builder: (context) => FormDataPengeluaran(
        listWallet: listWallet,
        onSaveCallback: (){
          setState(() {});
        },
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: ApplicationColors.primary,
      floatingActionButton: ElevatedButton(onPressed: tambahDataBaru, child: Icon(Icons.add)),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            dummyPadding(height: 25),
          ],
        ),
      )
    );
  }
}