import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:keuanganku/app/app_colors.dart';
import 'package:keuanganku/app/routes/main/pengeluaran/pages/form_expense_limiter/form_expense_limiter.dart';
import 'package:keuanganku/app/widgets/k_button/k_button.dart';
import 'package:keuanganku/app/widgets/k_card/k_card.dart';
import 'package:keuanganku/app/widgets/k_empty/k_empty.dart';
import 'package:keuanganku/database/helper/income_category.dart';
import 'package:keuanganku/database/model/expense_limiter.dart';
import 'package:keuanganku/main.dart';


class ListExpenseLimiter extends StatefulWidget {
  const ListExpenseLimiter({super.key});

  @override
  State<ListExpenseLimiter> createState() => _ListExpenseLimiterState();
}

class _ListExpenseLimiterState extends State<ListExpenseLimiter> {
  Widget tombolTambah(BuildContext context){
    return KButton(
      onTap: (){
        Future getListKategori() async {
          return await SQLHelperExpenseCategory().readAll(db: db.database);
        }
        getListKategori().then(
          (listKategori){
            Navigator.push(context, MaterialPageRoute(builder: (_) => FormExpenseLimiter(listCategory: listKategori,)));
          });
      }, 
      title: "Tambah", 
      icon: const Icon(Icons.add, color: ApplicationColors.primary,)
    );
  }
  
  Widget buildList(List<SQLModelExpenseLimiter> listLimiter){
    if (listLimiter.isEmpty){
      return const KEmpty();
    } else {
      return Column(
        children: [

        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final icon = SvgPicture.asset("assets/icons/expense_limiter.svg",height: 30,);
    return KCard(
      title: "Limiter", 
      icon: icon,
      button: tombolTambah(context),
      child: buildList([])
    );
  }
}