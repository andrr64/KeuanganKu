import 'package:flutter/material.dart';
import 'package:keuanganku/app/app_colors.dart';
import 'package:keuanganku/app/main/beranda/beranda.dart';
import 'package:keuanganku/app/reusable_components/ktextfield/ktext_field.dart';
import 'package:keuanganku/database/helper/data_pengeluaran.dart';
import 'package:keuanganku/database/model/data_pengeluaran.dart';
import 'package:keuanganku/main.dart';

class FormDataPengeluaran extends StatefulWidget {
  const FormDataPengeluaran({super.key, required this.onSaveCallback});
  final VoidCallback onSaveCallback;
  
  @override
  State<FormDataPengeluaran> createState() => _FormDataPengeluaranState();
}

class _FormDataPengeluaranState extends State<FormDataPengeluaran> {
  final formKey = GlobalKey<FormState>();

  final TextEditingController _controllerFieldJudul = TextEditingController();
  final TextEditingController _controllerFieldDeskripsi = TextEditingController();
  final TextEditingController _controllerFieldNilai = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: MediaQuery.sizeOf(context).height * 0.05,),
            SizedBox(
              width: MediaQuery.sizeOf(context).width  * 0.9,
              child: const Text("Data Baru"),
            ),
            const SizedBox(height: 15,),
            Container(
              alignment: Alignment.topLeft,
              width: MediaQuery.sizeOf(context).width  * 0.9,
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                      KTextField(
                        fieldController: _controllerFieldJudul,
                        icon: Icons.title,
                        fieldName: "Judul", 
                        prefixIconColor: ApplicationColors.primary
                      ),
                      const SizedBox(height: 15,),
                      KTextField(
                        fieldController: _controllerFieldDeskripsi,
                        icon: Icons.description,
                        fieldName: "Deskripsi", 
                        prefixIconColor: ApplicationColors.primary
                      ),
                      const SizedBox(height: 15,),
                      KTextField(
                        fieldController: _controllerFieldNilai,
                        icon: Icons.attach_money,
                        fieldName: "Jumlah", 
                        prefixIconColor: ApplicationColors.primary
                      ),
                      const SizedBox(height: 15,),
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
                  id: -1, 
                  id_wallet: 1, 
                  id_kategori: 1, 
                  judul: _controllerFieldJudul.text, 
                  deskripsi: _controllerFieldDeskripsi.text, 
                  nilai: double.tryParse(_controllerFieldNilai.text) ?? 0, 
                  waktu: DateTime.now(),
                );
                DataPengeluaran().create(dataBaru, db: db.database);
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
