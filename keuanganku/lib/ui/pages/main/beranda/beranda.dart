// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:keuanganku/ui/pages/main/beranda/widgets/daftar_transaksi/daftar_transaksi.dart';
import 'package:keuanganku/ui/pages/main/beranda/widgets/ringkasan_grafik/ringkasan_grafik.dart';
import 'package:keuanganku/ui/pages/main/beranda/widgets/total_dana/total_dana.dart';
import 'package:keuanganku/ui/state_bridge.dart';
import 'package:keuanganku/ui/application_colors.dart';


class Properties {
  final Color primaryColor = ApplicationColors.primary;
}

class HalamanBeranda extends StatefulWidget {
  /// Class Halaman ini memuat seluruh ringkasan pemasukan dan pengeluaran serta fitur analisa
  const HalamanBeranda({super.key, required this.updateParentState});
  final void Function() updateParentState;

  static StateBridge state = StateBridge();
  static Properties properties = Properties();

  @override
  State<HalamanBeranda> createState() => _HalamanBerandaState();
}

class _HalamanBerandaState extends State<HalamanBeranda> {
  final double vPadding = 7.6;
  
  // Widgets
  WIDGET_totalDana(){
    return const TotalDana();
  }

  WIDGET_ringkasanGrafik(){
    return const RingkasanGrafik();
  }

  WIDGET_daftarTransaksi() {
    return const DaftarTransaksi();
  }
  //+--------------------------------+

  void updateState(){
    setState(() {
      DaftarTransaksi.state.update!();
      RingkasanGrafik.state.update!();
      TotalDana.state.update!();
    });
  }

  @override
  void initState() {
    super.initState();
    HalamanBeranda.state.init(updateState);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: vPadding,),
            WIDGET_totalDana(),
            WIDGET_ringkasanGrafik(),
            WIDGET_daftarTransaksi()
          ],
        ),
      ),
    );
  }
}
