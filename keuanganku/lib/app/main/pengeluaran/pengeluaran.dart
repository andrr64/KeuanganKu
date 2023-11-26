import 'package:flutter/material.dart';
import 'package:keuanganku/app/app_colors.dart';
import 'package:keuanganku/app/state_bridge.dart';
import 'package:keuanganku/database/helper/data_pengeluaran.dart';
import 'package:keuanganku/database/model/data_pengeluaran.dart';
import 'package:keuanganku/main.dart';

class HalamanPengeluaran extends StatefulWidget {
  const HalamanPengeluaran({super.key});

  static StateBridge state = StateBridge();

  @override
  State<HalamanPengeluaran> createState() => _HalamanPengeluaranState();
}

class _HalamanPengeluaranState extends State<HalamanPengeluaran> {
  int __index = 2;
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
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        backgroundColor: ApplicationColors.primary,
        onPressed: (){
          final exitCode = DataPengeluaran().insert(
            ModelDataPengeluaran(id: __index, id_wallet: 1, id_kategori: 1, judul: "Test", deskripsi: "", nilai: 123, waktu: DateTime.now()), 
            db: db.database
          );
          
          { //TODO: handle exitCode
          }
          
          setState(() {
            __index ++;
          });
          /* showModalBottomSheet(
            context: context, 
            builder: (BuildContext context){
              return const Center(
                child: Text("Aku sebuah teks di tengah-tengah"),
              );
            },
          );
        */
         },
        child: const Icon(Icons.add, color: Colors.white,),
      ),
      body: FutureBuilder(
        future: DataPengeluaran().readAll(db.database), 
        builder: (context, snapshot){
          if (snapshot.hasData){
            if (snapshot.data!.length == 0){
              return const Text("Dude, you dont have data");
            } else {
              print(snapshot.data!.length);
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) => ListTile(title: Text(snapshot.data![index].judul),)
              );
            }
          } else {
            return const CircularProgressIndicator(color: ApplicationColors.primary,);
          }
        }
      )
    );
  }
}
