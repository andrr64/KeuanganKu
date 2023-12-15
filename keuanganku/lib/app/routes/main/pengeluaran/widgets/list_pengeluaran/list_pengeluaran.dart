// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:keuanganku/app/reusable_widgets/k_button/k_button.dart';
import 'package:keuanganku/app/reusable_widgets/k_card/k_card.dart';
import 'package:keuanganku/app/reusable_widgets/k_dialog/k_dialog_info.dart';
import 'package:keuanganku/app/reusable_widgets/k_empty/k_empty.dart';
import 'package:keuanganku/app/reusable_widgets/k_future_builder/k_future.dart';
import 'package:keuanganku/app/routes/main/beranda/beranda.dart';
import 'package:keuanganku/app/routes/main/pengeluaran/pages/form_data_pengeluaran/form_data_pengeluaran.dart';
import 'package:keuanganku/app/routes/main/pengeluaran/pengeluaran.dart';
import 'package:keuanganku/app/routes/main/pengeluaran/widgets/k_pengeluaran_item/k_pengeluaran_item.dart';
import 'package:keuanganku/app/routes/main/wallet/wallet.dart';
import 'package:keuanganku/database/helper/data_kategori.dart';
import 'package:keuanganku/database/helper/data_pengeluaran.dart';
import 'package:keuanganku/database/helper/data_wallet.dart';
import 'package:keuanganku/database/model/data_kategori.dart';
import 'package:keuanganku/database/model/data_wallet.dart';
import 'package:keuanganku/enum/status.dart';
import 'package:keuanganku/main.dart';
import 'package:keuanganku/util/dummy.dart';

class ListPengeluaran extends StatefulWidget {
  const ListPengeluaran({super.key});

  @override
  State<ListPengeluaran> createState() => _ListPengeluaranState();
}

class _ListPengeluaranState extends State<ListPengeluaran> {
  void tambahDataBaru(BuildContext context) async {
    List<SQLModelWallet> listWallet = await SQLHelperWallet().readAll(db.database);
    if(listWallet.isEmpty){
      KDialogInfo(
        title: "Wallet Kosong", 
        info: "Anda tidak memiliki wallet :(", 
        jenisPesan: Pesan.Warning
      ).tampilkanDialog(context);
      return;
    }
    List<SQLModelKategoriTransaksi> listKategori = await SQLHelperKategori().readAll(db: db.database);
    Navigator.push(context, MaterialPageRoute(builder: (_){
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
  final icon = SvgPicture.asset(
      "assets/icons/pengeluaran.svg",
      height: 30,
  );

  Widget buildBody(BuildContext context, Size size){
    return KFutureBuilder.build(
      context: context, 
      future: SQLHelperPengeluaran().readAll(db.database), 
      buildWhenSuccess: (data){
        return Column(
          children: [
            for(int i=0; i < data.length; i++)
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: KPengeluaranItem(pengeluaran: data[i]),
              ),
          ],
        );
      }, 
      buildWhenEmpty: () => const KEmpty(), 
      buildWhenError: () => const KEmpty(),
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
        button: KButton(  
          onTap: (){
            tambahDataBaru(context);
          }, 
          title: "Baru", 
          icon: const Icon(Icons.add),
        ),
        child: buildBody(context, size),
      ) 
    );
  }
}