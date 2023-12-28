import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:keuanganku/app/app_colors.dart';
import 'package:keuanganku/app/widgets/k_card/k_card.dart';
import 'package:keuanganku/app/widgets/k_dropdown_menu/k_drodpown_menu.dart';
import 'package:keuanganku/app/widgets/k_future_builder/k_future.dart';
import 'package:keuanganku/database/helper/expense.dart';
import 'package:keuanganku/database/helper/income.dart';
import 'package:keuanganku/database/model/expense.dart';
import 'package:keuanganku/database/model/income.dart';
import 'package:keuanganku/enum/data_transaksi.dart';
import 'package:keuanganku/k_typedef.dart';
import 'package:keuanganku/main.dart';
import 'package:keuanganku/util/dummy.dart';
import 'package:keuanganku/util/font_style.dart';
import 'package:keuanganku/util/get_currency.dart';
import 'package:keuanganku/util/vector_operation.dart';

class Data {
  WaktuTransaksi waktuTransaksi = WaktuTransaksi.Bulanan;
  List<SQLModelExpense> _listPengeluaran = [];
  List<SQLModelIncome> _listPemasukan = [];
  double _totalPengeluaran = 0;
  double _totalPemasukan = 0;

  Future updateData() async{
    _listPemasukan = await SQLHelperIncome().readByWaktuAndSortir(waktuTransaksi, SortirTransaksi.Default, db: db.database);
    _listPengeluaran = await SQLHelperExpense().readByWaktuAndSortir(waktuTransaksi,SortirTransaksi.Default, db: db.database);
    _totalPemasukan = sumList(_listPemasukan.map((e) => e.nilai).toList());
    _totalPengeluaran = sumList(_listPengeluaran.map((e) => e.nilai).toList());
  }

  List<SQLModelIncome> get listPemasukan => _listPemasukan;
  List<SQLModelExpense> get listPengeluaran => _listPengeluaran;
  double get totalPemasukan => _totalPemasukan;
  double get totalPengeluaran => _totalPengeluaran; 

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
  KWidget     totalPemasukan    (BuildContext context, double totalPemasukan){
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
                  formatCurrency(totalPemasukan),
                  style: kFontStyle(fontSize: 16),
                  overflow: TextOverflow.ellipsis,
                )
            )
          ],
        )
      ],
    );
  }
  KWidget     totalPengeluaran  (BuildContext context, double totalPengeluaran){
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
                formatCurrency(totalPengeluaran),
                style: kFontStyle(fontSize: 16),
                overflow: TextOverflow.ellipsis,
              )
            )
          ],
        )
      ],
    );
  }
  KWidget     dropdownWaktu     (BuildContext context){
    List<DropdownMenuItem<WaktuTransaksi>> items(){
      return WaktuTransaksi.values.map((e) =>
          DropdownMenuItem(
            value: e,
            child: Text(
              widget.widgetData.getInfoWaktu(e),
              style: kFontStyle(fontSize: 15, family: "QuickSand_Medium"),
            ),)
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
  KWidget     delta             (BuildContext context, double delta){
    final color = delta < 0? Colors.red : delta == 0? KColors.fontPrimaryBlack : Colors.green;
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
                  formatCurrency(delta),
                  style: kFontStyle(fontSize: 16, color: color),
                  overflow: TextOverflow.ellipsis,
                )
            )
          ],
        )
      ],
    );
  }
  
  final icon = SvgPicture.asset("assets/icons/ringkasan.svg");
  
  Widget buildBody(BuildContext context, {required double totalPemasukanX, required double totalPengeluaranX}){
    return KCard(
        title: "Ringkasan",
        icon: icon,
        button: dropdownWaktu(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            totalPemasukan(context, totalPemasukanX),
            totalPengeluaran(context, totalPengeluaranX),
            delta(context, totalPemasukanX-totalPengeluaranX)
          ],
        ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return KFutureBuilder.build(
      future: widget.widgetData.updateData(), 
      whenError: makeCenterWithRow(child: const CircularProgressIndicator(color: Colors.white,)), 
      whenWaiting: buildBody(
        context, 
        totalPemasukanX: 0, 
        totalPengeluaranX: 0
      ),
      whenSuccess: (val) => buildBody(
        context, 
        totalPemasukanX: widget.widgetData.totalPemasukan, 
        totalPengeluaranX: widget.widgetData.totalPengeluaran
      )
    );
  }
}
