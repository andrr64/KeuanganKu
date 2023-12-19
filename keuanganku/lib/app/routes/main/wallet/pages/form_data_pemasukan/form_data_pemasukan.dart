// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keuanganku/app/app_colors.dart';
import 'package:keuanganku/app/snack_bar.dart';
import 'package:keuanganku/app/widgets/app_bar/app_bar.dart';
import 'package:keuanganku/app/widgets/date_picker/show_date_picker.dart';
import 'package:keuanganku/app/widgets/heading_text/heading_text.dart';
import 'package:keuanganku/app/widgets/k_button/k_button.dart';
import 'package:keuanganku/app/widgets/k_dialog/k_dialog_info.dart';
import 'package:keuanganku/app/widgets/k_dropdown_menu/k_drodpown_menu.dart';
import 'package:keuanganku/app/widgets/k_textfield/ktext_field.dart';
import 'package:keuanganku/app/widgets/time_picker/show_time_picker.dart';
import 'package:keuanganku/database/helper/expense_category.dart';
import 'package:keuanganku/database/helper/income.dart';
import 'package:keuanganku/database/model/category.dart';
import 'package:keuanganku/database/model/income.dart';
import 'package:keuanganku/database/model/expense.dart';
import 'package:keuanganku/database/model/wallet.dart';
import 'package:keuanganku/enum/status.dart';
import 'package:keuanganku/k_typedef.dart';
import 'package:keuanganku/main.dart';
import 'package:keuanganku/util/date_util.dart';
import 'package:keuanganku/util/dummy.dart';
import 'package:keuanganku/util/font_style.dart';

class Data {
  SQLModelWallet? walletTerpilih;
  SQLModelCategory? kategoriTerpilih;
}

class FormInputPemasukan extends StatefulWidget {
  FormInputPemasukan({
    super.key, 
    required this.callback,
    required this.listWallet,
    required this.listKategori,
    this.isWithData,
    this.pemasukan
  });
  final KEventHandler Function() callback;
  final List<SQLModelWallet> listWallet;
  final List<SQLModelCategory> listKategori;
  final Data data = Data();
  final bool? isWithData;
  final SQLModelIncome? pemasukan;

  @override
  State<FormInputPemasukan> createState() => _FormInputPemasukanState();
}

class _FormInputPemasukanState extends State<FormInputPemasukan> {
  final formKey = GlobalKey<FormState>();
  TextEditingController controllerJudul = TextEditingController();
  TextEditingController controllerJumlah = TextEditingController();
  TextEditingController controllerTanggal = TextEditingController();
  TextEditingController controllerWaktu = TextEditingController();
  TextEditingController controllerDeskripsi = TextEditingController();
  TextEditingController controllerInfoRating = TextEditingController();
  
  DateTime  tanggalPengeluaran = DateTime.now();
  TimeOfDay jamPengeluaran = TimeOfDay.now();
  double    ratingPengeluaran = 3;

