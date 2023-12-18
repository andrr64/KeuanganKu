import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keuanganku/app/app_colors.dart';
import 'package:keuanganku/app/routes/main/pengeluaran/pages/form_expense_limiter/form_expense_limiter.dart';
import 'package:keuanganku/database/helper/expense_category.dart';
import 'package:keuanganku/main.dart';
import 'package:keuanganku/util/font_style.dart';

class ExpenseLimiterItem extends StatefulWidget {
  const ExpenseLimiterItem({super.key});
  

  @override
  State<ExpenseLimiterItem> createState() => _ExpenseLimiterItemState();
}

class _ExpenseLimiterItemState extends State<ExpenseLimiterItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Future getListKategori() async {
          return await SQLHelperIncomeCategory().readAll(db: db.database);
        }
        getListKategori().then(
          (listKategori){
            Navigator.push(context, MaterialPageRoute(builder: (_) => FormExpenseLimiter(listCategory: listKategori,)));
          });
      },
      child: Column(
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
                    'Judul Limiter', // Ganti dengan judul limiter yang sesuai
                    style: kFontStyle(fontSize: 16),
                  ),
                  Text("Mingguan", style: kFontStyle(fontSize: 13, family: "QuickSand_Medium"),),
                ],
              ),
              Row(
                children: [
                  Text("200K/100K", style: kFontStyle(fontSize: 14, family: "QuickSand_Medium"),),
                  const SizedBox(width: 10,),
                  const Icon(CupertinoIcons.arrow_right)
                ],
              )
            ],
          ),
          
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: 0.5,
            backgroundColor: Colors.black26,
            valueColor: const AlwaysStoppedAnimation<Color>(ApplicationColors.primary),
          ),
        ],
      ),
    );
  }
}