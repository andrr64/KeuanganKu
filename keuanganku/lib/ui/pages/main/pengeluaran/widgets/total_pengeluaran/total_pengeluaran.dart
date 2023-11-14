import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ObjectProperty {
  Color fontColor = const Color(0xff414A55);
}

class TotalPengeluaran extends StatelessWidget {
  TotalPengeluaran({
    super.key,
    required this.title, 
    required this.totalPengeluaran
  });

  final ObjectProperty property = ObjectProperty();
  final String title;
  final double totalPengeluaran;
  
  String getFormatted(double dbl){
    NumberFormat nm =  NumberFormat(("#,###"));
    return nm.format(dbl);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(
          fontSize: 16, 
          fontFamily: "QuickSand_Medium",
          color: property.fontColor),
        ),
        
        Text("IDR ${getFormatted(totalPengeluaran)}", style: TextStyle(
          fontSize: 28, 
          fontFamily: "OpenSans_Bold",
          color: property.fontColor,),
        ),
      ],
    );
  }
}
