import 'package:flutter/material.dart';
import 'package:keuanganku/ui/pages/main/util.dart';
import 'package:keuanganku/ui/warna_aplikasi.dart';

class Data {
  final List<String> inOrOutTab = [
    "Pemasukan",
    "Pengeluaran"
  ];
  final List<String> dateTab = [
    "1H", "1M", "1B", "6B", "1Y", "All"
  ];
  final List<String> dateTabInfo = [
    "Hari Ini", "Minggu Ini", "Bulan Ini",  "6 Bulan Terakhir", "1 Tahun Terakhir", "Keseluruhan"
  ];

  int currentInOrOutTabIndex = 0;
  int currentDateTabIndex = 0;

  double dateTabLineWidth = 45;
  double inOrOutLineWidth = 120;

  double inOrOutLinePositionChange() => currentInOrOutTabIndex == 0? 0 : 25 + (currentInOrOutTabIndex * inOrOutLineWidth);
  double dateTabLinePositionChange() => currentDateTabIndex * dateTabLineWidth;
  String totalPengeluaran(){
    //TODO: Implementasi switch case
    return "IDR 12,000";
  }
  String infoInOrOut() => inOrOutTab[currentInOrOutTabIndex];
}

class Widgets {
  Widget getInOrOutTab(Size size, BuildContext context, void Function(int) onChange){
    double lineWidth = 120;
    return 
    wrapWithPadding(
      context,
      SizedBox(
        width: size.width * 0.9,
        child: Column(
          children: [
            Stack(
              children: [
                SizedBox(
                  width: size.width*0.9,
                  height: 27.5,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount:InOrOut.data.inOrOutTab.length,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: (){
                          onChange(index);
                          InOrOut.data.currentInOrOutTabIndex = index;
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 25),
                          child: SizedBox(
                            width: lineWidth,
                            child: Text(
                              InOrOut.data.inOrOutTab[index],
                              style: TextStyle(
                                fontFamily: "QuickSand_Bold",
                                fontSize: 20,
                                color:InOrOut.data.currentInOrOutTabIndex == index? Warna.primaryColor : Warna.getColorByPercentage(percentage: 50 )
                              ),
                            ),
                          ),
                        )
                      );
                    }
                  ),
                ),
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 250),
                  bottom: 0,
                  left:InOrOut.data.inOrOutLinePositionChange(),
                  curve: Curves.easeInOutQuint,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    width: lineWidth,
                    height: 2,
                    curve: Curves.ease,
                    decoration: BoxDecoration(
                      color: Warna.secondaryColorOrange,
                      borderRadius: BorderRadius.circular(15)
                    ),
                  ),
                )
              ]
            ),
          ],
        ),
      ),
    );
  }

  Widget getDateTab(Size size, BuildContext context, void Function(int) onChange){
    double lineWidth = 45;
    return 
    wrapWithPadding(
      context,
      SizedBox(
        width: size.width * 0.9,
        child: Column(
          children: [
            Stack(
              children: [
                SizedBox(
                  width: size.width*0.9,
                  height: 27.5,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount:InOrOut.data.dateTab.length,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: (){
                          onChange(index);
                          InOrOut.data.currentDateTabIndex = index;
                        },
                        child: Container(
                          alignment: Alignment.centerLeft,
                          width: lineWidth,
                          child: Text(
                          InOrOut.data.dateTab[index],
                            style: TextStyle(
                              fontFamily: "QuickSand_Medium",
                              fontSize: 14,
                              color:InOrOut.data.currentDateTabIndex == index? Warna.primaryColor : Warna.getColorByPercentage(percentage: 50 )
                            ),
                          ),
                        )
                      );
                    }
                  ),
                ),
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 250),
                  bottom: 0,
                  left:InOrOut.data.dateTabLinePositionChange(),
                  curve: Curves.easeInOutQuint,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    width: lineWidth-15,
                    height: 2,
                    curve: Curves.ease,
                    decoration: BoxDecoration(
                      color: Warna.secondaryColorOrange,
                      borderRadius: BorderRadius.circular(15)
                    ),
                  ),
                )
              ]
            ),
          ],
        ),
      ),
    );
  }

  Widget getGrafik(BuildContext context, int inOrOut, int dateIndex){
    String dateInfo = InOrOut.data.dateTabInfo[dateIndex];
    double width = MediaQuery.sizeOf(context).width;

    return wrapWithPadding(
      context, 
      Container(
        width: width * 0.9,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(dateInfo,
              style: TextStyle(
                fontSize: 16,
                fontFamily: "QuickSand_Medium",
                color: Warna.getColorByPercentage(percentage: 75)
              ),
            ),
            Text(
              InOrOut.data.totalPengeluaran(),
              style: const TextStyle(
                fontSize: 18,
                fontFamily: "QuickSand_Bold",
                color: Warna.primaryColor
              ),
            ),
            [
              Container(
                color: Warna.secondaryColorOrange,
                height: 700,
              ),
              Container(
                color: Warna.primaryColor,
                height: 700,
              )
            ][InOrOut.data.currentInOrOutTabIndex]
          ],
        ),
      )
    );
  }
}

class InOrOut extends StatefulWidget {
  static Data data = Data();
  static Widgets widgets = Widgets();

  const InOrOut({super.key, required this.onChange});
  final void Function(int index) onChange;

  @override
  State<InOrOut> createState() => _InOrOutState();
}

class _InOrOutState extends State<InOrOut> {

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
      children: [
        InOrOut.widgets.getInOrOutTab(size, context, widget.onChange),
        InOrOut.widgets.getDateTab(size, context, widget.onChange),
        InOrOut.widgets.getGrafik(context, InOrOut.data.currentInOrOutTabIndex, InOrOut.data.currentDateTabIndex)
      ],
    );
  }
}
