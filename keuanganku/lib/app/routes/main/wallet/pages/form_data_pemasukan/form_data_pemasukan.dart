// ignore_for_file: constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keuanganku/app/app_colors.dart';
import 'package:keuanganku/app/routes/main/wallet/pages/form_data_pemasukan/widgets/item_kategori.dart';
import 'package:keuanganku/app/snack_bar.dart';
import 'package:keuanganku/app/widgets/k_app_bar/k_app_bar.dart';
import 'package:keuanganku/app/widgets/k_date_picker/k_date_picker.dart';
import 'package:keuanganku/app/widgets/k_button/k_button.dart';
import 'package:keuanganku/app/widgets/k_dialog/k_dialog_info.dart';
import 'package:keuanganku/app/widgets/k_dropdown_menu/k_drodpown_menu.dart';
import 'package:keuanganku/app/widgets/k_future_builder/k_future.dart';
import 'package:keuanganku/app/widgets/k_textfield/ktext_field.dart';
import 'package:keuanganku/app/widgets/k_time_picker/k_time_picker.dart';
import 'package:keuanganku/database/helper/expense.dart';
import 'package:keuanganku/database/helper/income_category.dart';
import 'package:keuanganku/database/helper/income.dart';
import 'package:keuanganku/database/helper/wallet.dart';
import 'package:keuanganku/database/model/category.dart';
import 'package:keuanganku/database/model/const_value.dart';
import 'package:keuanganku/database/model/income.dart';
import 'package:keuanganku/database/model/expense.dart';
import 'package:keuanganku/database/model/wallet.dart';
import 'package:keuanganku/enum/status.dart';
import 'package:keuanganku/k_typedef.dart';
import 'package:keuanganku/main.dart';
import 'package:keuanganku/util/date_util.dart';
import 'package:keuanganku/util/dummy.dart';
import 'package:keuanganku/util/error.dart';
import 'package:keuanganku/util/font_style.dart';
import 'package:keuanganku/util/vector_operation.dart';

enum FormError {
  NamaKosong,
  OverflowMaxValue
}

class Data {
  SQLModelWallet? walletTerpilih;
  SQLModelCategory? kategoriTerpilih;
}

class FormInputPemasukan extends StatefulWidget {
  FormInputPemasukan({
    super.key, 
    required this.callback,
    this.isWithData,
    this.theDataIfIsWithData
  });
  final KEventHandler Function() callback;
  final Data data = Data();
  final bool? isWithData;
  final SQLModelIncome? theDataIfIsWithData;

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
  bool refresh = false;
  DateTime  tanggalPengeluaran = DateTime.now();
  TimeOfDay jamPengeluaran = TimeOfDay.now();
  double    ratingPengeluaran = 3;
  List<SQLModelWallet> listWallet = [];
  List<SQLModelCategory> listKategoriPemasukan = [];

  // Events
  Future          updateDataWalletDanKategori() async {
    listKategoriPemasukan = await SQLHelperIncomeCategory().readAll(db: db.database);
    listKategoriPemasukan.add(SQLModelCategory(id: 0, judul: "+ Tambah Kategori"));
    listWallet = await SQLHelperWallet().readAll(db.database);
  }
  KEventHandler   simpanData    (BuildContext context, Size size) {
    Future<dynamic> prosesData() async{
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
      if ((await SQLHelperIncome().insert(dataBaru, db.database)) != -1) {
        return Condition.OK;
      } else {
        return SQLError;
      }
    }
    prosesData().then((value){
      if (value == Condition.OK){
        tampilkanSnackBar(context, jenisPesan: Pesan.Success, msg: "Data berhasil disimpan");
      } else {
        tampilkanSnackBar(context, jenisPesan: Pesan.Error, msg: "Something wrong...");
      }
      Navigator.pop(context);
      widget.callback();
    });
  }
  
