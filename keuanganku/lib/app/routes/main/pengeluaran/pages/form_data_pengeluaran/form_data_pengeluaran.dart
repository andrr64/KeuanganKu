// ignore_for_file: constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keuanganku/app/app_colors.dart';
import 'package:keuanganku/app/widgets/k_app_bar/k_app_bar.dart';
import 'package:keuanganku/app/widgets/k_date_picker/k_date_picker.dart';
import 'package:keuanganku/app/widgets/k_button/k_button.dart';
import 'package:keuanganku/app/widgets/k_dialog/k_dialog_info.dart';
import 'package:keuanganku/app/widgets/k_dropdown_menu/k_drodpown_menu.dart';
import 'package:keuanganku/app/widgets/k_future_builder/k_future.dart';
import 'package:keuanganku/app/widgets/k_textfield/ktext_field.dart';
import 'package:keuanganku/app/widgets/k_time_picker/k_time_picker.dart';
import 'package:keuanganku/app/snack_bar.dart';
import 'package:keuanganku/database/helper/expense.dart';
import 'package:keuanganku/database/helper/expense_category.dart';
import 'package:keuanganku/database/model/category.dart';
import 'package:keuanganku/database/model/const_value.dart';
import 'package:keuanganku/database/model/expense.dart';
import 'package:keuanganku/database/model/wallet.dart';
import 'package:keuanganku/enum/status.dart';
import 'package:keuanganku/k_typedef.dart';
import 'package:keuanganku/main.dart';
import 'package:keuanganku/util/date_util.dart';
import 'package:keuanganku/util/dummy.dart';
import 'package:keuanganku/util/error.dart';
import 'package:keuanganku/util/font_style.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:keuanganku/util/get_currency.dart';

enum FormError {
  UangKurang,
  JudulKosong
}

class Data {
  SQLModelWallet? walletTerpilih;  
  SQLModelCategory? kategoriTerplilih;
}

class FormDataPengeluaran extends StatefulWidget {
  FormDataPengeluaran({
    super.key, 
    required this.listWallet, 
    required this.listKategori, 
    required this.callback,
    this.pengeluaran,
    this.withData,
    this.walletAndKategori
  });
  final List<SQLModelWallet> listWallet;
  final List<SQLModelCategory> listKategori;
  final Data data = Data();
  final VoidCallback callback;
  final SQLModelExpense? pengeluaran;
  final bool? withData;
  final Map<String,dynamic>? walletAndKategori;

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
  double ratingPengeluaran = 3;

