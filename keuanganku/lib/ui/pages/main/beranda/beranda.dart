
import 'package:flutter/material.dart';
import 'package:keuanganku/ui/pages/main/beranda/widgets/in_vs_out/invout.dart';
import 'package:keuanganku/ui/pages/main/beranda/widgets/jumlah_pemasukan/card_total_pemasukan.dart';
import 'package:keuanganku/ui/pages/main/beranda/widgets/jumlah_pengeluaran/card_pengeluaran.dart';
import 'package:keuanganku/ui/pages/main/beranda/widgets/tombol_navigasi_waktu/tombol_navigasi_waktu.dart';

class Widgets {
  late final CardTotalPemasukan cardTotalPemasukan;
  late final CardTotalPengeluaran cardTotalPengeluaran;
  late final TombolNavigasiWaktu tombolNavigasiWaktu;
  late final CardInVsOut cardInVsOut = CardInVsOut();

  Widgets(){
    cardTotalPemasukan = CardTotalPemasukan();
    cardTotalPengeluaran = CardTotalPengeluaran();
    tombolNavigasiWaktu = TombolNavigasiWaktu(onChange: _eventTombolNavigasiWaktuChange);
  }
  getWidgetGroupCardPemasukanPengeluaran(BuildContext context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        cardTotalPemasukan.getWidget(parameters: context),
        cardTotalPengeluaran.getWidget(context)
      ],
    );
  }
  getWidgetTombolNavigasiWaktu() => tombolNavigasiWaktu;
  getWidgetInVersusOut(BuildContext context) => cardInVsOut.getWidget(parameters: context);

  _eventTombolNavigasiWaktuChange(int value){

  }
}

class PageBeranda extends StatefulWidget {
  PageBeranda({super.key});
  final Widgets kWidgets = Widgets();
  
  @override
  State<PageBeranda> createState() => PageBerandaState();
}

class PageBerandaState extends State<PageBeranda> {

  Widget formatWidget({required Widget child}){
    return Padding(padding: const EdgeInsets.symmetric(vertical: 5), child: child,);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            left: MediaQuery.sizeOf(context).width * 0.02,
            right: MediaQuery.sizeOf(context).width * 0.02,
          ),
          child: Column( 
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10,),
              formatWidget(child: widget.kWidgets.getWidgetTombolNavigasiWaktu()),
              formatWidget(child: widget.kWidgets.getWidgetGroupCardPemasukanPengeluaran(context)),
              formatWidget(child: widget.kWidgets.getWidgetInVersusOut(context))
            ],        
          ),
        ),
      ),
    );
  }
}
