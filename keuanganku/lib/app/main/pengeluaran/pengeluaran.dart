import 'package:flutter/material.dart';
import 'package:keuanganku/app/app_colors.dart';
import 'package:keuanganku/app/main/beranda/widgets/daftar_transaksi/widgets/card_data_transaksi/card_data_transaksi.dart';
import 'package:keuanganku/app/main/pengeluaran/widgets/form_data_pengeluaran/form_data_pengeluaran.dart';
import 'package:keuanganku/app/state_bridge.dart';
import 'package:keuanganku/database/helper/data_pengeluaran.dart';
import 'package:keuanganku/main.dart';

class HalamanPengeluaran extends StatefulWidget {
  const HalamanPengeluaran({super.key});

  static StateBridge state = StateBridge();

  @override
  State<HalamanPengeluaran> createState() => _HalamanPengeluaranState();
}

class _HalamanPengeluaranState extends State<HalamanPengeluaran> {
  @override
  void initState() {
    super.initState();
    HalamanPengeluaran.state.init(() { 
      setState(() {
        
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // Events
    ketikaFloatingActionButtonDitekan(){
      showModalBottomSheet(
        context: context, 
        isScrollControlled: true,
        builder: (context) => FormDataPengeluaran(
          onSaveCallback: (){
            setState(() {});
          },
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        backgroundColor: ApplicationColors.primary,
        onPressed: ketikaFloatingActionButtonDitekan,
        child: const Icon(Icons.add, color: Colors.white,),
      ),
      body: Center(
        child: SizedBox(
          width: MediaQuery.sizeOf(context).width * 0.9,
          child: FutureBuilder(
            future: SQLDataPengeluaran().readAll(db.database), 
            builder: (context, snapshot){
              if (snapshot.hasData){
                if (snapshot.data!.isEmpty){
                  return const Text("Dude, you dont have data");
                } 
                else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) => CardPengeluaran(const Icon(Icons.store), dataTransaksi: snapshot.data![index])
                  );
                }
              } else {
                return const CircularProgressIndicator(color: ApplicationColors.primary,);
              }
            }
          ),
        ),
      )
    );
  }
}