  // Events
  Future<dynamic> validatorDataBaru         (BuildContext context) async {
    double nilaiPengeluaran = 0;
    if (controllerJudul.text.isEmpty){
      return FormError.JudulKosong;
    }
    try{
      double totalUangWalletFree = await widget.data.walletTerpilih!.totalUang();
      nilaiPengeluaran = double.parse(controllerJumlah.text); 
      if (nilaiPengeluaran > MAX_VALUE){
        return ValidatorError.OverflowNumber;
      } else if (nilaiPengeluaran > totalUangWalletFree){
        return ValidatorError.IfCondition;
      } else if (nilaiPengeluaran <= 0){
        return ValidatorError.LessThanOrEqualZero;
      } 
    } catch(invalidDouble){
      return ValidatorError.InvalidInput;
    }
    return Condition.OK;
  }
  KValidator      validatorDataBaruHandler  (BuildContext context, dynamic value){
    if (value == ValidatorError.InvalidInput){
        KDialogInfo(
          title: "Invalid", 
          info: "Masukan sebuah angka", 
          jenisPesan: Pesan.Error
        ).tampilkanDialog(context);
      } else if (value == ValidatorError.IfCondition){
        KDialogInfo(
          title: "Uang Kurang", 
          info: "Sayangnya uang di wallet anda tidak cukup (miskin)", 
          jenisPesan: Pesan.Warning
        ).tampilkanDialog(context);
      } else if (value == ValidatorError.LessThanOrEqualZero){
        KDialogInfo(
          title: "Invalid", 
          info: "Masukan angka dengan benar", 
          jenisPesan: Pesan.Error).tampilkanDialog(context);
      } else if(value == ValidatorError.OverflowNumber){
        KDialogInfo(
          title: "Overflow Number",
          info: "Sayangnya aplikasi ini hanya bisa memproses nilai maksimal ${formatCurrency(MAX_VALUE)}",
          jenisPesan: Pesan.Error
        ).tampilkanDialog(context);
      } else if (value is SQLError){
        tampilkanSnackBar(context, jenisPesan: Pesan.Error, msg: "Terdapat kesalahan saat menyimpan data");
      } else if (value == Condition.OK){
        tampilkanSnackBar(context, jenisPesan: Pesan.Success, msg: "Data berhasil disimpan");
        Navigator.pop(context);
        widget.callback();
      } else if (value == FormError.JudulKosong){
        KDialogInfo(
          title: "Tidak Lengkap", 
          info: "Judul tidak boleh kosong", 
          jenisPesan: Pesan.Error
        ).tampilkanDialog(context);
      }else {
        KDialogInfo(
          title: "Exception", 
          info: "Terdapat kesalahan :(", 
          jenisPesan: Pesan.Error
        ).tampilkanDialog(context);
      }
  }
  KEventHandler   simpanData                (BuildContext context, Size size) {
    Future memprosesData() async{
      dynamic hasilValidator = await validatorDataBaru(context);
      if (hasilValidator != Condition.OK){
        return hasilValidator; 
      }
      double nilaiPengeluaran = 0;
      try {
        nilaiPengeluaran = double.parse(controllerJumlah.text);
        double totalUangPadaWallet = await widget.data.walletTerpilih!.totalUang();
        if (nilaiPengeluaran > MAX_VALUE || nilaiPengeluaran <= 0){
          return ValidatorError.OverflowNumber;
        }
        else if (nilaiPengeluaran > totalUangPadaWallet){
          return ValidatorError.IfCondition;
        }
      }  catch(formatException){
        return ValidatorError.InvalidInput;
      }
      SQLModelExpense data = SQLModelExpense(
        id: -1, 
        id_wallet: widget.data.walletTerpilih!.id, 
        id_kategori: widget.data.kategoriTerplilih!.id, 
        judul: controllerJudul.text, 
        deskripsi: controllerDeskripsi.text, 
        nilai: nilaiPengeluaran, 
        rating: ratingPengeluaran, 
        waktu: combineDtTod(tanggalPengeluaran, jamPengeluaran));
      if (await SQLHelperExpense().insert(data, db: db.database) == -1){
        return SQLError.Insert;
      }
      return Condition.OK;
    }
    memprosesData().then((value) => validatorDataBaruHandler(context, value));
  }

  Future<dynamic> validatorUpdateData       (BuildContext context) async {
    try{
      double nilaiPengeluaranBaru = double.parse(controllerJumlah.text); 
      double totalUangPadaWallet = await widget.data.walletTerpilih!.totalUang() + widget.pengeluaran!.nilai;
      if (nilaiPengeluaranBaru > MAX_VALUE){
        return ValidatorError.OverflowNumber;
      }
      else if (nilaiPengeluaranBaru > totalUangPadaWallet){
        return FormError.UangKurang;
      }
      else if (nilaiPengeluaranBaru <= 0){
        return ValidatorError.LessThanOrEqualZero;
      }
    } catch(numberException){
      return ValidatorError.InvalidInput;
    }
    return Condition.OK;
  }
  KEventHandler   validatorUpdateDataHandler(BuildContext context, dynamic value){
    if (value == FormError.UangKurang){
      KDialogInfo(
        title: "Uang Kurang", 
        info: "Sayangnya uang di wallet anda tidak cukup (miskin)", 
        jenisPesan: Pesan.Warning
      ).tampilkanDialog(context);
    } else if (value == ValidatorError.OverflowNumber){
      KDialogInfo(
        title: "Melewati Batas", 
        info: "Masukan angka kurang dari ${formatCurrency(MAX_VALUE.toDouble())}", 
        jenisPesan: Pesan.Error
      ).tampilkanDialog(context);
    } else if (value is SQLError){
      tampilkanSnackBar(context, jenisPesan: Pesan.Error, msg: "Terdapat kesalahan pada SQL saat memperbaharui data");
    } else if (value == Condition.OK){
      tampilkanSnackBar(context, jenisPesan: Pesan.Success, msg: "Data berhasil disimpan");
      widget.callback();
    } else if (value == ValidatorError.LessThanOrEqualZero){
      KDialogInfo(
          title: "Invalid", 
          info: "Nilai pengeluaran harus lebih dari 0 !!", 
          jenisPesan: Pesan.Error).tampilkanDialog(context);
    } else {
      KDialogInfo(
        title: "Exception", 
        info: "Sayangnya terdapat kesalahan :(", 
        jenisPesan: Pesan.Error
      ).tampilkanDialog(context);
    }
  }
  KEventHandler   updateData                (BuildContext context) {
    Future<dynamic> memprosesData() async {
      dynamic validatorResult = await validatorUpdateData(context);
      if (validatorResult != Condition.OK){
        return validatorResult;
      }
      SQLModelExpense dataPengeluaranbaru = SQLModelExpense(
        id: widget.pengeluaran!.id, 
        id_wallet: widget.data.walletTerpilih!.id, 
        id_kategori: widget.data.kategoriTerplilih!.id, 
        judul: controllerJudul.text, 
        deskripsi: controllerDeskripsi.text, 
        nilai: double.parse(controllerJumlah.text), 
        rating: ratingPengeluaran, 
        waktu: combineDtTod(tanggalPengeluaran, jamPengeluaran));
      if (await SQLHelperExpense().update(dataPengeluaranbaru, db: db.database) != -1){
        return Condition.OK;
      }
      return SQLError.Update;
    }
    memprosesData().then((value){
      validatorUpdateDataHandler(context, value);
    });
  }
  
