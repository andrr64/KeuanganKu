import 'package:flutter/material.dart';
import 'package:keuanganku/ui/pages/main/beranda/widgets/daftar_transaksi/daftar_transaksi.dart';
import 'package:keuanganku/ui/pages/main/beranda/widgets/in_or_out/in_or_out.dart';
import 'package:keuanganku/ui/pages/main/beranda/widgets/total_dana/total_dana.dart';
import 'package:keuanganku/ui/warna_aplikasi.dart';

class Properties {
  final Color primaryColor = Warna.primaryColor;
}

class Data {
  String totalDana = "IDR 12,400,000";
  void updateTotalDana(){
    //TODO: Implementation
  }

  int inOrOut = 0;
  void updateInOrOut(int index){
    inOrOut = index;
  }
}

class HalamanBeranda extends StatefulWidget {
  /// Class Halaman ini memuat seluruh ringkasan pemasukan dan pengeluaran serta fitur analisa
  const HalamanBeranda({super.key});
  static Properties properties = Properties();
  static Data data = Data();

  @override
  State<HalamanBeranda> createState() => HalamanBerandaState();
}

class HalamanBerandaState extends State<HalamanBeranda> {
  final double vPadding = 7.6;
  
  @override
  Widget build(BuildContext context) {

    void updateStateInOrOut(int index){
      setState(() {
        HalamanBeranda.data.inOrOut = index;
      });
    }
    
    void updateAllState(){
      setState(() {
        
      });
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: vPadding,),
              TotalDana(onChange:(p0){updateAllState();} , X: HalamanBeranda.data.totalDana),
              InOrOut(onChange: updateStateInOrOut,),
              DaftarTransaksi(updateRootState: updateAllState)
            ],
          ),
        ),
      ),
    );
  }
}
