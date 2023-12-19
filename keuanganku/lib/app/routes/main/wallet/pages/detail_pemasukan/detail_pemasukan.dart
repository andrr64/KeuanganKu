import 'package:flutter/material.dart';
import 'package:keuanganku/app/routes/main/wallet/pages/form_data_pemasukan/form_data_pemasukan.dart';
import 'package:keuanganku/database/helper/expense_category.dart';
import 'package:keuanganku/database/helper/wallet.dart';
import 'package:keuanganku/database/model/income.dart';
import 'package:keuanganku/main.dart';
import 'package:keuanganku/util/dummy.dart';

class Data {
  Future<Map<String, dynamic>> getWalletDanKategori() async {
    return {
      'listWallet' : await SQLHelperWallet().readAll(db.database),
      'listKategori': await SQLHelperIncomeCategory().readAll(db: db.database),
    };
  }
}

class DetailPemasukan extends StatefulWidget {
  DetailPemasukan({super.key, required this.pemasukan, required this.callback});
  final SQLModelIncome pemasukan;
  final Data data = Data();
  final VoidCallback callback;

  @override
  State<DetailPemasukan> createState() => _DetailPemasukanState();
}

class _DetailPemasukanState extends State<DetailPemasukan> {
  Widget buildBody(BuildContext context){
    return FutureBuilder(
      future: widget.data.getWalletDanKategori(), 
      builder: (_, snapshot){
        if (snapshot.connectionState == ConnectionState.waiting){
          return makeCenterWithRow(child: const CircularProgressIndicator());
        } else if (snapshot.hasError){
          return makeCenterWithRow(child: const Text("Sadly, someting wrong..."));
        } else {
          return FormInputPemasukan(
            callback: (){
              widget.callback();
            }, 
            listWallet: snapshot.data!['listWallet'], 
            listKategori: snapshot.data!['listKategori'],
            isWithData: true,
            pemasukan: widget.pemasukan,
          );
        }
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return buildBody(context);
  }
}