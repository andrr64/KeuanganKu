// ignore_for_file: use_build_context_synchronously, constant_identifier_names

import 'package:flutter/material.dart';
import 'package:keuanganku/app/app_colors.dart';
import 'package:keuanganku/app/snack_bar.dart';
import 'package:keuanganku/app/widgets/k_app_bar/k_app_bar.dart';
import 'package:keuanganku/app/widgets/k_button/k_button.dart';
import 'package:keuanganku/app/widgets/k_dialog/k_dialog_info.dart';
import 'package:keuanganku/app/widgets/k_dropdown_menu/k_drodpown_menu.dart';
import 'package:keuanganku/app/widgets/k_textfield/ktext_field.dart';
import 'package:keuanganku/database/helper/income_category.dart';
import 'package:keuanganku/database/helper/expense_limiter.dart';
import 'package:keuanganku/database/model/category.dart';
import 'package:keuanganku/database/model/expense_limiter.dart';
import 'package:keuanganku/enum/status.dart';
import 'package:keuanganku/k_typedef.dart';
import 'package:keuanganku/main.dart';
import 'package:keuanganku/util/dummy.dart';
import 'package:keuanganku/util/error.dart';
import 'package:keuanganku/util/font_style.dart';

enum FormError {
  BellowOrEqualToZero,
  NotDouble
}

class FormExpenseLimiter extends StatefulWidget {
  const FormExpenseLimiter({
    super.key, 
    required this.listCategory,
    required this.callback,
    this.expenseLimiter,
    this.onDataUpdated,
    this.onDataDeleted
  });
  
  final VoidCallback callback;
  final SQLModelExpenseLimiter? expenseLimiter;
  final List<SQLModelCategory> listCategory;
  final Function()? onDataUpdated;
  final Function()? onDataDeleted;

  @override
  State<FormExpenseLimiter> createState() => _FormExpenseLimiterState();
}

class _FormExpenseLimiterState extends State<FormExpenseLimiter> {
  TextEditingController controllerDeskripsi = TextEditingController();
  TextEditingController controllerNilai = TextEditingController();
  SQLModelCategory? kategoriTerpilih; 

  KInputValidator     validatorData           (SQLModelExpenseLimiter? withData){
    try {
      double nilaiLimiter = double.parse(controllerNilai.text);
      if (nilaiLimiter <= 0){
        return FormError.BellowOrEqualToZero;
      }
      return Condition.OK;
    } catch(exception){
      return FormError.NotDouble;
    }
  }
  KValidator          validatorHandler        (dynamic validatorResult, BuildContext context){
    if (validatorResult == FormError.BellowOrEqualToZero){
      KDialogInfo(
        title: "Error", 
        info: "Masukan angka lebih dari 0", 
        jenisPesan: Pesan.Error
      ).tampilkanDialog(context);
    }
  }
  
  Future<KBussinesProcess>  updateDataKeDatabase      ({required SQLModelExpenseLimiter data}) async{
    if (await SQLHelperExpenseLimiter().update(data, db: db.database) != -1){
      return Condition.OK;
    }
    return SQLError.Update;
  }
  KBussinesProcess          updateData                (BuildContext context){
    dynamic validatorResult = validatorData(widget.expenseLimiter);
    if (validatorResult == Condition.OK){
      widget.expenseLimiter?.deskripsi = controllerDeskripsi.text;
      widget.expenseLimiter?.nilai = double.parse(controllerNilai.text);
      widget.expenseLimiter?.kategori = kategoriTerpilih!;
      updateDataKeDatabase(data: widget.expenseLimiter!,).then((outputProses){
        if (outputProses == Condition.OK){
          tampilkanSnackBar(context, jenisPesan: Pesan.Success, msg: "Data berhasil diperbaharui");
          if (widget.onDataUpdated != null){
            widget.onDataUpdated!();
          }
        } else {
          KDialogInfo(
            title: "Gagal menyimpan", 
            info: "Terdapat kesalahan saat menyimpan data", 
            jenisPesan: Pesan.Error
          ).tampilkanDialog(context);
        }
      });
    }
    else {
      validatorHandler(validatorResult, context);
    }
  }

