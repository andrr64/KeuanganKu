import 'package:flutter/material.dart';
import 'package:keuanganku/app/reusable_components/ringkasan_grafik/ringkasan_grafik.dart' as ringkasan_grafik;
import 'package:keuanganku/app/reusable_components/total_dana/total_dana.dart';
import 'package:keuanganku/app/state_bridge.dart';
import 'package:keuanganku/util/dummy.dart';

class Data {
  ringkasan_grafik.RuCRingkasanGrafikData widgetRingkasanGrafik = ringkasan_grafik.RuCRingkasanGrafikData();
}

class HalamanBeranda extends StatefulWidget {
  const HalamanBeranda({super.key, required this.updateParentState});

  final void Function() updateParentState;
  
  static Data data = Data();
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

  // Widgets
  
  /// Total akumulasi seluruh wallet
  Widget widgetTotalDana() => RuCTotalDana(context, totalDana: 2000000, judul: "Total Dana").getWidget();
  
  /// Grafik bar chart
  Widget widgetRingkasanGrafik() => 
    ringkasan_grafik.RuCRingkasanGrafik(
      context, 
      data: HalamanBeranda.data.widgetRingkasanGrafik,
      onUpdate: HalamanBeranda.state.update!)
        .getWidget(); 

  Widget buildBody(){
    return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: 
          Column(
            children: [
              widgetTotalDana(),
              dummyPadding(height: 10),
              widgetRingkasanGrafik(),
              dummyPadding(height: 10),
              // SizedBox(
              //   width: MediaQuery.sizeOf(context).width * 0.9,
              //   child: FutureBuilder(
              //     future: helper_pemasukan_pengeluaran.readDataPengeluaranAtauPemasukan(
              //         RingkasanGrafik.data.jenisTransaksi,
              //         RingkasanGrafik.data.waktuTransaksi
              //     ),
              //     builder: (context, snapshot){
              //       if (snapshot.hasData){
              //           return DaftarTransaksi(context, listData: snapshot.data!).getWidget();
              //       } else {
              //         return const Center(child: SizedBox(height: 50, width: 50, child: CircularProgressIndicator(),));
              //       }
              //     }
              //   ),
              // ),
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
