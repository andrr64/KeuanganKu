import 'package:flutter/material.dart';
import 'package:keuanganku/app/app_colors.dart';
import 'package:keuanganku/app/main/beranda/widgets/daftar_transaksi/daftar_transaksi.dart';
import 'package:keuanganku/app/main/beranda/widgets/ringkasan_grafik/ringkasan_grafik.dart';
import 'package:keuanganku/app/main/beranda/widgets/total_dana/total_dana.dart';
import 'package:keuanganku/app/state_bridge.dart';
import 'package:keuanganku/database/helper/data_pengeluaran.dart';
import 'package:keuanganku/main.dart';

class HalamanBeranda extends StatefulWidget {
  const HalamanBeranda({super.key, required this.updateParentState});

  final void Function() updateParentState;

  static StateBridge state = StateBridge();

  @override
  State<HalamanBeranda> createState() => _HalamanBerandaState();
}

class _HalamanBerandaState extends State<HalamanBeranda> {
  final double vPadding = 7.6;



  @override
  void initState() {
    super.initState();
    HalamanBeranda.state.init(updateState);
  }

  void updateState() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            TotalDana(context).getWidget(),
            RingkasanGrafik(context).getWidget(),
            FutureBuilder(
              future: DataPengeluaran().readAll(db.database), 
              builder: (context, snapshot){
                if (snapshot.hasData){
                  if (snapshot.data!.isEmpty){
                    return const Text("Dude, you dont have data");
                  } else {
                    return Padding(
                      padding:const EdgeInsets.only(left: 15),
                      child: DaftarTransaksi(context, listData: snapshot.data!).getWidget()
                    );
                  }
                } else {
                  return const CircularProgressIndicator(color: ApplicationColors.primary,);
                }
              }
            )
          ],
        ),
      )
    );
  }
}
