import 'package:flutter/material.dart';
import 'package:keuanganku/app/main/pengeluaran/widgets/form_data_pengeluaran/widgets/field_deskripsi/field_deskripsi.dart';
import 'package:keuanganku/app/main/pengeluaran/widgets/form_data_pengeluaran/widgets/field_judul/field_judul.dart';
import 'package:keuanganku/app/main/pengeluaran/widgets/form_data_pengeluaran/widgets/field_jumlah_pengeluaran/field_jumlah_pengeluaran.dart';
import 'package:keuanganku/database/helper/data_pengeluaran.dart';
import 'package:keuanganku/database/model/data_pengeluaran.dart';
import 'package:keuanganku/app/app_colors.dart';
import 'package:keuanganku/app/main/beranda/beranda.dart';
import 'package:keuanganku/main.dart';

class FormDataPengeluaran extends StatefulWidget {
  const FormDataPengeluaran({super.key, required this.onSaveCallback});
  final VoidCallback onSaveCallback;
  
  @override
  State<FormDataPengeluaran> createState() => _FormDataPengeluaranState();
}

class _FormDataPengeluaranState extends State<FormDataPengeluaran> {
  final formKey = GlobalKey<FormState>();

  DateTime _pickedDate = DateTime.now();
  DateTime _firstDate = DateTime(2000); // Datetime tahun 2000 mulainya
  DateTime _lastDate = DateTime.now(); // Akhir datetime

  final TextEditingController _controllerFieldJudul = TextEditingController();
  final TextEditingController _controllerFieldDeskripsi = TextEditingController();
  final TextEditingController _controllerFieldNilai = TextEditingController();

  @override
  Widget build(BuildContext context) {
    void doTampilkanDatePicker(){
      showDatePicker(
        context: context, 
        initialDate: _pickedDate,
        firstDate: _firstDate, 
        lastDate: _lastDate
      );
    }

    Widget dummyPadding() => const SizedBox(height: 15,);

    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: MediaQuery.sizeOf(context).height * 0.05,),
            SizedBox(
              width: MediaQuery.sizeOf(context).width  * 0.9,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(
                    child: Row(
                      children: [
                        Icon(Icons.add),
                        SizedBox(width: 10,),
                        Text("Data Baru",
                          style: TextStyle(
                            fontFamily: "QuickSand_Bold",
                            fontSize: 22,
                            color: ApplicationColors.primary
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    child: Icon(Icons.close, color: ApplicationColors.primaryColorWidthPercentage(percentage: 75),),
                    onTap: (){
                      Navigator.pop(context);
                    },
                  )
                ],
              )
            ),
            const SizedBox(height: 15,),
            Container(
              alignment: Alignment.topLeft,
              width: MediaQuery.sizeOf(context).width  * 0.9,
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                      FieldJudul(_controllerFieldJudul).getWidget(),
                      dummyPadding(),
                      FieldDeskripsi(_controllerFieldDeskripsi).getWidget(),
                      dummyPadding(),
                      FieldJumlahIDR(_controllerFieldNilai).getWidget(),
                      dummyPadding(),
                    ],
                )
              ),
            ),
            FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: ApplicationColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)
                )
              ),
              onPressed: (){
                ModelDataPengeluaran dataBaru = ModelDataPengeluaran(
                  -1, 
                  _controllerFieldJudul.text, 
                  _controllerFieldDeskripsi.text, 
                  double.tryParse(_controllerFieldNilai.text) ?? 0, 
                  DateTime.now(),
                  1, 
                  1, 
                  0
                );
                SQLDataPengeluaran().create(dataBaru, db: db.database);
                HalamanBeranda.state.update!();
                widget.onSaveCallback();
                Navigator.pop(context);
              }, 
              child: const Text("Tambah")
            )
          ],
        ),
      ),
    );
  }
}
