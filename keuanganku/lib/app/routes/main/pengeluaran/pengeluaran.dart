import 'package:flutter/material.dart';
import 'package:keuanganku/app/app_colors.dart';
import 'package:keuanganku/app/reusable_widgets/k_app_bar/k_app_bar.dart';
import 'package:keuanganku/app/routes/main/beranda/beranda.dart';
import 'package:keuanganku/app/routes/main/pengeluaran/widgets/list_pengeluaran/list_pengeluaran.dart';
import 'package:keuanganku/app/routes/main/wallet/wallet.dart';
import 'package:keuanganku/app/state_bridge.dart';
import 'package:keuanganku/util/dummy.dart';

class HalamanPengeluaran extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;
  static StateBridge state = StateBridge();

  const HalamanPengeluaran({super.key, required this.parentScaffoldKey});

  @override
  State<HalamanPengeluaran> createState() => _HalamanPengeluaranState();
}

class _HalamanPengeluaranState extends State<HalamanPengeluaran> {

  void updateState(){
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
            dummyPadding(height: 25),
            ListPengeluaran(
              callback: (){
                setState(() {
                  
                });
                HalamanBeranda.state.update();
                HalamanWallet.state.update();
              },),
          ],
        ),
      )
    );
  }
}