  KEventHandler   deleteData                (BuildContext context) {
    Future<int> memprosesData() async {
      return await SQLHelperExpense().delete(widget.pengeluaran!.id, db: db.database);
    }
    memprosesData().then((value){
      if (value != -1){
        tampilkanSnackBar(context, jenisPesan: Pesan.Konfirmasi, msg: "data berhasil dihapus"); 
        widget.callback();
      } else {
        tampilkanSnackBar(context, jenisPesan: Pesan.Error, msg: "something wrong...");
      }
    });
  }
  KEventHandler   isWithDataCheck           () {
    if (widget.withData == true){
      controllerJudul.text = widget.pengeluaran!.judul;
      controllerDeskripsi.text = widget.pengeluaran!.deskripsi;
      controllerTanggal.text = formatTanggal(widget.pengeluaran!.waktu);
      controllerWaktu.text = formatWaktu(TimeOfDay(hour: widget.pengeluaran!.waktu.hour, minute: widget.pengeluaran!.waktu.minute));
      controllerJumlah.text = widget.pengeluaran!.nilai.toString();
      controllerInfoRating.text = SQLModelExpense.infoRating(widget.pengeluaran!.rating);
      ratingPengeluaran = widget.pengeluaran!.rating;
    }
    else {
      controllerTanggal.text = formatTanggal(tanggalPengeluaran);
      controllerWaktu.text = formatWaktu(jamPengeluaran);
      controllerInfoRating.text = SQLModelExpense.infoRating(ratingPengeluaran);
      ratingPengeluaran = 3;
    }
  }

