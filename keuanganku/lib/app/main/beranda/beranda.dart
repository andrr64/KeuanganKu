import 'package:flutter/material.dart';
import 'package:keuanganku/API/database/helper/data_pemasukan.dart';
import 'package:keuanganku/app/main/beranda/widgets/daftar_transaksi/daftar_transaksi.dart';
import 'package:keuanganku/app/main/beranda/widgets/ringkasan_grafik/ringkasan_grafik.dart';
import 'package:keuanganku/app/main/beranda/widgets/total_dana/total_dana.dart';
import 'package:keuanganku/app/main/wrap.dart';
import 'package:keuanganku/app/state_bridge.dart';
import 'package:keuanganku/database/helper/data_pengeluaran.dart';
import 'package:keuanganku/enum/data_transaksi.dart';
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
    Future readDataPengeluaranAtauPemasukan(JenisTransaksi jenisTransaksi, WaktuTransaksi waktuTransaksi) async{
      switch(jenisTransaksi){
        case JenisTransaksi.PEMASUKAN:
          return SQLDataPemasukan().readSpecific(waktuTransaksi, db.database);
        case JenisTransaksi.PENGELUARAN:
          return SQLDataPengeluaran().readAll(db.database);
        default:
          return Future(() => []);
      }
    }

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
                  future: readDataPengeluaranAtauPemasukan(RingkasanGrafik.data.jenisTransaksi, RingkasanGrafik.data.waktuTransaksi),
                  builder: (context, snapshot){
                    if (snapshot.hasData){
                        return DaftarTransaksi(context, listData: snapshot.data!).getWidget();
                    } else {
                      return const Center(child: SizedBox(height: 50, width: 50, child: CircularProgressIndicator(),));
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
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildBody(),
        ],
      ),
    );
  }
}
