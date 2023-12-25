import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:keuanganku/app/app_colors.dart';
import 'package:keuanganku/app/widgets/k_card/k_card.dart';
import 'package:keuanganku/app/widgets/k_dropdown_menu/k_drodpown_menu.dart';
import 'package:keuanganku/app/widgets/k_future_builder/k_future.dart';
import 'package:keuanganku/database/helper/expense.dart';
import 'package:keuanganku/database/helper/income.dart';
import 'package:keuanganku/database/helper/wallet.dart';
import 'package:keuanganku/database/model/expense.dart';
import 'package:keuanganku/enum/data_transaksi.dart';
import 'package:keuanganku/k_typedef.dart';
import 'package:keuanganku/main.dart';
import 'package:keuanganku/util/font_style.dart';
import 'package:keuanganku/util/get_currency.dart';
import 'package:keuanganku/util/vector_operation.dart';

class Data {
  WaktuTransaksi waktuTransaksi = WaktuTransaksi.Bulanan;
  String getInfoWaktu(waktuTransaksiX){
    switch(waktuTransaksiX){
      case WaktuTransaksi.Bulanan:
        return "Bulan Ini";
      case WaktuTransaksi.Mingguan:
        return "Minggu Ini";
      case WaktuTransaksi.Tahunan:
        return "Tahun Ini";
      default:
        return "";
    }
  }
}

class KRingkasan extends StatefulWidget {
  const KRingkasan({super.key, required this.callback, required this.widgetData});
  final VoidCallback callback;
  final Data widgetData;
  
  @override
  State<KRingkasan> createState() => _KRingkasanState();
}

class _KRingkasanState extends State<KRingkasan> {
  KWidget     totalPemasukan    (BuildContext context){
    Future<double> getData() async {
      return sumList((await SQLHelperIncome().readByWaktuAndSortir(widget.widgetData.waktuTransaksi, SortirTransaksi.Default, db: db.database)).map((e) => e.nilai).toList());
    }
    Widget build(double value){
      double panjangContainerUang = MediaQuery.sizeOf(context).width * 0.4;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Pemasukan", style: kFontStyle(fontSize: 16, family: "QuickSand_Medium"),),
              Container(
                  alignment: Alignment.centerRight,
                  width: panjangContainerUang,
                  child: Text(
                    formatCurrency(value),
                    style: kFontStyle(fontSize: 16),
                    overflow: TextOverflow.ellipsis,
                  )
              )
            ],
          )
        ],
      );
    }
    return KFutureBuilder.build(
        future: getData(),
        whenWaiting: build(0),
        whenError: build(0),
        whenSuccess: (value) => build(value)
    );
  }
  KWidget     totalPengeluaran  (BuildContext context){
    Future getData() async {
      List<SQLModelExpense> seluruhPengeluaranBerdasarkanWaktu = await SQLHelperExpense().readByWaktu(widget.widgetData.waktuTransaksi, db: db.database);
      double pengeluaranKeseluruhan = sumList(seluruhPengeluaranBerdasarkanWaktu.map((e) => e.nilai).toList());
      return pengeluaranKeseluruhan;
    }
    Widget build(value){
      double panjangContainerUang = MediaQuery.sizeOf(context).width * 0.4;
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Pengeluaran", style: kFontStyle(fontSize: 16, family: "QuickSand_Medium"),),
              Container(
                alignment: Alignment.centerRight,
                width: panjangContainerUang,
                child: Text(
                  formatCurrency(value),
                  style: kFontStyle(fontSize: 16),
                  overflow: TextOverflow.ellipsis,
                )
              )
            ],
          )
        ],
      );
    }
    return KFutureBuilder.build(
        future: getData(), 
        whenWaiting: build(0.0),
        whenError: build(0.0),
        whenSuccess: (value) => build(value as double)
    );
  }
  KWidget     dropdownWaktu     (BuildContext context){
    List<DropdownMenuItem<WaktuTransaksi>> items(){
      return WaktuTransaksi.values.map((e) =>
          DropdownMenuItem(
            child: Text(
              widget.widgetData.getInfoWaktu(e),
              style: kFontStyle(fontSize: 15, family: "QuickSand_Medium"),
            ),
            value: e,)
      ).toList();
    }

    return SizedBox(
      width: MediaQuery.sizeOf(context).width * 0.3,
      child: KDropdownMenu<WaktuTransaksi>(
          items: items(),
          onChanged: (value){
            widget.widgetData.waktuTransaksi = value!;
            setState(() {

            });
          },
          value: widget.widgetData.waktuTransaksi,
          labelText: "Waktu"
      ).getWidget(),
    );
  }
  KWidget     delta             (BuildContext context){
    Future<Map<String, dynamic>> getData() async {
      List<SQLModelExpense> seluruhPengeluaranBerdasarkanWaktu = await SQLHelperExpense().readByWaktu(widget.widgetData.waktuTransaksi, db: db.database);
      /// Pengeluaran dalam kurun waktu tertentu
      double pengeluaranKeseluruhan = sumList(seluruhPengeluaranBerdasarkanWaktu.map((e) => e.nilai).toList());

      /// Dana dalam kurun waktu tertentu
      double danaKeseluruhan = await SQLHelperWallet().readSeluruhTotalUangTersedia();
      double delta = danaKeseluruhan - pengeluaranKeseluruhan;
      /// Selisih dalam kurun waktu tertentu
      return {
        'delta': delta,
        'color': delta < 0? Colors.red : delta == 0? ApplicationColors.primary : Colors.green
      };
    }
    Widget build(value){
      double panjangContainerUang = MediaQuery.sizeOf(context).width * 0.4;
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Delta", style: kFontStyle(fontSize: 16, family: "QuickSand_Medium"),),
              Container(
                  alignment: Alignment.centerRight,
                  width: panjangContainerUang,
                  child: Text(
                    formatCurrency(value['delta']),
                    style: kFontStyle(fontSize: 16, color: value['color']),
                    overflow: TextOverflow.ellipsis,
                  )
              )
            ],
          )
        ],
      );
    }
    return KFutureBuilder.build<Map<String, dynamic>>(
        future: getData(),
        whenWaiting: build({
          'delta' : 0.0,
          'color': ApplicationColors.primary
        }),
        whenError: build({
          'delta' : 0.0,
          'color': ApplicationColors.primary
        }),
        whenSuccess: (value) => build(value)
    );
  }
  final icon = SvgPicture.asset("assets/icons/ringkasan.svg");

  @override
  Widget build(BuildContext context) {
    return KCard(
        title: "Ringkasan",
        icon: icon,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            totalPemasukan(context),
            totalPengeluaran(context),
            delta(context)
          ],
        ),
        button: dropdownWaktu(context),
    );
  }
}