  KValidator      validatorUpdateData         (BuildContext context) async {
    double jumlahPemasukan = 0;
    try {
      jumlahPemasukan = double.parse(controllerJumlah.text);
    } catch (invalidDouble){
      return ValidatorError.InvalidInput;
    }
    SQLModelWallet wallet = await widget.theDataIfIsWithData!.wallet;
    List<SQLModelExpense> listPengeluaran = await SQLHelperExpense().readByWalletId(wallet.id, db.database);
    double totalUangPadaWallet = await wallet.totalUang();
    double totalPengeluaranPadaWallet = sumList(listPengeluaran.map((e) => e.nilai).toList());
    double totalNilaiTransaksiPadaWallet = totalUangPadaWallet + totalPengeluaranPadaWallet;
    if (totalNilaiTransaksiPadaWallet + jumlahPemasukan > MAX_VALUE){
      return ValidatorError.OverflowNumber;
    }
    else if (jumlahPemasukan <= 0){
      return ValidatorError.LessThanOrEqualZero;
    }
    return Condition.OK;
  }
  KValidator      validatorUpdateDataHandler  (BuildContext context, dynamic value){
    if (value == Condition.OK){
      tampilkanSnackBar(
        context, 
        jenisPesan: Pesan.Success, 
        msg: "Data berhasil diperbaharui"
      );
      Navigator.pop(context); // pop form pemasukan
      widget.callback();
    }
  }
  KEventHandler   updateData                  (BuildContext context){
    Future memprosesData() async {
      dynamic validatorResult = await validatorUpdateData(context);
      if (validatorResult != Condition.OK){
        return validatorResult;
      }
      SQLModelIncome dataBaru = SQLModelIncome(
        id: widget.theDataIfIsWithData!.id, 
        id_wallet: widget.data.walletTerpilih!.id, 
        id_kategori: widget.data.kategoriTerpilih!.id, 
        judul: controllerJudul.text, 
        deskripsi: controllerDeskripsi.text, 
        nilai: double.parse(controllerJumlah.text), 
        waktu: combineDtTod(tanggalPengeluaran, jamPengeluaran
      ));
      if (await SQLHelperIncome().update(dataBaru, db.database) != -1){
        return Condition.OK;
      }
      return SQLError.Update;
    }
    
    memprosesData().then((value){
      validatorUpdateDataHandler(context, value);
    });
  }
  
