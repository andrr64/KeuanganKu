import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:keuanganku/app/app_colors.dart';
import 'package:keuanganku/app/routes/main/pengeluaran/pages/form_expense_limiter/form_expense_limiter.dart';
import 'package:keuanganku/app/routes/main/pengeluaran/widgets/k_expenselimiter_item/expense_limiter_item.dart';
import 'package:keuanganku/app/widgets/k_button/k_button.dart';
import 'package:keuanganku/app/widgets/k_card/k_card.dart';
import 'package:keuanganku/app/widgets/k_empty/k_empty.dart';
import 'package:keuanganku/database/helper/expense_limiter.dart';
import 'package:keuanganku/database/helper/income_category.dart';
import 'package:keuanganku/database/model/expense_limiter.dart';
import 'package:keuanganku/main.dart';
import 'package:keuanganku/util/dummy.dart';


class ListExpenseLimiter extends StatefulWidget {
  const ListExpenseLimiter({
    super.key,
    required this.callback
  });
  final VoidCallback callback;

  @override
  State<ListExpenseLimiter> createState() => _ListExpenseLimiterState();
}

class _ListExpenseLimiterState extends State<ListExpenseLimiter> {
  void callback(){
    setState(() {});
    widget.callback();
  }

  Widget tombolTambah(BuildContext context){
    return KButton(
      onTap: (){
        Future getListKategori() async {
          return await SQLHelperExpenseCategory().readAll(db: db.database);
        }
        getListKategori().then(
          (listKategori){
            Navigator.push(context, MaterialPageRoute(builder: (_) => FormExpenseLimiter(
              callback: callback,
              listCategory: listKategori,
            )));
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
          for (var data in listLimiter)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: ExpenseLimiterItem(
                callback: callback,
                limiter: data,
              ),
            ),
        ],
      );
    }
  }

  Widget buildBody(){
    return FutureBuilder(
      future: SQLHelperExpenseLimiter().readAll(db.database), 
      builder: (_, snapshot){
        if (snapshot.connectionState == ConnectionState.waiting){
          return makeCenterWithRow(child: const CircularProgressIndicator());
        } 
        else if (snapshot.hasError){
          return makeCenterWithRow(child: const Text("Sadly, something wrong.."));
        }
        else {
          return buildList(snapshot.data!);
        }
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    final icon = SvgPicture.asset("assets/icons/expense_limiter.svg",height: 30,);
    return KCard(
      title: "Limiter", 
      icon: icon,
      button: tombolTambah(context),
      child: buildBody()
    );
  }
}