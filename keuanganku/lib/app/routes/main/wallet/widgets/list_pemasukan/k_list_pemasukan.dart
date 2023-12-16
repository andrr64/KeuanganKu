// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:keuanganku/app/routes/main/beranda/beranda.dart';
import 'package:keuanganku/app/routes/main/pengeluaran/pengeluaran.dart';
import 'package:keuanganku/app/routes/main/wallet/pages/form_data_pemasukan/form_data_pemasukan.dart';
import 'package:keuanganku/app/routes/main/wallet/wallet.dart';
import 'package:keuanganku/app/widgets/k_button/k_button.dart';
import 'package:keuanganku/app/widgets/k_card/k_card.dart';
import 'package:keuanganku/app/widgets/k_dialog/k_dialog_info.dart';
import 'package:keuanganku/app/widgets/k_empty/k_empty.dart';
import 'package:keuanganku/app/routes/main/wallet/widgets/k_pemasukan_item/k_pemasukan_item.dart';
import 'package:keuanganku/database/helper/data_kategori_pemasukan.dart';
import 'package:keuanganku/database/helper/data_wallet.dart';
import 'package:keuanganku/database/model/data_kategori.dart';
import 'package:keuanganku/database/model/data_pemasukan.dart';
import 'package:keuanganku/database/model/data_wallet.dart';
import 'package:keuanganku/enum/status.dart';
import 'package:keuanganku/main.dart';
import 'package:keuanganku/util/dummy.dart';

class KListPemasukan extends StatefulWidget {
  const KListPemasukan({super.key, required this.listPemasukan, required this.callback});
  final List<SQLModelPemasukan> listPemasukan;
  final VoidCallback callback;
  
  @override
  State<KListPemasukan> createState() => KListPemasukanState();
}

class KListPemasukanState extends State<KListPemasukan> {
  Widget buildBody(BuildContext context){
    const int maxItems = 5;
    final size = MediaQuery.sizeOf(context);
    if (widget.listPemasukan.isEmpty){
      return const KEmpty();
    }
    final moreThanMaxItems = widget.listPemasukan.length > maxItems;
    final dataLength = moreThanMaxItems? maxItems : widget.listPemasukan.length;
    return Column(
      children: [
        for(int i = 0; i < dataLength; i++) KPemasukanItem(size: Size(size.width * 0.875, 40), pemasukan: widget.listPemasukan[i]),
        makeCenterWithRow(
          child: Column(
            children: [
              dummyPadding(height: 10),
              KButton(
                onTap: (){}, 
                title: "Lihat Selengkapnya", 
                icon: const Icon(Icons.more_horiz_outlined)
              ),
            ],
          )
        )
      ],
    );
  }
  Widget tombolTambahPemasukan(){
    return KButton(
      onTap: () => tambahPemasukan(context), 
      title: "Tambah", 
      icon: const Icon(Icons.add), 
    );
  }
  KEventHandler tambahPemasukan(BuildContext context) async {
    List<SQLModelWallet> listWallet = await SQLHelperWallet().readAll(db.database);
    if (listWallet.isEmpty){
      KDialogInfo(
        title: "Wallet Kosong", 
        info: "Anda tidak memiliki wallet :(", 
        jenisPesan: Pesan.Warning
      ).tampilkanDialog(context);
      return;
    }
    List<SQLModelKategoriTransaksi> listKategori  = await SQLHelperKategoriPemasukan().readAll(db: db.database);

    Navigator.push(
      context,
      MaterialPageRoute(builder: (_){
        return FormInputPemasukan(
          listWallet: listWallet,
          listKategori: listKategori,
          callback: (){
            HalamanWallet.state.update();
            HalamanPengeluaran.state.update();
            HalamanBeranda.state.update();
          },
        );
      })
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final icon = SvgPicture.asset("assets/icons/pemasukan.svg");
    return Padding(
      padding: const EdgeInsets.only(left: 25),
      child: KCard(
        title: "Pemasukan",
        icon: icon,
        width: size.width * 0.875,
        button: tombolTambahPemasukan(),
        child: buildBody(context),
      ),
    );
  }
}
