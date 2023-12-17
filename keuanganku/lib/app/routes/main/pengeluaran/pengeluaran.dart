import 'package:flutter/material.dart';
import 'package:keuanganku/app/app_colors.dart';
import 'package:keuanganku/app/widgets/k_app_bar/k_app_bar.dart';
import 'package:keuanganku/app/routes/main/beranda/beranda.dart';
import 'package:keuanganku/app/routes/main/pengeluaran/widgets/list_pengeluaran/list_pengeluaran.dart';
import 'package:keuanganku/app/routes/main/wallet/wallet.dart';
import 'package:keuanganku/app/state_bridge.dart';
import 'package:keuanganku/app/widgets/k_card/k_card.dart';
import 'package:keuanganku/app/widgets/k_empty/k_empty.dart';
import 'package:keuanganku/database/helper/expense.dart';
import 'package:keuanganku/main.dart';
import 'package:keuanganku/util/dummy.dart';

class HalamanPengeluaran extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;
  static StateBridge state = StateBridge();

  const HalamanPengeluaran({super.key, required this.parentScaffoldKey});

  @override
  State<HalamanPengeluaran> createState() => _HalamanPengeluaranState();
}

class _HalamanPengeluaranState extends State<HalamanPengeluaran> {

  KEventHandler updateState(){
    setState(() {});
  }
  
  Widget drawerButton(){
    return GestureDetector(
      onTap: (){
        widget.parentScaffoldKey.currentState!.openDrawer();
      },
      child: const Icon(
        Icons.menu, 
        size: 30, 
        color: Colors.white,
      ),
    );
  }
  Widget listPengeluaran(){
    return FutureBuilder(
      future: SQLHelperExpense().readAll(db.database), 
      builder: (_, snapshot){
        if (snapshot.connectionState == ConnectionState.waiting){
          return makeCenterWithRow(child: const CircularProgressIndicator());
        } else if (snapshot.hasError){
          return makeCenterWithRow(child: const Text("Sadly, something wrong..."));
        } else {
          void callback(){
            updateState();
            HalamanBeranda.state.update();
            HalamanPengeluaran.state.update();
            HalamanWallet.state.update();
          }
          return ListPengeluaran(
            listPengeluaran: snapshot.data!, 
            callback: callback
          );
        }
      }
    );
  }
  Widget listExpenseLimiter(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: KCard(
        title: "Expense Limiter", 
        child: KEmpty()
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    HalamanPengeluaran.state.init(() {setState(() {
      
    });});
    return Scaffold(
      backgroundColor: ApplicationColors.primary,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            dummyPadding(height: 50),
            KPageAppBar(
              title: "Pengeluaran", 
              menuButton: drawerButton()
            ),
            dummyPadding(height: 15),
            listPengeluaran(),
            dummyPadding(height: 15),
            listExpenseLimiter(),
            dummyPadding(height: 15)
          ],
        ),
      )
    );
  }
}