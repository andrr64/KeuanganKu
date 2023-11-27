import 'package:flutter/material.dart';
import 'package:keuanganku/app/main/beranda/widgets/daftar_transaksi/daftar_transaksi.dart';
import 'package:keuanganku/app/main/beranda/widgets/ringkasan_grafik/ringkasan_grafik.dart';
import 'package:keuanganku/app/main/beranda/widgets/total_dana/total_dana.dart';
import 'package:keuanganku/app/main/wrap.dart';
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

  Widget buildBody(){
    return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: 
          Column(
            children: [
              TotalDana(context).getWidget(),
              padding(y: 10),
              RingkasanGrafik(context).getWidget(),
              padding(y: 10),
              SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.9,
                child: FutureBuilder(
                  future: SQLDataPengeluaran().readAll(db.database), 
                  builder: (context, snapshot){
                    if (snapshot.hasData){
                      if (snapshot.data!.isNotEmpty){
                        return DaftarTransaksi(context, listData: snapshot.data!).getWidget();
                      } else {
                        return const Text("tidak ada data ...");
                      }
                    } else {
                      return const CircularProgressIndicator();
                    }
                  }
                ),
              ),
            ],
          ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(left: 15),
        child: buildBody(),
      ),
    );
  }
}
