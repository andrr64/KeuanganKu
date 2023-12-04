import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keuanganku/app/main/pengeluaran/widgets/form_data_pengeluaran/widgets/field_deskripsi/field_deskripsi.dart';
import 'package:keuanganku/app/main/pengeluaran/widgets/form_data_pengeluaran/widgets/field_judul/field_judul.dart';
import 'package:keuanganku/app/main/pengeluaran/widgets/form_data_pengeluaran/widgets/field_jumlah_pengeluaran/field_jumlah_pengeluaran.dart';
import 'package:keuanganku/app/reusable_components/kiconfield/k_icon_field.dart';
import 'package:keuanganku/app/reusable_components/time_picker/show_time_picker.dart';
import 'package:keuanganku/app/reusable_components/tombol_tambah/tombol_tambah.dart';
import 'package:keuanganku/app/reusable_components/date_picker/show_date_picker.dart';
import 'package:keuanganku/database/helper/data_pengeluaran.dart';
import 'package:keuanganku/database/model/data_pengeluaran.dart';
import 'package:keuanganku/app/app_colors.dart';
import 'package:keuanganku/app/main/beranda/beranda.dart';
import 'package:keuanganku/main.dart';
import 'package:keuanganku/util/date_util.dart';

class FormDataPengeluaran extends StatefulWidget {
  const FormDataPengeluaran({super.key, required this.onSaveCallback});
  final VoidCallback onSaveCallback;
  
  @override
  State<FormDataPengeluaran> createState() => _FormDataPengeluaranState();
}

class _FormDataPengeluaranState extends State<FormDataPengeluaran> {
  final formKey = GlobalKey<FormState>();

  DateTime tanggalTerpilih = DateTime.now();
  TimeOfDay waktuTerpilih = TimeOfDay.now();
  final DateTime tanggalAwal = DateTime(2000); // Datetime tahun 2000 mulainya
  final DateTime tanggalAkhir = DateTime.now(); // Akhir datetime
  final TextEditingController controllerFieldJudul = TextEditingController();
  final TextEditingController controllerFieldDeskripsi = TextEditingController();
  final TextEditingController controllerFieldNilai = TextEditingController();
  final TextEditingController controllerTanggal = TextEditingController();
  final TextEditingController controllerWaktu = TextEditingController();

  void updateThiState(){
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // Events
    void eventSimpanData(){
      DateTime waktuPengeluaran = DateTime(tanggalTerpilih.year, tanggalTerpilih.month, tanggalTerpilih.day, waktuTerpilih.hour, waktuTerpilih.minute);
      ModelDataPengeluaran dataBaru = ModelDataPengeluaran(
        -1, 
        controllerFieldJudul.text, 
        controllerFieldDeskripsi.text, 
        double.tryParse(controllerFieldNilai.text) ?? 0, 
        waktuPengeluaran,
        1, 
        1, 
        0
      );
      SQLDataPengeluaran().insert(dataBaru, db: db.database);
      HalamanBeranda.state.update!();
      widget.onSaveCallback();
      Navigator.pop(context);
    }
    
    void eventPilihTanggal() async{
      tanggalTerpilih = await tampilkanDatePicker(context: context, waktuAwal: tanggalAwal, waktuAkhir: tanggalAkhir, waktuInisialisasi: tanggalTerpilih);
      updateThiState();
    }

    void eventPilihWaktu() async {
      waktuTerpilih = await tampilkanTimePicker(context: context, waktu: waktuTerpilih);
    }

    Widget dummyPadding() => const SizedBox(height: 15,);

    Widget formContainer(){
      controllerTanggal.text = formatTanggal(tanggalTerpilih);
      controllerWaktu.text = formatWaktu(waktuTerpilih);

      return 
      Container(
        alignment: Alignment.topLeft,
        width: MediaQuery.sizeOf(context).width  * 0.9,
        child: Form(
          key: formKey,
          child: Column(
            children: [
                FieldJudul(controllerFieldJudul).getWidget(),
                dummyPadding(),
                FieldDeskripsi(controllerFieldDeskripsi).getWidget(),
                dummyPadding(),
                FieldJumlahIDR(controllerFieldNilai).getWidget(),
                dummyPadding(),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    KIconField(
                      icon: const Icon(CupertinoIcons.calendar),
                      fieldName: "Tanggal",
                      onTap: eventPilihTanggal,
                      controller: controllerTanggal,
                      fieldWidth: MediaQuery.sizeOf(context).width * 0.5,
                      boxWidth: MediaQuery.sizeOf(context).width * 0.6,
                    ),
                    KIconField(
                      icon: const Icon(CupertinoIcons.clock),
                      fieldName: "Jam",
                      onTap: eventPilihWaktu,
                      controller: controllerWaktu,
                      fieldWidth: MediaQuery.sizeOf(context).width * 0.175,
                      boxWidth: MediaQuery.sizeOf(context).width * 0.275,
                    )
                  ]
                ),
                dummyPadding(),
                TombolTambah(ketikaDitekan: eventSimpanData).getWidget(),
              ],
          )
        ),
      );
    }

    Widget formTopBar(){
      return 
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
      );
    }

    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dummyPadding(),
              dummyPadding(),
              formTopBar(),
              dummyPadding(),
              formContainer()
            ],
          ),
        ),
      ),
    );
  }
}
