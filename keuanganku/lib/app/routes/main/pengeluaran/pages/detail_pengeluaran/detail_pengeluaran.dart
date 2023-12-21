import 'package:flutter/material.dart';
import 'package:keuanganku/app/routes/main/pengeluaran/pages/form_data_pengeluaran/form_data_pengeluaran.dart';
import 'package:keuanganku/database/helper/expense_category.dart';
import 'package:keuanganku/database/helper/wallet.dart';
import 'package:keuanganku/database/model/category.dart';
import 'package:keuanganku/database/model/expense.dart';
import 'package:keuanganku/database/model/wallet.dart';
import 'package:keuanganku/main.dart';

class DetailPengeluaran extends StatefulWidget {
  const DetailPengeluaran({super.key, required this.pengeluaran, required this.callback});
  final SQLModelExpense pengeluaran;
  final VoidCallback callback;
  @override
  State<DetailPengeluaran> createState() => _DetailPengeluaranState();
}

class _DetailPengeluaranState extends State<DetailPengeluaran> {
  Widget buildBody(BuildContext context){
    Future getData()  async {
      List<SQLModelWallet> wallet = await SQLHelperWallet().readAll(db.database);
      List<SQLModelCategory> kategori = await SQLHelperExpenseCategory().readAll(db: db.database);
      return {
        'wallet': wallet,
        'kategori': kategori,
        'walletAndKategori': {
          'wallet': await widget.pengeluaran.wallet,
          'kategori': await widget.pengeluaran.kategori
        }
      };
    }

    return FutureBuilder(
      future: getData(),
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator(),);
        } else if (snapshot.hasError) {
          return const Center(child: Text("Sadly, something wrong"));
        } else {
          return FormDataPengeluaran(
            listWallet: snapshot.data!['wallet'],
            listKategori: snapshot.data!['kategori'],
            callback: (){
              widget.callback();
              Navigator.pop(context);
            },
            withData: true,
            pengeluaran: widget.pengeluaran,
            walletAndKategori: snapshot.data!['walletAndKategori'],
          );
        }
      },
    );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildBody(context),
    );
  }
}
