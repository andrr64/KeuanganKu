// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:keuanganku/app/routes/main/wallet/pages/form_data_pemasukan/form_data_pemasukan.dart';
import 'package:keuanganku/app/widgets/k_button/k_button.dart';
import 'package:keuanganku/app/widgets/k_card/k_card.dart';
import 'package:keuanganku/app/widgets/k_dialog/k_dialog_info.dart';
import 'package:keuanganku/app/widgets/k_empty/k_empty.dart';
import 'package:keuanganku/app/routes/main/wallet/widgets/k_pemasukan_item/k_pemasukan_item.dart';
import 'package:keuanganku/database/helper/expense_category.dart';
import 'package:keuanganku/database/helper/wallet.dart';
import 'package:keuanganku/database/model/category.dart';
import 'package:keuanganku/database/model/income.dart';
import 'package:keuanganku/database/model/wallet.dart';
import 'package:keuanganku/enum/status.dart';
import 'package:keuanganku/main.dart';
import 'package:keuanganku/util/dummy.dart';

class KListPemasukan extends StatefulWidget {
  const KListPemasukan({super.key, required this.listPemasukan, required this.callback});
  final List<SQLModelIncome> listPemasukan;
  final VoidCallback callback;
  
  @override
  State<KListPemasukan> createState() => KListPemasukanState();
}

class KListPemasukanState extends State<KListPemasukan> {
  Widget buildBody(BuildContext context){
    final size = MediaQuery.sizeOf(context);
    if (widget.listPemasukan.isEmpty){
      return const KEmpty();
    }
    final dataLength = widget.listPemasukan.length;

    return Column(
      children: [
        for(int i = 0; i < dataLength; i++) 
          KPemasukanItem(
            size: Size(size.width * 0.875, 40), 
            pemasukan: widget.listPemasukan[i],
            callback: widget.callback,
          ),
        makeCenterWithRow(
          child: Column(
            children: [
              dummyHeight(height: 10),
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
    List<SQLModelCategory> listKategori  = await SQLHelperIncomeCategory().readAll(db: db.database);

    Navigator.push(
      context,
      MaterialPageRoute(builder: (_){
        return FormInputPemasukan(
          listWallet: listWallet,
          listKategori: listKategori,
          callback: (){
            widget.callback();
          },
        );
      })
    );
  }

  @override
  Widget build(BuildContext context) {
    final icon = SvgPicture.asset("assets/icons/pemasukan.svg");
    return KCard(
      title: "Pemasukan",
      icon: icon,
      button: tombolTambahPemasukan(),
      child: buildBody(context),
    );
  }
}