  Future<KBussinesProcess>  hapusDataKeDatabase       (SQLModelExpenseLimiter data) async {
    if (await SQLHelperExpenseLimiter().delete(widget.expenseLimiter!.id, db: db.database) != -1){
      return Condition.OK;
    }
    return SQLError.Delete; 
  }
  KBussinesProcess          hapusData                 (BuildContext context){
    KDialogInfo(
      title: "Anda yakin?", 
      info: "Data yang dihapus tidak akan bisa dikembalikan", 
      jenisPesan: Pesan.Konfirmasi,
      okTitle: "Oke hapus aja",
      cancelTitle: "Gak jadi",
      onOk: (){
        hapusDataKeDatabase(widget.expenseLimiter!).then((value){
          if (value == Condition.OK){
            tampilkanSnackBar(context, jenisPesan: Pesan.Success, msg: "Data berhasil dihapus");
            if (widget.onDataDeleted != null){
              widget.onDataDeleted!();
            }
            Navigator.pop(context);
            
          } else {
            KDialogInfo(
              title: "Gagal", 
              info: "Terdapat kesalahan ketika menghapus data dari database", 
              jenisPesan: Pesan.Error
            ).tampilkanDialog(context);
          }
        });
      }
    ).tampilkanDialog(context);
  }

  Widget          dropDownKategori        (BuildContext context) {
    List<DropdownMenuItem<SQLModelCategory>> items (){
      List<DropdownMenuItem<SQLModelCategory>> listItem = widget.listCategory.map((kategori){
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
    if (widget.expenseLimiter  != null){
      for (var ktg in widget.listCategory) {
        if (ktg.id == widget.expenseLimiter!.kategori.id){
          kategoriTerpilih = ktg;
          break;
        }
        kategoriTerpilih = null;
      }
    }
    kategoriTerpilih ??= widget.listCategory[0];
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
          kategoriTerpilih = val;
        }, 
        value: kategoriTerpilih!, 
        labelText: "Kategori",
      ).getWidget(),
    );
  }
  Widget          buttonAction            (BuildContext context) {
    KEventHandler simpanData        () async {
      void validator(){
        try {
          double.tryParse(controllerNilai.text);
        }  catch (invalidDouble){
          KDialogInfo(title: "error", info: "masukan angka..", jenisPesan: Pesan.Error);
        }
      }
      
      validator();
      
      SQLModelExpenseLimiter limiterBaru = SQLModelExpenseLimiter(
        id: -1, 
        deskripsi: controllerDeskripsi.text, 
        nilai: double.parse(controllerNilai.text), 
        waktu: "Mingguan", 
        kategori: kategoriTerpilih!
      );
      int exitCode = await SQLHelperExpenseLimiter().insert(limiterBaru, db: db.database);
      if (exitCode != -1){
        widget.callback();
        Navigator.pop(context);
        String pesan = "Data berhasil disimpan";
        tampilkanSnackBar(context, jenisPesan: Pesan.Success, msg: pesan);
      } else {
        String pesan = "Sadly,something wrong...";
        tampilkanSnackBar(context, jenisPesan: Pesan.Error, msg: pesan);
      }
    }
    List<Widget>  withDataButton    (){
      return [
        KButton(
          onTap: () => updateData(context),
          title: "Update", 
          color: Colors.white,
          bgColor: KColors.backgroundPrimary,
        ),
        dummyWidth(10),
        KButton(
          onTap: () => hapusData(context), 
          title: "Hapus",
          color: Colors.white,
          bgColor: Colors.red,
        )
      ];
    }
    List<Widget>  withoutDataButton (){
      return [
        KButton(
          onTap: simpanData, 
          title: "Simpan", 
          icon: const Icon(Icons.save, color: Colors.white,),
          color: Colors.white,
          bgColor: Colors.green,
        )
      ];
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widget.expenseLimiter != null? withDataButton() : withoutDataButton()
    );
  }
  void            cekApakahDenganLimiter  (){
    if (widget.expenseLimiter != null){
      kategoriTerpilih = widget.expenseLimiter?.kategori;
      controllerDeskripsi.text = widget.expenseLimiter!.deskripsi;
      controllerNilai.text = widget.expenseLimiter!.nilai.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    cekApakahDenganLimiter();
    return Scaffold(
      appBar: KAppBar(title: "Limiter Baru", fontColor: KColors.fontPrimaryBlack, backgroundColor: Colors.white).getWidget(),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 25,),
              TextFormField(
                maxLines: 5,
                controller: controllerDeskripsi,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  label: Text("Deskripsi"),
                  border: OutlineInputBorder()
                ),
              ),
              dummyHeight(height: 15),
              KTextField(
                fieldController: controllerNilai, 
                fieldName: "Jumlah",
                icon: Icons.attach_money, 
                prefixIconColor: KColors.fontPrimaryBlack,
                keyboardType: TextInputType.number,
              ),
              dummyHeight(height: 15),
              dropDownKategori(context),
              dummyHeight(height: 15),
              buttonAction(context)
            ],
          ),
        ),
      ),
    );
  }
}