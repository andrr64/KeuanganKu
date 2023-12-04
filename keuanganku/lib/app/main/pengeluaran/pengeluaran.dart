import 'package:flutter/material.dart';
import 'package:keuanganku/app/app_colors.dart';
import 'package:keuanganku/app/main/pengeluaran/widgets/form_data_pengeluaran/form_data_pengeluaran.dart';
import 'package:keuanganku/app/reusable_components/ringkasan_grafik/ringkasan_grafik.dart';
import 'package:keuanganku/app/state_bridge.dart';
import 'package:keuanganku/enum/data_transaksi.dart';
import 'package:keuanganku/util/dummy.dart';

class HalamanPengeluaran extends StatefulWidget {
  const HalamanPengeluaran({super.key});
  static StateBridge state = StateBridge();
  static Data data = Data();

  @override
  State<HalamanPengeluaran> createState() => _HalamanPengeluaranState();
}

class Data {
  RuCRingkasanGrafikData ringkasanGrafik = RuCRingkasanGrafikData();
  Data(){
    ringkasanGrafik.waktuTransaksi = WaktuTransaksi.MingguIni;
  }
}

class _HalamanPengeluaranState extends State<HalamanPengeluaran> {

  @override
  void initState() {
    super.initState();
    HalamanPengeluaran.state.init(() { 
      setState(() {
        
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // Events
    void tambahDataBaru(){
      showModalBottomSheet(
        context: context, 
        isScrollControlled: true,
        builder: (context) => FormDataPengeluaran(
          onSaveCallback: (){
            setState(() {});
          },
        ),
      );
    }

    Widget widgetRingkasanGrafik(){
      return 
      RuCRingkasanGrafik(
            context, 
            data: HalamanPengeluaran.data.ringkasanGrafik, 
            isSingleTransaction: true, 
            onUpdate: HalamanPengeluaran.state.update!)
              .getWidget();
    }

    Widget buildBody(){
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Ringkasan Pengeluaran",
          style: TextStyle(
              fontFamily: "QuickSand_Medium",
              fontSize: 18,
              color: ApplicationColors.primary
            ),
          ),
          dummyPadding(height: 5),
          widgetRingkasanGrafik(),
        ],
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        backgroundColor: ApplicationColors.primary,
        onPressed: tambahDataBaru,
        child: const Icon(Icons.add, color: Colors.white,),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildBody()
        ],
      )
    );
  }
}