import 'package:flutter/material.dart';
import 'package:keuanganku/ui/pages/main/pengeluaran/widgets/tombol_waktu/tombol_waktu.dart';
import 'package:keuanganku/ui/pages/main/pengeluaran/widgets/total_pengeluaran/total_pengeluaran.dart';

class HalamanPengeluaran extends StatefulWidget {
  const HalamanPengeluaran({super.key});

  @override
  State<HalamanPengeluaran> createState() => _HalamanPengeluaranState();
}

class _HalamanPengeluaranState extends State<HalamanPengeluaran> {

  Widget formatWidget({required Widget child}){
    return Padding(padding: const EdgeInsets.symmetric(vertical: 10), child: child,);
  }

  @override
  Widget build(BuildContext context) {
    double totalPengeluaran = 3000000;

    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: (){
 
        },
        child: const Icon(Icons.add, color: Colors.white,),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            vertical: MediaQuery.sizeOf(context).height * 0.02,
            horizontal: MediaQuery.sizeOf(context).width * 0.02,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            formatWidget(child: Center(child: TombolWaktu(onChange: (index){}))),
            formatWidget(child: Center(child: TotalPengeluaran(title: "Bulan Ini", totalPengeluaran: totalPengeluaran)))
          ],
        ),),
    );
  }
}