  KEventHandler   hapusData           (BuildContext context) {
    if (widget.theDataIfIsWithData == null) {
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
              onPressed: () {
                Future prosesData() async {
                  if ((await SQLHelperIncome().delete(widget.theDataIfIsWithData!.id, db.database)) != -1) {
                    return Condition.OK;
                  } else {
                    return SQLError;
                  }
                }
                prosesData().then((value){
                  if (value == Condition.OK){
                    tampilkanSnackBar(context, jenisPesan: Pesan.Success, msg: "Data Berhasil Dihapus");
                  } else {
                    tampilkanSnackBar(context, jenisPesan: Pesan.Error, msg: "Something wrong...");
                  }
                  widget.callback();
                  Navigator.pop(dialogContext); // Tutup dialog konfirmasi
                  Navigator.pop(context); // Tutup halaman form setelah menghapus data
                });
              },
              child: const Text("Hapus"),
            ),
          ],
        );
      },
    );
  }
  KEventHandler   isWithDataCheck     (){
    if (widget.isWithData == true){
      controllerDeskripsi.text = widget.theDataIfIsWithData!.deskripsi;
      controllerJudul.text = widget.theDataIfIsWithData!.judul;
      controllerJumlah.text = widget.theDataIfIsWithData!.nilai.toString();
      tanggalPengeluaran = widget.theDataIfIsWithData!.waktu;
      jamPengeluaran = TimeOfDay.fromDateTime(widget.theDataIfIsWithData!.waktu);

      // Set value for dropdown menus
      controllerTanggal.text = formatTanggal(tanggalPengeluaran);
      controllerWaktu.text = formatWaktu(jamPengeluaran);
    }
  }
  
  void            updateState         (){
    setState(() {
      
    });
  }
  KEventHandler   tambahKategoriBaru  (BuildContext context){
    TextEditingController controllerNamaKategori = TextEditingController();
    Future simpanData() async{
      if (controllerNamaKategori.text.isEmpty){
        return ValidatorError.InvalidInput;
      }
      if (await SQLHelperIncomeCategory().insert(SQLModelCategory(id: -1, judul: controllerNamaKategori.text), db: db.database) != -1){
        return Condition.OK;
      }
      return Condition.ERROR;
    }
    showDialog(
      context: context, 
      builder: (dialogContext){
        return AlertDialog(
          content: IntrinsicHeight(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Kategori baru", style: kFontStyle(fontSize: 20),),
                  Text(
                    "Isi nama kategori maksimal 25 karakter",
                    style: kFontStyle(fontSize: 13, family: "QuickSand_Medium"),
                  ),
                  dummyHeight(),
                  KTextField(
                    fieldController: controllerNamaKategori, 
                    fieldName: "Nama", 
                    icon: Icons.title,
                    maxLength: 25,
                    prefixIconColor: KColors.backgroundPrimary
                  ),
                  KButton(
                    onTap: (){
                      simpanData().then((value){
                        if (value == Condition.OK){
                          Navigator.pop(dialogContext);
                          tampilkanSnackBar(
                            context, 
                            jenisPesan: Pesan.Success, 
                            msg: "Data berhasil disimpan :D"
                          );
                          refresh = true;
                          updateState();
                        } else if (value == ValidatorError.InvalidInput){
                          KDialogInfo(
                            title: "Error", 
                            info: "Masukan nama >:(", 
                            jenisPesan: Pesan.Error
                          ).tampilkanDialog(dialogContext);
                        } else {
                          tampilkanSnackBar(
                            context, 
                            jenisPesan: Pesan.Error, 
                            msg: "Terjadi kesalahan saat mencoba menyimpan data X("
                          );
                        }
                      });
                    }, 
                    title: "Simpan",
                    color: Colors.white,
                    bgColor: KColors.backgroundPrimary,
                  )
                ],
              ),
            ),
          ),
        );
      }
    );
  }

  // Widgets
  List<DropdownMenuItem<SQLModelCategory>>  dropdownListKategori(BuildContext context){
    return listKategoriPemasukan.map(
      (e) => ItemKategori(
        onDeleted:(){
          
        }, 
        context: context, 
        data: e, 
        isLongPressEvent: e.id != 0
      ).getWidget()
    ).toList();
  }
  List<DropdownMenuItem<SQLModelWallet>>    dropDownListWallet(BuildContext context){
    return listWallet.map((e){
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
    }).toList();
  }
 
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
      padding: const EdgeInsets.only(right: 10),
      child: KButton(
        onTap: (){
          updateData(context);
        }, 
        title: "Update", 
        color: Colors.white,
        bgColor: KColors.fontPrimaryBlack,
        icon: const Icon(CupertinoIcons.upload_circle, color: Colors.white,),
      ),
    );
  }
  KWidget         buttonSimpan        (BuildContext context, Size size){
    return
    KButton(
      onTap: (){
        simpanData(context, size);
      },
      title: "Simpan", 
      icon: const Icon(Icons.save, color: Colors.white,),
      color: Colors.white,
      bgColor: Colors.green,
    );
  }
  KFormWidget     dropDownKategori    (BuildContext context){
    if (widget.isWithData == true){
      for (var kategori in listKategoriPemasukan) {
        if (kategori.id == widget.theDataIfIsWithData?.id_kategori){
          widget.data.kategoriTerpilih = kategori;
          break;
        }
      }
    } else if (refresh == true){
      for (var kategori in listKategoriPemasukan) {
        if (kategori.id == widget.data.kategoriTerpilih?.id){
          widget.data.kategoriTerpilih = kategori;
          break;
        }
      }
      refresh = false;
    } else {
      widget.data.kategoriTerpilih = listKategoriPemasukan[0];
    }
    return KDropdownMenu(
      items: dropdownListKategori(context), 
      onChanged: (val){
        if (val?.id == 0){
          tambahKategoriBaru(context);
        } else {
          widget.data.kategoriTerpilih = val;
        }
      }, 
      value: widget.data.kategoriTerpilih, 
      labelText: "Kategori",
    ).getWidget();
 }
  KFormWidget     dropDownMenuWallet  (BuildContext context){
    if (widget.isWithData == true){
      for (var wallet in listWallet) {
        if (wallet.id == widget.theDataIfIsWithData?.id_wallet){
          widget.data.walletTerpilih = wallet;
          break;
        }
      }
    }
    else {
      widget.data.walletTerpilih = listWallet[0];
    }
    return KDropdownMenu<SQLModelWallet>(
      items: dropDownListWallet(context), 
      onChanged: (val){widget.data.walletTerpilih = val;}, 
      value: widget.data.walletTerpilih!, 
      labelText: "Wallet"
    ).getWidget();
  }
  KFormWidget     fieldJudul          (){
    return KTextField(
      fieldController: controllerJudul, 
      fieldName: "Judul", 
      icon: Icons.title_sharp,
      prefixIconColor: KColors.fontPrimaryBlack  );
  }
  KFormWidget     fieldJumlah         (){
    return KTextField(
      fieldController: controllerJumlah, 
      fieldName: "Jumlah", 
      icon: Icons.attach_money,
      keyboardType: TextInputType.number,
      prefixIconColor: KColors.fontPrimaryBlack);
  }
  KFormWidget     fieldDeskripsi      () {
    return TextFormField(
      controller: controllerDeskripsi,
      maxLines: 5, // Sesuaikan dengan jumlah baris yang diinginkan
      decoration: const InputDecoration(
        label: Text("Deskripsi"),
        border: OutlineInputBorder()
      ),
    );
  }
  KFormWidget     fieldTanggal        (BuildContext context, Size size){
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: 240,
          child: KTextField(
            fieldController: controllerTanggal, 
            fieldName: "Tanggal", 
            readOnly: true,
            prefixIconColor: KColors.fontPrimaryBlack,
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
    );
  }
  KFormWidget     fieldJam            (BuildContext context, Size size){
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: 125,
          child: KTextField(
            fieldController: controllerWaktu, 
            fieldName: "Jam", 
            readOnly: true,
            prefixIconColor: KColors.fontPrimaryBlack,
            icon: Icons.alarm,
            onTap: () async {
              jamPengeluaran = await tampilkanTimePicker(context: context, waktu: jamPengeluaran);
              controllerWaktu.text = formatWaktu(jamPengeluaran);
            },
          ),
        ),
      ],
    );
  }
  KApplicationBar appBar              (BuildContext context){
    return KAppBar(
      backgroundColor: Colors.white, 
      title: widget.isWithData == true ? "Detail Pemasukan" : "Pemasukan Baru", 
      fontColor: KColors.fontPrimaryBlack,
      action: widget.isWithData == true? buttonAction(context) : null
    ).getWidget();
  }

  Widget buildBody(BuildContext context){
    final size = MediaQuery.sizeOf(context);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
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
            dropDownMenuWallet(context),
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
      ),
    );
  }
  Widget waitingBody(){
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  @override
  Widget build(BuildContext context) {
    controllerTanggal.text = formatTanggal(tanggalPengeluaran);
    controllerWaktu.text = formatWaktu(jamPengeluaran);
    controllerInfoRating.text = SQLModelExpense.infoRating(ratingPengeluaran);
    isWithDataCheck();
    
    return Scaffold(
      appBar: appBar(context),
      backgroundColor: Colors.white,
      body: KFutureBuilder.build(
        future: updateDataWalletDanKategori(), 
        whenError: const Center(child: Text("Something wrong..."),), 
        whenWaiting: waitingBody(),
        whenSuccess: (value) => buildBody(context))
    );
  }
}