  // Events
  KEventHandler   simpanData          (BuildContext context, Size size) {
    Future memprosesData() async{
      // Validator
      try {
        double.tryParse(controllerJumlah.text)!;
      } catch (invalidDouble){
        KDialogInfo(
          title: "Invalid", 
          info: "Masukan sebuah angka...", 
          jenisPesan: Pesan.Error
        ).tampilkanDialog(context);
        return;
      }
      double jumlahPengeluaran = double.parse(controllerJumlah.text);
      if (jumlahPengeluaran <= 0){
        KDialogInfo(
          title: 'Invalid',
          info: 'Masukan angka lebih dari 0!',
          jenisPesan: Pesan.Error
        ).tampilkanDialog(context);
        return;
      }

      // Process
      SQLModelIncome dataBaru = SQLModelIncome(
        id: -1, 
        id_wallet: widget.data.walletTerpilih!.id, 
        id_kategori: widget.data.kategoriTerpilih!.id, 
        judul: controllerJudul.text, 
        deskripsi: controllerDeskripsi.text, 
        nilai: double.tryParse(controllerJumlah.text)!, 
        waktu: combineDtTod(tanggalPengeluaran, jamPengeluaran),
      );
      widget.callback();
      if ((await SQLHelperIncome().insert(dataBaru, db.database)) != -1) {
        tampilkanSnackBar(context, jenisPesan: Pesan.Success, msg: "Data berhasil disimpan");
      } else {
        tampilkanSnackBar(context, jenisPesan: Pesan.Error, msg: "Something wrong...");
      }
      Navigator.pop(context);
    }
    memprosesData().then((value){
      widget.callback();
    });
  }
  KEventHandler   updateData          (BuildContext context){
    try {
      double.tryParse(controllerJumlah.text)!;
    } catch (invalidDouble){
      KDialogInfo(
        title: "Invalid", 
        info: "Masukan sebuah angka...", 
        jenisPesan: Pesan.Error
      ).tampilkanDialog(context);
      return;
    }
    double jumlahPengeluaran = double.parse(controllerJumlah.text);
    SQLModelIncome dataBaru = SQLModelIncome(
      id: widget.pemasukan!.id, 
      id_wallet: widget.data.walletTerpilih!.id, 
      id_kategori: widget.data.kategoriTerpilih!.id, 
      judul: controllerJudul.text, 
      deskripsi: controllerDeskripsi.text, 
      nilai: jumlahPengeluaran, 
      waktu: combineDtTod(tanggalPengeluaran, jamPengeluaran));
    Future updateDataKeDatabase() async {
      return await SQLHelperIncome().update(dataBaru, db.database);
    }
    updateDataKeDatabase().then((value){
      if (value != -1){
        tampilkanSnackBar(context, jenisPesan: Pesan.Success, msg: "Data Berhasil Diperbaharui");
      } else {
        tampilkanSnackBar(context, jenisPesan: Pesan.Error, msg: "Something wrong...");
      }
      widget.callback();
    });
  }
  KEventHandler   hapusData           (BuildContext context) {
    if (widget.pemasukan == null) {
      return;
    }

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text("Konfirmasi Hapus"),
          content: const Text("Apakah Anda yakin ingin menghapus data ini?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext); // Tutup dialog konfirmasi
              },
              child: const Text("Batal"),
            ),
            TextButton(
              onPressed: () async {
                // Hapus data
                int result = await SQLHelperIncome().delete(widget.pemasukan!.id, db.database);

                if (result != -1) {
                  tampilkanSnackBar(context, jenisPesan: Pesan.Success, msg: "Data Berhasil Dihapus");
                } else {
                  tampilkanSnackBar(context, jenisPesan: Pesan.Error, msg: "Something wrong...");
                }
                widget.callback();
                Navigator.pop(dialogContext); // Tutup dialog konfirmasi
                Navigator.pop(context); // Tutup halaman form setelah menghapus data
              },
              child: const Text("Hapus"),
            ),
          ],
        );
      },
    );
  }
  KVoidValidator  isWithDataValidator (){
    if (widget.isWithData == true){
      controllerDeskripsi.text = widget.pemasukan!.deskripsi;
      controllerJudul.text = widget.pemasukan!.judul;
      controllerJumlah.text = widget.pemasukan!.nilai.toString();
      tanggalPengeluaran = widget.pemasukan!.waktu;
      jamPengeluaran = TimeOfDay.fromDateTime(widget.pemasukan!.waktu);

      // Set value for dropdown menus
      controllerTanggal.text = formatTanggal(tanggalPengeluaran);
      controllerWaktu.text = formatWaktu(jamPengeluaran);
    }
  }
  
  // Widgets
  List<KWidget>   buttonAction        (BuildContext context){
    return [
      GestureDetector(
        onTap: (){
          hapusData(context);
        },
        child: const Icon(CupertinoIcons.delete),
      ),
      const SizedBox(width: 25,)
    ];
  }
  KWidget         buttonUpdate        (BuildContext context){
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 10),
      child: KButton(
        onTap: (){
          updateData(context);
        }, 
        title: "Update", 
        color: Colors.white,
        bgColor: ApplicationColors.primary,
        icon: const Icon(CupertinoIcons.upload_circle, color: Colors.white,),
      ),
    );
  }
  KWidget         buttonSimpan        (BuildContext context, Size size){
    return
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: KButton(
        onTap: (){
          simpanData(context, size);
        },
        title: "Simpan", 
        icon: const Icon(Icons.save, color: Colors.white,),
        color: Colors.white,
        bgColor: Colors.green,
      ),
    );
  }
  KWidget         heading             (){
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
  KFormWidget     dropDownKategori    (BuildContext context){
      if (widget.isWithData == true){
        for(var x in widget.listKategori){
          if (x.id == widget.pemasukan!.id_kategori){
            widget.data.kategoriTerpilih = x;
            break;
          }
        }
      } else {
        widget.data.kategoriTerpilih = widget.listKategori[0];
      }
      List<DropdownMenuItem<SQLModelCategory>> items (){
        List<DropdownMenuItem<SQLModelCategory>> listItem = widget.listKategori.map((kategori){
            return DropdownMenuItem<SQLModelCategory>(
              value: kategori,
              child: Text(kategori.judul, style: kFontStyle(fontSize: 16, family: "QuickSand_Medium"),),
            );
          }).toList();
        listItem.add(
          DropdownMenuItem<SQLModelCategory>(
            value: SQLModelCategory(id: 0, judul: "Tambah Kategori"),
            child: Row(
              children: [
                const Icon(Icons.add), 
                const SizedBox(width: 10,), 
                Text("Tambah Kategori", 
                style: kFontStyle(
                  fontSize: 16, 
                  family: "QuickSand_Medium"),
                )
              ],
            )
          ),
        );
        return listItem;
      }
      widget.data.kategoriTerpilih ??= widget.listKategori[0];
      
      return Padding(
        padding: const EdgeInsets.only(left: 25),
        child: IntrinsicWidth(
          child: KDropdownMenu<SQLModelCategory>(
            items: items(), 
            onChanged: (val){
              if (val!.id == 0){
                bool newCategoryCreated = false;
                showDialog(context: context, builder: (dialogContext){
                  TextEditingController controllerNamaKategori = TextEditingController();
                  return AlertDialog(
                    contentPadding: const EdgeInsets.all(25.0), // Sesuaikan dengan kebutuhan Anda
                    backgroundColor: Colors.white,
                    title: const Text("Kategori Baru"),
                    content: IntrinsicHeight(
                      child: SizedBox(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            KTextField(
                              fieldController: controllerNamaKategori, 
                              fieldName: "Judul", 
                              prefixIconColor: ApplicationColors.primary,
                              icon: Icons.title,
                            ),
                            dummyHeight(height: 15),
                            KButton(
                              onTap: () {
                                if (controllerNamaKategori.text.isEmpty){
                                  return;
                                }
                                SQLHelperIncomeCategory().insert(
                                  SQLModelCategory(
                                    id: -1, 
                                    judul: controllerNamaKategori.text
                                  ), 
                                  db: db.database
                                );
                                newCategoryCreated = true;
                                Navigator.pop(dialogContext);
                              }, 
                              color: Colors.white,
                              bgColor: Colors.green,
                              title: "Simpan", 
                              icon: const Icon(Icons.save, color: Colors.white,)
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).then((value){
                  if (newCategoryCreated){
                    tampilkanSnackBar(context, jenisPesan: Pesan.Success, msg: "Kategori baru berhasil ditambahkan");
                    Navigator.pop(context);
                  }
                });
                return;
              }
              widget.data.kategoriTerpilih = val;
            }, 
            value: widget.data.kategoriTerpilih!, 
            labelText: "Kategori",
          ).getWidget(),
        ),
      );
    }
  KFormWidget     dropDownMenuWallet  (){
    if (widget.isWithData == true){
      for (var wallet in widget.listWallet) {
        if (wallet.id == widget.pemasukan!.id_wallet){
          widget.data.walletTerpilih = wallet;
          break;
        }
      }
    }
    else {
      widget.data.walletTerpilih = widget.listWallet[0];
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: KDropdownMenu<SQLModelWallet>(
        items: widget.listWallet.map((e){
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
          widget.data.walletTerpilih = val;
        }, 
        value: widget.data.walletTerpilih!, 
        labelText: "Wallet"
      ).getWidget(),
    );
  }
  KFormWidget     fieldJudul          (){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: KTextField(
        fieldController: controllerJudul, 
        fieldName: "Judul", 
        icon: Icons.title_sharp,
        prefixIconColor: ApplicationColors.primary  ),
    );
  }
  KFormWidget     fieldJumlah         (){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: KTextField(
        fieldController: controllerJumlah, 
        fieldName: "Jumlah", 
        icon: Icons.attach_money,
        keyboardType: TextInputType.number,
        prefixIconColor: ApplicationColors.primary),
    );
  }
  KFormWidget     fieldDeskripsi      () {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: TextFormField(
        controller: controllerDeskripsi,
        maxLines: 5, // Sesuaikan dengan jumlah baris yang diinginkan
        decoration: const InputDecoration(
          label: Text("Deskripsi"),
          border: OutlineInputBorder()
        ),
      ),
    );
  }
  KFormWidget     fieldTanggal        (BuildContext context, Size size){
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
  KFormWidget     fieldJam            (BuildContext context, Size size){
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
  KApplicationBar appBar              (BuildContext context){
    return KAppBar(
      backgroundColor: Colors.white, 
      title: widget.isWithData == true ? "Detail Pemasukan" : "Pemasukan Baru", 
      fontColor: ApplicationColors.primary,
      action: widget.isWithData == true? buttonAction(context) : null
    ).getWidget();
  }

  @override
  Widget build(BuildContext context) {
    controllerTanggal.text = formatTanggal(tanggalPengeluaran);
    controllerWaktu.text = formatWaktu(jamPengeluaran);
    controllerInfoRating.text = SQLModelExpense.infoRating(ratingPengeluaran);
    isWithDataValidator();

    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: appBar(context),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            dummyHeight(height: 15),
            fieldJudul(),
            dummyHeight(height: 20),
            fieldJumlah(),
            dummyHeight(height: 20),
            fieldDeskripsi(),
            dummyHeight(height: 20),
            dropDownMenuWallet(),
            dummyHeight(height: 20),
            fieldTanggal(context, size),
            dummyHeight(height: 20),
            Row(
              children: [
                fieldJam(context, size),
                const SizedBox(width: 15,),
              ],
            ),
            dummyHeight(height: 20),
            dropDownKategori(context),
            dummyHeight(height: 20),
            Row(
              children: [
                widget.isWithData == true? buttonUpdate(context) : buttonSimpan(context, size),
              ],
            ),
            dummyHeight(height: 50)
          ]
        ),
      )
      );
  }
}