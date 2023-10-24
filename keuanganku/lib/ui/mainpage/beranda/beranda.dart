import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:keuanganku/ui/mainpage/beranda/widgets/tombol_navigasi_transaksi/tombol_navigas_transaksi.dart';
import 'package:keuanganku/ui/mainpage/beranda/widgets/tombol_navigasi_waktu/TombolNavigasiWaktu.dart';
import 'package:keuanganku/ui/mainpage/beranda/widgets/total_pemasukan/total_pemasukan.dart';
import 'package:keuanganku/ui/mainpage/beranda/widgets/total_pengeluaran/total_pengeluaran.dart';

class ObjectProperty {
  // ignore: non_constant_identifier_names
  // static Color warna_background_scaffold = const Color(0xffEFF4F8);
  // ignore: non_constant_identifier_names
  static Color warna_background_scaffold = Colors.white;
  static Color warnaFont = const Color(0xff3F4245);
  static AppBar appBar = AppBar(
        systemOverlayStyle: 
          const SystemUiOverlayStyle(
            statusBarColor:  Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
          ),
        title: Text(
            "Ringkasan",
            style: TextStyle(
              color: ObjectProperty.warnaFont,
              fontFamily: "Inter_Bold",
              fontSize: 34,
            ),
          ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      );

}

class Widgets {
  static TombolNavigasiWaktu tombolNavigasiWaktu = const TombolNavigasiWaktu();
  static TotalPengeluaran totalPengeluaran = const TotalPengeluaran();
  static TotalPemasukan totalPemasukan = const TotalPemasukan();
  static TombolNavigasiTransaksi tombolNavigasiTransaksi = const TombolNavigasiTransaksi();
}

class HalamanBeranda extends StatefulWidget {
  const HalamanBeranda({super.key});

  @override
  State<HalamanBeranda> createState() => _HalamanBerandaState();
}

class _HalamanBerandaState extends State<HalamanBeranda> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ObjectProperty.appBar,
      backgroundColor: ObjectProperty.warna_background_scaffold,
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.5),
              child: Widgets.tombolNavigasiWaktu,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.5),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Widgets.totalPengeluaran,
                  ),
                  Widgets.totalPemasukan
                ],
              )
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.5),
              child: Widgets.tombolNavigasiTransaksi ,
            ),
          ],
        ),
      ),
    );
  }
}
