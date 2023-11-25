import 'package:flutter/material.dart';
import 'package:keuanganku/app/main/beranda/widgets/daftar_transaksi/daftar_transaksi.dart';
import 'package:keuanganku/app/main/beranda/widgets/ringkasan_grafik/ringkasan_grafik.dart';
import 'package:keuanganku/app/main/beranda/widgets/total_dana/total_dana.dart';
import 'package:keuanganku/app/state_bridge.dart';

class HalamanBeranda extends StatefulWidget {
  const HalamanBeranda({super.key, required this.updateParentState});
  final void Function() updateParentState;

  static StateBridge state = StateBridge();

  @override
  State<HalamanBeranda> createState() => _HalamanBerandaState();
}

class _HalamanBerandaState extends State<HalamanBeranda> {
  final double vPadding = 7.6;

  void updateState(){
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    HalamanBeranda.state.init(updateState);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: vPadding,),
            TotalDana(context).getWidget(),
            RingkasanGrafik(context).getWidget(),
            DaftarTransaksi(context).getWidget()
          ],
        ),
      ),
    );
  }
}