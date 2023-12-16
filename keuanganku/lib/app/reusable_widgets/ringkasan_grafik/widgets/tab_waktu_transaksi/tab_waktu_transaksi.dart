
// import 'package:flutter/material.dart';
// import 'package:keuanganku/enum/data_transaksi.dart';
// import 'package:keuanganku/app/app_colors.dart';
// import 'package:keuanganku/app/reusable_widgets/ringkasan_grafik/ringkasan_grafik.dart' as ringkasan_grafik;

// class Properties {
//   final List<String> listTabWaktuTransaksi = [
//     "1M", "1Y"
//   ];
//   double panjangGarisTabWaktuTransaksi = 45;
//   double posisiGarisTabWaktuTransaksi(indeksTabWaktuTransaksi) => indeksTabWaktuTransaksi * panjangGarisTabWaktuTransaksi;
// }

// class TabWaktuTransaksi{
//   int indeksWaktuTransaksi;
//   VoidCallback onUpdate;
//   TabWaktuTransaksi({required this.indeksWaktuTransaksi, required this.data, required this.onUpdate});
//   ringkasan_grafik.RuCRingkasanGrafikData data = ringkasan_grafik.RuCRingkasanGrafikData();
//   final Properties properties = Properties();

//   Widget getWidget(BuildContext context){
//     void waktuTransaksiBerubah(int index){
//       if (data.indeksTabWaktuTransaksi == index) return;
//       data.indeksTabWaktuTransaksi = index;
//       switch (index) {
//         case 0:
//           data.waktuTransaksi = WaktuTransaksi.Mingguan;
//           break;
//         case 1:
//           data.waktuTransaksi = WaktuTransaksi.Tahunan;
//           break;
//         default:
//       }
//       onUpdate();
//     }
//     var size = MediaQuery.sizeOf(context);

//     // WIDGETS
//     widgetTeksTab(){
//       return  
//       SizedBox(
//         width: size.width*0.9,
//         height: 27.5,
//         child: ListView.builder(
//           scrollDirection: Axis.horizontal,
//           itemCount:properties.listTabWaktuTransaksi.length,
//           physics: const BouncingScrollPhysics(),
//           itemBuilder: (context, index) {
//             return GestureDetector(
//               onTap: (){
//                 waktuTransaksiBerubah(index);
//               },
//               child: Container(
//                 alignment: Alignment.centerLeft,
//                 width: properties.panjangGarisTabWaktuTransaksi,
//                 child: Text(
//                 properties.listTabWaktuTransaksi[index],
//                   style: TextStyle(
//                     fontFamily: "QuickSand_Bold",
//                     fontSize: 14,
//                     color:data.indeksTabWaktuTransaksi == index? ApplicationColors.primary : ApplicationColors.primaryColorWidthPercentage(percentage: 50 )
//                   ),
//                 ),
//               )
//             );
//           }
//         ),
//       );          
//     }
//     widgetGarisTab(){
//       return 
//       AnimatedPositioned(
//         duration: const Duration(milliseconds: 250),
//         bottom: 0,
//         left:properties.posisiGarisTabWaktuTransaksi(indeksWaktuTransaksi),
//         curve: Curves.easeInOutQuint,
//         child: AnimatedContainer(
//           duration: const Duration(milliseconds: 500),
//           width: properties.panjangGarisTabWaktuTransaksi-15,
//           height: 2,
//           curve: Curves.ease,
//           decoration: BoxDecoration(
//             color: ApplicationColors.secondaryOrange,
//             borderRadius: BorderRadius.circular(15)
//           ),
//         ),
//       );
//     }

//     return 
//     SizedBox(
//       width: size.width * 0.9,
//       child: Column(
//         children: [
//           Stack(
//             children: [
//               widgetTeksTab(),
//               widgetGarisTab()
//             ]
//           ),
//         ],
//       ),
//     );
//   }
// }