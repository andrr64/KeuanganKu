import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DataPool {
  static double totalPengeluaran = 230000.0;
  // ignore: non_constant_identifier_names
  static double totalPengeluaran_sebelumnya = 1000000;

  static bool redFlag = totalPengeluaran > totalPengeluaran_sebelumnya;
}

class ObjectProperty {
  // ignore: non_constant_identifier_names
  static Color warna_background_container = Colors.white;

}

class Widgets {

  static const Text teksPengeluaran = Text(
    "Pengeluaran",
    style: TextStyle(
      fontFamily: "Inter",
      fontSize: 12,
      color: Color(0xff414A55),
    ),
  );

  static totalPengeluaran() {
    String getRupiah(){
      var f = NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0);
      return f.format(DataPool.totalPengeluaran);
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

    static Text persentasePengeluaran() {
    double getPercentage(){
      if (DataPool.totalPengeluaran == 0 || DataPool.totalPengeluaran_sebelumnya == 0){
        return 100;
      }
      double selisih = DataPool.totalPengeluaran - DataPool.totalPengeluaran_sebelumnya;
      return (selisih / DataPool.totalPengeluaran_sebelumnya) * 100;
    }

    return Text(
      "${DataPool.redFlag? "+" : ""}${getPercentage()}% dari hari lalu",
      style: TextStyle(
        fontFamily: "Inter",
        fontSize: 12,
        color: Color(DataPool.redFlag? 0xffEC5454 : 0xff37A634),
      ),
    );
  }
}

class TotalPengeluaran extends StatefulWidget {
  const TotalPengeluaran({super.key});

  @override
  State<TotalPengeluaran> createState() => _TotalPengeluaranState();
}

class _TotalPengeluaranState extends State<TotalPengeluaran> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      decoration: BoxDecoration(
        color: ObjectProperty.warna_background_container,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.25),
            spreadRadius: 0,
            blurRadius: 5,
            offset: const Offset(0, 0)
          )
        ]
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Widgets.teksPengeluaran,
            Widgets.totalPengeluaran(),
            Widgets.persentasePengeluaran()
          ],
        ),),
    );
  }
}