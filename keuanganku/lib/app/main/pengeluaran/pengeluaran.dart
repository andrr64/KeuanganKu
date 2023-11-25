import 'package:flutter/material.dart';
import 'package:keuanganku/app/app_colors.dart';
import 'package:keuanganku/app/state_bridge.dart';

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
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        backgroundColor: ApplicationColors.primary,
        onPressed: (){
          showModalBottomSheet(
            context: context, 
            builder: (BuildContext context){
              return const Center(
                child: Text("Aku sebuah teks di tengah-tengah"),
              );
            },
          );
         },
        child: const Icon(Icons.add, color: Colors.white,),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            vertical: MediaQuery.sizeOf(context).height * 0.02,
            horizontal: MediaQuery.sizeOf(context).width * 0.02,
        ),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            
          ],
        ),
      ),
    );
  }
}
