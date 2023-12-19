import 'package:flutter/material.dart';
import 'package:keuanganku/app/routes/main/pengeluaran/pages/form_expense_limiter/form_expense_limiter.dart';
import 'package:keuanganku/database/helper/expense.dart';
import 'package:keuanganku/database/helper/expense_category.dart';
import 'package:keuanganku/database/model/expense.dart';
import 'package:keuanganku/database/model/expense_limiter.dart';
import 'package:keuanganku/enum/data_transaksi.dart';
import 'package:keuanganku/main.dart';
import 'package:keuanganku/util/dummy.dart';
import 'package:keuanganku/util/font_style.dart';
import 'package:keuanganku/util/generate_color.dart';
import 'package:keuanganku/util/get_currency.dart';
import 'package:keuanganku/util/vector_operation.dart';

class ExpenseLimiterItem extends StatefulWidget {
  const ExpenseLimiterItem({
    super.key, 
    required this.limiter,
    required  this.callback  
  });
  final SQLModelExpenseLimiter limiter;
  final VoidCallback callback;

  @override
  State<ExpenseLimiterItem> createState() => _ExpenseLimiterItemState();
}

class _ExpenseLimiterItemState extends State<ExpenseLimiterItem> {
  Future getData() async{
    List<SQLModelExpense> listPengeluaranKategoriIni = 
      await SQLHelperExpense().readWeeklyByCategoryId (
        widget.limiter.kategori.id, 
        DateTime.now(), db: db.database, sortirBy: SortirTransaksi.Default
      );
    double totalPengeluaran = sumList(listPengeluaranKategoriIni.map((e) => e.nilai).toList());
    double perbandingan = ((totalPengeluaran == 0) ? 0:  totalPengeluaran / widget.limiter.nilai).toDouble();
    return {
      'listPengeluaran': listPengeluaranKategoriIni,
      'totalPengeluaran': totalPengeluaran,
      'perbandingan': perbandingan,
    };
  }

double getMapColorValue(double perbandingan) {
  if (perbandingan == 0){
    return 5;
  } else if (perbandingan >= 1){
    return 1;
  } else {
    double x = perbandingan * 5;
    return 5 - x;
  }
}

  Widget  getItem(){
    return FutureBuilder(
      future: getData(), 
      builder: (_, snapshot){
        if (snapshot.connectionState == ConnectionState.waiting){
          return makeCenterWithRow(child: const CircularProgressIndicator());
        } else if (snapshot.hasError){
          return makeCenterWithRow(child: const Text("Sadly something wrong"));
        } else {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.limiter.kategori.judul, // Ganti dengan judul limiter yang sesuai
                        style: kFontStyle(fontSize: 16),
                      ),
                      Text("${toThousandK(snapshot.data!['totalPengeluaran'])}/${toThousandK(widget.limiter.nilai)}", style: kFontStyle(fontSize: 14, family: "QuickSand_Medium"),),
                      Text(widget.limiter.waktu, style: kFontStyle(fontSize: 13, family: "QuickSand_Medium"),),
                    ],
                  ),
                  Text(
                      percentageFormat(snapshot.data['perbandingan'] < 1.0 ? snapshot.data['perbandingan']  * 100 : 100),
                    style: kFontStyle(fontSize: 18),
                  )
                ],
              ),
              const SizedBox(height: 8),
              LinearProgressIndicator(
                value: snapshot.data!['perbandingan'],
                backgroundColor: Colors.black26,
                valueColor: AlwaysStoppedAnimation<Color>(
                  mapValueToColor(getMapColorValue(snapshot.data!['perbandingan']))
                ),
              ),
            ],
          );
        }
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Future getListKategori() async {
          return await SQLHelperIncomeCategory().readAll(db: db.database);
        }
        getListKategori().then(
          (listKategori){
            Navigator.push(context, MaterialPageRoute(builder: (_) => 
            FormExpenseLimiter(
              callback: widget.callback,
              listCategory: listKategori,)));
          });
      },
      child: getItem()
    );
  }
}