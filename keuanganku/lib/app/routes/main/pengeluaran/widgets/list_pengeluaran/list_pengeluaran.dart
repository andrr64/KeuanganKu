// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:keuanganku/app/routes/main/pengeluaran/pages/form_data_pengeluaran/form_data_pengeluaran.dart';
import 'package:keuanganku/app/widgets/k_button/k_button.dart';
import 'package:keuanganku/app/widgets/k_card/k_card.dart';
import 'package:keuanganku/app/widgets/k_dialog/k_dialog_info.dart';
import 'package:keuanganku/app/widgets/k_empty/k_empty.dart';
import 'package:keuanganku/app/routes/main/pengeluaran/widgets/k_pengeluaran_item/k_pengeluaran_item.dart';
import 'package:keuanganku/database/helper/expense_category.dart';
import 'package:keuanganku/database/helper/wallet.dart';
import 'package:keuanganku/database/model/category.dart';
import 'package:keuanganku/database/model/expense.dart';
import 'package:keuanganku/database/model/wallet.dart';
import 'package:keuanganku/enum/status.dart';
import 'package:keuanganku/k_typedef.dart';
import 'package:keuanganku/main.dart';
import 'package:keuanganku/util/dummy.dart';

class ListPengeluaran extends StatefulWidget {
  const ListPengeluaran({super.key, required this.listPengeluaran, required this.callback});
  final VoidCallback callback;
  final List<SQLModelExpense> listPengeluaran;

  @override
  State<ListPengeluaran> createState() => _ListPengeluaranState();
}

class _ListPengeluaranState extends State<ListPengeluaran> {
  final icon = SvgPicture.asset(
      "assets/icons/pengeluaran.svg",
      height: 30,
  );

  // EVENTS
  KEventHandler tambahDataBaru    (BuildContext context) {
    List<SQLModelWallet>? listWallet;
    List<SQLModelCategory>? listKategori;
    Future memprosesData() async {
      listWallet = await SQLHelperWallet().readAll(db.database);
      listKategori = await SQLHelperExpenseCategory().readAll(db: db.database);
    }
    memprosesData().then((value) {
      if(listWallet!.isEmpty){
        KDialogInfo(
          title: "Wallet Kosong", 
          info: "Anda tidak memiliki wallet :(", 
          jenisPesan: Pesan.Warning
        ).tampilkanDialog(context);
        return;}
      Navigator.push(
          context,
          MaterialPageRoute(builder: (_){
            return FormDataPengeluaran(
                listWallet: listWallet!,
                listKategori: listKategori!,
                callback: widget.callback
            );
          })
      );
    });
  }

  // WIDGETS
  Widget        emptyBuild        (){
    return makeCenterWithRow(
      child: const Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: KEmpty(),
      )
    );
  }
  Widget        normalBuild       (BuildContext context, Size size){
    return Column(
      children: [
        for(int i=0; i < widget.listPengeluaran.length; i++)
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: SizedBox(
              width: size.width  * 0.875,
              child: KPengeluaranItem(pengeluaran: widget.listPengeluaran[i], callback: widget.callback,),
            ),
          ),
      ],
    );
  }
  KWidget       buildBody         (BuildContext context, Size size){
    if (widget.listPengeluaran.isEmpty){
      return emptyBuild();
    } else {
      return normalBuild(context, size);
    }
  }
  KButton       tombolTambahData  (BuildContext context){
    return KButton(  
      onTap: (){
        tambahDataBaru(context);
      }, 
      title: "Tambah", 
      icon: const Icon(Icons.add)
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return makeCenterWithRow(
      child: KCard(
        title: "Pengeluaran", 
        icon: icon,
        width: size.width * 0.875,
        button: tombolTambahData(context),
        child: buildBody(context, size),
      ) 
    );
  }
}