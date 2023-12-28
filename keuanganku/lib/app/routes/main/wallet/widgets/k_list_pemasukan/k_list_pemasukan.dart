import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:keuanganku/app/routes/main/wallet/pages/form_data_pemasukan/form_data_pemasukan.dart';
import 'package:keuanganku/app/widgets/k_button/k_button.dart';
import 'package:keuanganku/app/widgets/k_card/k_card.dart';
import 'package:keuanganku/app/widgets/k_dialog/k_dialog_info.dart';
import 'package:keuanganku/app/widgets/k_empty/k_empty.dart';
import 'package:keuanganku/app/routes/main/wallet/widgets/k_pemasukan_item/k_pemasukan_item.dart';
import 'package:keuanganku/database/helper/income_category.dart';
import 'package:keuanganku/database/helper/wallet.dart';
import 'package:keuanganku/database/model/income.dart';
import 'package:keuanganku/enum/status.dart';
import 'package:keuanganku/k_typedef.dart';
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
  KWidget       buildBody             (BuildContext context){
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
  KWidget       tombolTambahPemasukan (){
    return KButton(
      onTap: () => tambahPemasukan(context), 
      title: "Tambah", 
      icon: const Icon(Icons.add), 
    );
  }
  KEventHandler tambahPemasukan       (BuildContext context) {
    Future<dynamic>   getData     () async {
      return {
        'listWallet' : await SQLHelperWallet().readAll(db.database),
        'listKategori': await SQLHelperIncomeCategory().readAll(db: db.database),
      };
    }
    KEventHandler     prosesData  (Map<String, dynamic> data){
      if ((data['listWallet'] as List).isEmpty){
        KDialogInfo(
          title: "Wallet Kosong", 
          info: "Anda tidak memiliki wallet :(", 
          jenisPesan: Pesan.Warning
        ).tampilkanDialog(context);
        return;
      }
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_){
            return FormInputPemasukan(
              callback: (){
                widget.callback();
              },
            );
          })
      );
    }
    getData().then((data) => prosesData(data));
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