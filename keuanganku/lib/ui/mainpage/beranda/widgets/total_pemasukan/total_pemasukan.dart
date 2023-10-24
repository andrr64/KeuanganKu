import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DataPool {
  static double totalPemasukan = 0;
  // ignore: non_constant_identifier_names
  static double totalPemasukan_sebelumnya = 1650000.0;

  static bool redFlag = totalPemasukan < totalPemasukan_sebelumnya;
}

class ObjectProperty {
  // ignore: non_constant_identifier_names
  static Color warna_background_container = Colors.white;
  static BoxShadow boxShadow = BoxShadow(
      color: Colors.grey.withOpacity(0.25),
      spreadRadius: 0,
      blurRadius: 5,
      offset: const Offset(0, 0)
  );
}

class Widgets {
  static const Text teksPemasukan = Text(
    "Pemasukan",
    style: TextStyle(
      fontFamily: "Inter",
      fontSize: 12,
      color: Color(0xff414A55),
    ),
  );

  static totalPemasukan() {
    String getRupiah(){
      var f = NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0);
      return f.format(DataPool.totalPemasukan);
    }

    return Text(
      getRupiah(),
      style: const TextStyle(
        fontFamily: "OpenSans_SemiBold",
        fontSize: 20,
        color: Color(0xff414A55),
      ),
    );
  }

  static Text persentasePemasukan() {
    double getPercentage(){
      if (DataPool.totalPemasukan == 0 || DataPool.totalPemasukan_sebelumnya == 0){
        return 100;
      }

      double selisih = DataPool.totalPemasukan - DataPool.totalPemasukan_sebelumnya;
      return (selisih / DataPool.totalPemasukan_sebelumnya) * 100;
    }

    return Text(
      "${DataPool.redFlag? "-" : "+"}${getPercentage()}% dari hari lalu",
      style: TextStyle(
        fontFamily: "Inter",
        fontSize: 12,
        color: Color(DataPool.redFlag? 0xffEC5454 : 0xff37A634),
      ),
    );
  }
}

class TotalPemasukan extends StatefulWidget {
  const TotalPemasukan({super.key});

  @override
  State<TotalPemasukan> createState() => _TotalPemasukanState();
}

class _TotalPemasukanState extends State<TotalPemasukan> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      decoration: BoxDecoration(
        color: ObjectProperty.warna_background_container,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          ObjectProperty.boxShadow
        ]
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Widgets.teksPemasukan,
            Widgets.totalPemasukan(),
            Widgets.persentasePemasukan()
          ],
        ),),
    );
  }
}