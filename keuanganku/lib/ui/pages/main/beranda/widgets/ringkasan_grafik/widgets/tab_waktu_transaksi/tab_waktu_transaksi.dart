
import 'package:flutter/material.dart';
import 'package:keuanganku/enum/data_transaksi.dart';
import 'package:keuanganku/ui/application_colors.dart';
import 'package:keuanganku/ui/pages/main/beranda/beranda.dart';
import 'package:keuanganku/ui/pages/main/beranda/widgets/ringkasan_grafik/ringkasan_grafik.dart';
import 'package:keuanganku/ui/pages/main/util.dart';

class Properties {
  final List<String> listTabWaktuTransaksi = [
    "1M", "1Y"
  ];
  double panjangGarisTabWaktuTransaksi = 45;
  double posisiGarisTabWaktuTransaksi(indeksTabWaktuTransaksi) => indeksTabWaktuTransaksi * panjangGarisTabWaktuTransaksi;
}

class TabWaktuTransaksi extends StatelessWidget {
  TabWaktuTransaksi({super.key, required this.indeksWaktuTransaksi});
  
  final int indeksWaktuTransaksi;
  final Properties properties = Properties();

  @override
  Widget build(BuildContext context) {
    // EVENTS
    void waktuTransaksiBerubah(int index){
      RingkasanGrafik.data.indeksTabWaktuTransaksi = index;
      switch (index) {
        case 0:
          RingkasanGrafik.data.waktuTransaksi = WaktuTransaksi.MINGGUAN;
          break;
        case 1:
          RingkasanGrafik.data.waktuTransaksi = WaktuTransaksi.TAHUNAN;
          break;
        default:
      }
      HalamanBeranda.state.update!();
    }
    var size = MediaQuery.sizeOf(context);

    // WIDGETS
    widgetTeksTab(){
      return  
      SizedBox(
        width: size.width*0.9,
        height: 27.5,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount:properties.listTabWaktuTransaksi.length,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: (){
                waktuTransaksiBerubah(index);
              },
              child: Container(
                alignment: Alignment.centerLeft,
                width: properties.panjangGarisTabWaktuTransaksi,
                child: Text(
                properties.listTabWaktuTransaksi[index],
                  style: TextStyle(
                    fontFamily: "QuickSand_Bold",
                    fontSize: 14,
                    color:RingkasanGrafik.data.indeksTabWaktuTransaksi == index? ApplicationColors.primary : ApplicationColors.primaryColorWidthPercentage(percentage: 50 )
                  ),
                ),
              )
            );
          }
        ),
      );          
    }
    widgetGarisTab(){
      return 
      AnimatedPositioned(
        duration: const Duration(milliseconds: 250),
        bottom: 0,
        left:properties.posisiGarisTabWaktuTransaksi(indeksWaktuTransaksi),
        curve: Curves.easeInOutQuint,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          width: properties.panjangGarisTabWaktuTransaksi-15,
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
                widgetTeksTab(),
                widgetGarisTab()
              ]
            ),
          ],
        ),
      ),
    );
  
  }
}