  // Widgets
  KFormWidget   fieldJudul            () {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: KTextField(
        fieldController: controllerJudul, 
        fieldName: "Judul", 
        icon: Icons.title_sharp,
        prefixIconColor: KColors.fontPrimaryBlack  ),
    );
  }
  KFormWidget   fieldJumlah           () {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: KTextField(
        fieldController: controllerJumlah, 
        fieldName: "Jumlah", 
        icon: Icons.attach_money,
        keyboardType: TextInputType.number,
        prefixIconColor: KColors.fontPrimaryBlack),
    );
  }
  KFormWidget   fieldDeskripsi        () {
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
  KFormWidget   fieldTanggal          (BuildContext context, Size size) {
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
      ),
    );
  }
  KFormWidget   fieldJam              (BuildContext context, Size size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: size.width * 0.3,
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
  KFormWidget   dropDownMenuWallet    () {
    if (widget.withData == true){
      for (var wallet  in widget.listWallet) {
        if (wallet.id == widget.walletAndKategori!['wallet'].id){
          widget.data.walletTerpilih = wallet;
          break;
        }
        widget.data.walletTerpilih = null;
      }
    } else {
      widget.data.walletTerpilih ??= widget.listWallet[0];
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
                KFutureBuilder.build(
                  future: e.totalUang(), 
                  whenError: Text(e.judul, style: kFontStyle(fontSize: 15, family: "QuickSand_Medium"),), 
                  whenSuccess: (value){
                    return Text("${e.judul} (${formatCurrency(value)})", style: kFontStyle(fontSize: 15, family: "QuickSand_Medium"),);
                  })
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
  KFormWidget   dropDownKategori      (BuildContext context) {
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
    if (widget.withData == true){
      for (var ktg in widget.listKategori) {
        if (ktg.id == widget.walletAndKategori!['kategori'].id){
          widget.data.kategoriTerplilih = ktg;
          break;
        }
        widget.data.kategoriTerplilih = null;
      }
    }
    widget.data.kategoriTerplilih ??= widget.listKategori[0];
    
    return IntrinsicWidth(
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
                          prefixIconColor: KColors.fontPrimaryBlack,
                          icon: Icons.title,
                        ),
                        dummyHeight(height: 15),
                        KButton(
                          onTap: () {
                            if (controllerNamaKategori.text.isEmpty){
                              return;
                            }
                            SQLHelperExpenseCategory().insert(
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
          widget.data.kategoriTerplilih = val;
        }, 
        value: widget.data.kategoriTerplilih!, 
        labelText: "Kategori",
      ).getWidget(),
    );
  }
  KFormWidget   buttonClear           () {
    return KButton(
      onTap: (){
        controllerJudul.text = "";
        controllerJumlah.text = "";
        widget.data.walletTerpilih = widget.listWallet[0];
        setState(() {});
      }, 
      color: Colors.white, 
      bgColor: Colors.red, 
      title: "Bersihkan", 
      icon: const Icon(Icons.clear, color: Colors.white));
    }
  KFormWidget   buttonSimpan          (BuildContext context, Size size) {
    return
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: KButton(
        onTap: () {
          simpanData(context, size);
        },
        title: "Simpan", 
        icon: const Icon(Icons.save, color: Colors.white,),
        color: Colors.white,
        bgColor: Colors.green,
      ),
    );
  }
  KFormWidget   buttonUpdate          (BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 10),
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
  KFormWidget   ratingBar             (){
    return Padding(
      padding: const EdgeInsets.only(left: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: 0.35 * MediaQuery.sizeOf(context).width,
            child: KTextField(
              fieldController: controllerInfoRating,
              fieldName: "Rating",
              prefixIconColor: KColors.fontPrimaryBlack,
              icon: Icons.star,
              readOnly: true,
            ),
          ),
          const SizedBox(width: 10,),
          RatingBar.builder(
            initialRating: ratingPengeluaran,
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
              controllerInfoRating.text = SQLModelExpense.infoRating(rating);
            },
          ),
        ],
      ),
    );
  }
  KApplicationBar appBar              () {
    return KAppBar(
        backgroundColor: Colors.white,
        title: widget.withData == true? "Detail Pengeluaran" : "Pengeluaran Baru",
        fontColor: KColors.fontPrimaryBlack,
        action: rightLeadingAction(context),
        leading: FilledButton(
          onPressed: (){
            Navigator.pop(context);
          }, 
          style: FilledButton.styleFrom(
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.black26
          ),
          child: const Icon(Icons.arrow_back_ios, color: KColors.fontPrimaryBlack,)
        )
    ).getWidget();
  }
  List<Widget>    buttonAction        (BuildContext context, size) {
    if (widget.withData == true){
      return [
        buttonUpdate(context)
      ];
    } else {
      return [
        buttonSimpan(context, size),
        buttonClear(),
      ];
    }
  }
  List<Widget>?   rightLeadingAction  (BuildContext context) {
    if (widget.withData == true){
      return [
          GestureDetector(
            onTap: (){
              KDialogInfo(
                title: "Anda yakin?", 
                info: "Data tidak bisa dikembalikan dan uang akan dikembalikan ke wallet", 
                onOk: () {
                  deleteData(context);
                },
                jenisPesan: Pesan.Konfirmasi,
              ).tampilkanDialog(context);
            },
            child: const Padding(
              padding: EdgeInsets.only(right: 25),
              child: Icon(CupertinoIcons.delete),
            ),
          )
        ];
    } else {
      return null;
    }
  }

  @override 
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    isWithDataCheck();
    const double paddingBottom = 15;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            dummyHeight(height: paddingBottom),
            fieldJudul(),
            dummyHeight(height: paddingBottom),
            fieldJumlah(),
            dummyHeight(height: paddingBottom),
            fieldDeskripsi(),
            dummyHeight(height: paddingBottom),
            dropDownMenuWallet(),
            dummyHeight(height: paddingBottom),
            fieldTanggal(context, size),
            dummyHeight(height: paddingBottom),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  fieldJam(context, size),
                  dropDownKategori(context),
                ],
              ),
            ),
            dummyHeight(height: paddingBottom),
            ratingBar(),
            dummyHeight(height: paddingBottom),
            Row(
              children: buttonAction(context, size),
            ),
            dummyHeight(height: 50)
          ]
        ),
      )
      );
  }
}