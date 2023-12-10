import 'package:flutter/material.dart';
import 'package:keuanganku/app/app_colors.dart';
import 'package:keuanganku/app/main/beranda/widgets/distribusi/distribusi_transaksi.dart';
import 'package:keuanganku/app/main/beranda/widgets/list_wallet/list_wallet.dart';
import 'package:keuanganku/app/main/beranda/widgets/statistik/statistik.dart';
import 'package:keuanganku/app/state_bridge.dart';
import 'package:keuanganku/util/dummy.dart';

class Data {

}

class HalamanBeranda extends StatefulWidget {
  const HalamanBeranda({super.key, required this.updateParentState});

  final void Function() updateParentState;
  
  static Data data = Data();
  static StateBridge state = StateBridge();

  @override
  State<HalamanBeranda> createState() => _HalamanBerandaState();
}

class _HalamanBerandaState extends State<HalamanBeranda> {

  @override
  void initState() {
    super.initState();
    HalamanBeranda.state.init(updateState);
  }

  void updateState() {
    setState(() {

    });
  }

  Widget buildBody(BuildContext context){
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          dummyPadding(height: 25),
          const ListWallet(),
          dummyPadding(height: 25),
          const SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: IntrinsicHeight(
              child: IntrinsicWidth(
                child: Row(
                  children: [
                    SizedBox(width: 25,),
                    Statistik(),
                    SizedBox(width: 15,),
                    DistribusiTransaksi(),
                    SizedBox(width: 25,),
                  ],
                ),
              ),
            )
          ),
          dummyPadding(height: 100),
        ]
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ApplicationColors.primaryBlue,
      body: buildBody(context)
    );
  }
}
