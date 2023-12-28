import 'package:flutter/material.dart';
import 'package:keuanganku/app/routes/main/wallet/pages/form_data_pemasukan/form_data_pemasukan.dart';
import 'package:keuanganku/app/widgets/k_future_builder/k_future.dart';
import 'package:keuanganku/database/helper/income_category.dart';
import 'package:keuanganku/database/helper/wallet.dart';
import 'package:keuanganku/database/model/income.dart';
import 'package:keuanganku/main.dart';

class Data {
  Future<Map<String, dynamic>> getWalletDanKategori() async {
    return {
      'listWallet' : await SQLHelperWallet().readAll(db.database),
      'listKategori': await SQLHelperIncomeCategory().readAll(db: db.database),
    };
  }
}

class DetailPemasukan extends StatefulWidget {
  DetailPemasukan({super.key, required this.dataPemasukan, required this.callback});
  final SQLModelIncome dataPemasukan;
  final Data data = Data();
  final VoidCallback callback;

  @override
  State<DetailPemasukan> createState() => _DetailPemasukanState();
}

class _DetailPemasukanState extends State<DetailPemasukan> {
  Widget buildBody(BuildContext context){
    return KFutureBuilder.build(
      future: widget.data.getWalletDanKategori(), 
      whenError: const Scaffold(
        body: Center(
          child: Text("Sadly, someting wrong..."),
        ),
      ), 
      whenWaiting: const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      whenSuccess: (data){
        return FormInputPemasukan(
          callback: widget.callback, 
          isWithData: true,
          theDataIfIsWithData: widget.dataPemasukan,
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return buildBody(context);
  }
}