import 'package:flutter/material.dart';
import 'package:keuanganku/app/app_colors.dart';
import 'package:keuanganku/app/routes/main/wallet/widgets/list_wallet/list_wallet.dart';
import 'package:keuanganku/app/reusable_widgets/k_app_bar/k_app_bar.dart';
import 'package:keuanganku/app/state_bridge.dart';
import 'package:keuanganku/util/dummy.dart';

class StateData {
  final Color backgroundColor = Colors.white;
}

class HalamanWallet extends StatefulWidget {
  const HalamanWallet({super.key, required this.parentScaffoldKey});
  static StateBridge state = StateBridge();
  final GlobalKey<ScaffoldState> parentScaffoldKey;

  @override
  State<HalamanWallet> createState() => _HalamanWalletState();
}

class _HalamanWalletState extends State<HalamanWallet> {

  void updateState(){
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    HalamanWallet.state.init(() {
      setState(() {
        
      });
    });
    // Widgets
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

    return Scaffold(
      backgroundColor: ApplicationColors.primary,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            dummyPadding(height: 50),
            KPageAppBar(title: "Wallet", menuButton: drawerButton()),
            dummyPadding(height: 25),
            ListWallet(
              callback: updateState
            ),
            dummyPadding(height: 100),
          ],
        ),
      )
    );
  }
}
