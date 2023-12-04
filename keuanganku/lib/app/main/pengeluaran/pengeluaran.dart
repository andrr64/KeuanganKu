import 'package:flutter/material.dart';
import 'package:keuanganku/app/app_colors.dart';
import 'package:keuanganku/app/main/pengeluaran/widgets/form_data_pengeluaran/form_data_pengeluaran.dart';
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
    // Events
    void tambahDataBaru(){
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

    Size display = MediaQuery.sizeOf(context);

    Widget buildBody(){
      return Column(
        children: [

        ],
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        backgroundColor: ApplicationColors.primary,
        onPressed: tambahDataBaru,
        child: const Icon(Icons.add, color: Colors.white,),
      ),
      body: Container(
        width: display.width * 0.9,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildBody()
          ],
        )
      )
    );
  }
}