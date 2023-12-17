import 'dart:html';

import 'package:flutter/material.dart';
import 'package:keuanganku/app/routes/main/pengeluaran/pages/form_data_pengeluaran/form_data_pengeluaran.dart';
import 'package:keuanganku/database/model/data_kategori.dart';
import 'package:keuanganku/database/model/data_pengeluaran.dart';
import 'package:keuanganku/database/model/data_wallet.dart';

class DialogDetailPengeluaran extends StatefulWidget {
  const DialogDetailPengeluaran({super.key, required this.pengeluaran});
  final SQLModelPengeluaran pengeluaran;

  @override
  State<DialogDetailPengeluaran> createState() => DetailDataPengeluaran();
}

class DetailDataPengeluaran extends State<DialogDetailPengeluaran> {
  Widget buildBody(BuildContext context){
    Future getData()  async {
      SQLModelWallet wallet = await widget.pengeluaran.wallet;
      SQLModelKategoriTransaksi kategori = await widget.pengeluaran.kategori;
      return {
        'wallet': wallet,
        'kategori': kategori
      };
    }

    return FutureBuilder(
      future: getData(),
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Center(child: Text("Sadly, something wrong"));
        } else {
          return FormDataPengeluaran(
            listWallet: [snapshot.data!['wallet']],
            listKategori: [snapshot.data!['kategori']],
            callback: () {},
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
