// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:keuanganku/app/app_colors.dart';
import 'package:keuanganku/app/reusable_widgets/app_bar/app_bar.dart';
import 'package:keuanganku/app/reusable_widgets/date_picker/show_date_picker.dart';
import 'package:keuanganku/app/reusable_widgets/heading_text/heading_text.dart';
import 'package:keuanganku/app/reusable_widgets/k_button/k_button.dart';
import 'package:keuanganku/app/reusable_widgets/k_dropdown_menu/k_drodpown_menu.dart';
import 'package:keuanganku/app/reusable_widgets/k_textfield/ktext_field.dart';
import 'package:keuanganku/app/reusable_widgets/time_picker/show_time_picker.dart';
import 'package:keuanganku/app/snack_bar.dart';
import 'package:keuanganku/database/helper/data_pengeluaran.dart';
import 'package:keuanganku/database/model/data_pengeluaran.dart';
import 'package:keuanganku/database/model/data_wallet.dart';
import 'package:keuanganku/enum/status.dart';
import 'package:keuanganku/main.dart';
import 'package:keuanganku/util/date_util.dart';
import 'package:keuanganku/util/dummy.dart';
import 'package:keuanganku/util/font_style.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class FormDataPengeluaran extends StatefulWidget {
  const FormDataPengeluaran({super.key, required this.onSaveCallback, required this.listWallet});
  final VoidCallback onSaveCallback;
  final List<SQLModelWallet> listWallet;
  
  @override
  State<FormDataPengeluaran> createState() => _FormDataPengeluaranState();
}

class _FormDataPengeluaranState extends State<FormDataPengeluaran> {
  final formKey = GlobalKey<FormState>();
  TextEditingController controllerJudul = TextEditingController();
  TextEditingController controllerJumlah = TextEditingController();
  TextEditingController controllerTanggal = TextEditingController();
  TextEditingController controllerWaktu = TextEditingController();
  TextEditingController controllerDeskripsi = TextEditingController();
  TextEditingController controllerInfoRating = TextEditingController();

  DateTime tanggalPengeluaran = DateTime.now();
  TimeOfDay jamPengeluaran = TimeOfDay.now();
  SQLModelWallet? walletTerpilih;  
  double ratingPengeluaran = 3;

  // Events
  void eventSimpanPengeluaran(BuildContext context, Size size) async {
    // Validator
    try {
      double.tryParse(controllerJumlah.text)!;
    } catch (invalidDouble){
      showDialog(
        context: context, 
        builder: (_){
          return AlertDialog(
            title: const Text("Invalid Double"),
            content: const Text("Masukan sebuah angka!"),
            actions: [
              KButton(
                onTap: () => Navigator.pop(_), 
                title: "OK BOS", 
                bgColor: ApplicationColors.primary,
                color: Colors.white,
                icon: const SizedBox()
              )
            ],
          );
        }
      );
      return;
    }
    double jumlahPengeluaran = double.parse(controllerJumlah.text);
    double jumlahUangPadaWallet = await walletTerpilih!.totalUang();
    if (jumlahUangPadaWallet < jumlahPengeluaran){
      showDialog(
        context: context, 
        builder: (_){
          return AlertDialog(
            title: const Text("Berotak Senku"),
            content: const Text("Duit lu kurang"),
            actions: [
              KButton(
                onTap: () => Navigator.pop(_), 
                title: "OK BOS", 
                bgColor: ApplicationColors.primary,
                color: Colors.white,
                icon: const SizedBox()
              )
            ],
          );
        });
      return;
    }
    // Process
    SQLModelPengeluaran dataBaru = SQLModelPengeluaran(
      id: -1, 
      id_wallet: walletTerpilih!.id, 
      id_kategori: 1, 
      judul: controllerJudul.text, 
      deskripsi: controllerDeskripsi.text, 
      nilai: double.tryParse(controllerJumlah.text)!, 
      rating: ratingPengeluaran, 
      waktu: combineDtTod(tanggalPengeluaran, jamPengeluaran),
    );
    int exitCode = await SQLHelperPengeluaran().insert(dataBaru, db: db.database);
    if (exitCode != -1) {
      tampilkanSnackBar(context, jenisPesan: Pesan.Success, msg: "Data berhasil disimpan");
    } else {
      tampilkanSnackBar(context, jenisPesan: Pesan.Error, msg: "Something wrong...");
    }
    widget.onSaveCallback();
    Navigator.pop(context);
  }

