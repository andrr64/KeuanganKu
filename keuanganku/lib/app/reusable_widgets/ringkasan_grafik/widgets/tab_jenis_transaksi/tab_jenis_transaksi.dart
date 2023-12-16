// import 'package:flutter/material.dart';
// import 'package:keuanganku/enum/data_transaksi.dart';
// import 'package:keuanganku/app/app_colors.dart';
// import 'package:keuanganku/app/reusable_widgets/ringkasan_grafik/ringkasan_grafik.dart' as ringkasan_grafik;

// class Properties {
//   final List<String> listTabJenisTransaksi = [
//     "Pemasukan",
//     "Pengeluaran"
//   ];
//   double  posisiGarisTabJenisTransaksi(indeksTab, panjangGarisTab) => panjangGarisTab * indeksTab;
// }

// class TabJenisTransaksi extends StatelessWidget {
//   TabJenisTransaksi({super.key, required this.indeksTab, required this.data, required this.onUpdate});
//   final ringkasan_grafik.RuCRingkasanGrafikData data;
//   final int indeksTab;
//   final Properties properties = Properties();
//   final VoidCallback onUpdate;

//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.sizeOf(context);
//     var panjangGarisTab = size.width * 0.8 / 2;

//     // EVENTS
//     void ketikaTabBerubah(int index){
//       if (data.indeksTabJenisTransaksi == index) return;
//       data.indeksTabJenisTransaksi = index;
//       switch (index) {
//         case 0:
//           data.jenisTransaksi = JenisTransaksi.Pemasukan;
//           break;
//         case 1:
//           data.jenisTransaksi = JenisTransaksi.Pengeluaran;
//           break;
//       }
//       onUpdate();
//     }  

//     // WIDGETS
//     widgetTeks(){
//       return 
//       SizedBox(
//         width: size.width*0.9,
//         height: 27.5,
//         child: ListView.builder(
//           scrollDirection: Axis.horizontal,
//           itemCount:properties.listTabJenisTransaksi.length,
//           physics: const BouncingScrollPhysics(),
//           itemBuilder: (context, index) {
//             return GestureDetector(
//               onTap: (){
//                 ketikaTabBerubah(index);
//               },
//               child: SizedBox(
//                 width:panjangGarisTab,
//                 child: Text(
//                   properties.listTabJenisTransaksi[index],
//                   style: TextStyle(
//                     fontFamily: "QuickSand_Bold",
//                     fontSize: 20,
//                     color:data.indeksTabJenisTransaksi == index? ApplicationColors.primary : ApplicationColors.primaryColorWidthPercentage(percentage: 50 )
//                   ),
//                 ),
//               )
//             );
//           }
//         ),
//       );
//     }
//     widgetGaris(){
//       return            
//       AnimatedPositioned(
//         duration: const Duration(milliseconds: 250),
//         bottom: 0,
//         left:properties.posisiGarisTabJenisTransaksi(panjangGarisTab, indeksTab),
//         curve: Curves.easeInOutQuint,
//         child: AnimatedContainer(
//           duration: const Duration(milliseconds: 500),
//           width: panjangGarisTab - 10,
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
//               widgetTeks(),
//               widgetGaris()
//             ]
//           ),
//         ],
//       ),
//     );
//   }
// }