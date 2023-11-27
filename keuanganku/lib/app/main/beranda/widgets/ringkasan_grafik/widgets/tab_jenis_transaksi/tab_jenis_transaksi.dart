import 'package:flutter/material.dart';
import 'package:keuanganku/enum/data_transaksi.dart';
import 'package:keuanganku/app/app_colors.dart';
import 'package:keuanganku/app/main/beranda/beranda.dart';
import 'package:keuanganku/app/main/beranda/widgets/ringkasan_grafik/ringkasan_grafik.dart';
import 'package:keuanganku/app/main/wrap.dart';

class Properties {
  final List<String> listTabJenisTransaksi = [
    "Pemasukan",
    "Pengeluaran"
  ];
  double  posisiGarisTabJenisTransaksi(indeksTab, panjangGarisTab) => panjangGarisTab * indeksTab;
}

class TabJenisTransaksi extends StatelessWidget {
  TabJenisTransaksi({super.key, required this.indeksTab});
 
  final int indeksTab;
  final Properties properties = Properties();


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    var panjangGarisTab = size.width * 0.8 / 2;

    // EVENTS
    void ketikaTabBerubah(int index){
      RingkasanGrafik.data.indeksTabJenisTransaksi = index;
      switch (index) {
        case 0:
          RingkasanGrafik.data.jenisTransaksi = JenisTransaksi.PENGELUARAN;
          break;
        case 1:
          RingkasanGrafik.data.jenisTransaksi = JenisTransaksi.PEMASUKAN;
          break;
      }
      HalamanBeranda.state.update!();
    }  

    // WIDGETS
    widgetTeks(){
      return 
      SizedBox(
        width: size.width*0.9,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount:properties.listTabJenisTransaksi.length,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: (){
                ketikaTabBerubah(index);
              },
              child: SizedBox(
                width:panjangGarisTab,
                child: Text(
                  properties.listTabJenisTransaksi[index],
                  style: TextStyle(
                    fontFamily: "QuickSand_Bold",
                    fontSize: 20,
                    color:RingkasanGrafik.data.indeksTabJenisTransaksi == index? ApplicationColors.primary : ApplicationColors.primaryColorWidthPercentage(percentage: 50 )
                  ),
                ),
              )
            );
          }
        ),
      );
    }
    widgetGaris(){
      return            
      AnimatedPositioned(
        duration: const Duration(milliseconds: 250),
        bottom: 0,
        left:properties.posisiGarisTabJenisTransaksi(panjangGarisTab, indeksTab),
        curve: Curves.easeInOutQuint,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          width: panjangGarisTab - 10,
          height: 2,
          curve: Curves.ease,
          decoration: BoxDecoration(
            color: ApplicationColors.secondaryOrange,
            borderRadius: BorderRadius.circular(15)
          ),
        ),
      );
    }

    return 
    wrapWithPadding(
      context,
      SizedBox(
        width: size.width * 0.9,
        child: Column(
          children: [
            Stack(
              children: [
                widgetTeks(),
                widgetGaris()
              ]
            ),
          ],
        ),
      ),
    );
  }
}