  // Widgets
  Widget heading(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25,),
          child: HeadingText().h1("+ Pengeluaran Baru"),
        ),
        GestureDetector(
          child: const  Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Icon(Icons.close),
          ),
          onTap: (){
            Navigator.pop(context);
          },
        )
      ],
    );
  }
  Widget fieldJudul(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: KTextField(
        fieldController: controllerJudul, 
        fieldName: "Judul Pengeluaran", 
        icon: Icons.title_sharp,
        prefixIconColor: ApplicationColors.primary  ),
    );
  }
  Widget fieldJumlah(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: KTextField(
        fieldController: controllerJumlah, 
        fieldName: "Jumlah Pengeluaran", 
        icon: Icons.attach_money,
        keyboardType: TextInputType.number,
        prefixIconColor: ApplicationColors.primary),
    );
  }
  Widget fieldTanggal(BuildContext context, Size size){
    return Padding(
      padding: const EdgeInsets.only(left: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: 240,
            child: KTextField(
              fieldController: controllerTanggal, 
              fieldName: "Tanggal", 
              readOnly: true,
              prefixIconColor: ApplicationColors.primary,
              icon: Icons.calendar_month,
              onTap: () async {
                tanggalPengeluaran = await tampilkanDatePicker(
                  context: context,
                  waktuAwal: DateTime(2000),
                  waktuAkhir: DateTime.now(),
                  waktuInisialisasi: tanggalPengeluaran
                );
                controllerTanggal.text = formatTanggal(tanggalPengeluaran);
              },
            ),
          ),
        ],
      ),
    );
  }
  Widget fieldJam(BuildContext context, Size size){
    return Padding(
      padding: const EdgeInsets.only(left: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: 125,
            child: KTextField(
              fieldController: controllerWaktu, 
              fieldName: "Jam", 
              readOnly: true,
              prefixIconColor: ApplicationColors.primary,
              icon: Icons.alarm,
              onTap: () async {
                jamPengeluaran = await tampilkanTimePicker(context: context, waktu: jamPengeluaran);
                controllerWaktu.text = formatWaktu(jamPengeluaran);
              },
            ),
          ),
        ],
      ),
    );
  }
  Widget dropDownMenuWallet(List<SQLModelWallet> listWallet){
    walletTerpilih ??= listWallet[0];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: KDropdownMenu<SQLModelWallet>(
        items: listWallet.map((e){
          return DropdownMenuItem<SQLModelWallet>(
            value: e,
            child: Row(
              children: [
                Icon(e.tipe == "Wallet"? Icons.wallet : Icons.account_balance),
                const SizedBox(width: 10,),
                Text(e.judul, style: kFontStyle(fontSize: 15, family: "QuickSand_Medium"),)
              ],
            )
          );
        }).toList(), 
        onChanged: (val){
          walletTerpilih = val;
        }, 
        value: walletTerpilih!, 
        labelText: "Wallet"
      ).getWidget(),
    );
  }
  Widget buttonClear(){
    return KButton(
      onTap: (){
        controllerJudul.text = "";
        controllerJumlah.text = "";
        walletTerpilih = widget.listWallet[0];
        setState(() {});
      }, 
      color: Colors.white, 
      bgColor: Colors.red, 
      title: "Bersihkan", 
      icon: const Icon(Icons.clear, color: Colors.white));
    }
  Widget buttonSimpan(BuildContext context, Size size){
    return
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: KButton(
        onTap: (){
          eventSimpanPengeluaran(context, size);
        },
        title: "Simpan", 
        icon: const Icon(Icons.save, color: Colors.white,),
        color: Colors.white,
        bgColor: Colors.green,
      ),
    );
  }
  Widget ratingBar(){
    return Padding(
      padding: const EdgeInsets.only(left: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: 155,
            child: KTextField(
              fieldController: controllerInfoRating, 
              fieldName: "Rating", 
              prefixIconColor: ApplicationColors.primary,
              icon: Icons.star,
              readOnly: true,
            ),
          ),
          const SizedBox(width: 10,),
          RatingBar.builder(
            initialRating: 3,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemPadding: const EdgeInsets.only(right: 4.0),
            itemBuilder: (context, _) => const Icon(
              Icons.star,
              color: Colors.amber,
            ),
            itemSize: 32.5,
            onRatingUpdate: (rating) {
              ratingPengeluaran = rating;
              controllerInfoRating.text = SQLModelPengeluaran.infoRating(rating);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    controllerTanggal.text = formatTanggal(tanggalPengeluaran);
    controllerWaktu.text = formatWaktu(jamPengeluaran);
    controllerInfoRating.text = SQLModelPengeluaran.infoRating(ratingPengeluaran);

    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: KAppBar(title: "Pengeluaran Baru", fontColor: ApplicationColors.primary).getWidget(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            dummyPadding(height: 15),
            fieldJudul(),
            dummyPadding(height: 20),
            fieldJumlah(),
            dummyPadding(height: 20),
            dropDownMenuWallet(widget.listWallet),
            dummyPadding(height: 20),
            fieldTanggal(context, size),
            dummyPadding(height: 20),
            fieldJam(context, size),
            dummyPadding(height: 20),
            ratingBar(),
            dummyPadding(height: 20),
            Row(
              children: [
                buttonSimpan(context, size),
                buttonClear(),
              ],
            ),
          ]
        ),
      )
      );
  }
}
