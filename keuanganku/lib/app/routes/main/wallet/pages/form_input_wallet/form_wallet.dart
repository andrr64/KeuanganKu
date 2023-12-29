import 'package:flutter/material.dart';
import 'package:keuanganku/app/app_colors.dart';
import 'package:keuanganku/app/widgets/k_app_bar/k_app_bar.dart';
import 'package:keuanganku/app/widgets/k_button/k_button.dart';
import 'package:keuanganku/app/widgets/k_dropdown_menu/k_drodpown_menu.dart';
import 'package:keuanganku/app/widgets/k_textfield/ktext_field.dart';
import 'package:keuanganku/app/snack_bar.dart';
import 'package:keuanganku/database/helper/income.dart';
import 'package:keuanganku/database/helper/wallet.dart';
import 'package:keuanganku/database/model/income.dart';
import 'package:keuanganku/database/model/wallet.dart';
import 'package:keuanganku/enum/status.dart';
import 'package:keuanganku/main.dart';
import 'package:keuanganku/util/dummy.dart';
import 'package:keuanganku/util/font_style.dart';

class FormWallet extends StatefulWidget {
  const FormWallet({super.key, required this.callback});
  final VoidCallback callback;

  @override
  State<FormWallet> createState() => _FormWalletState();
}

class _FormWalletState extends State<FormWallet> {
  TextEditingController controllerFieldJudul = TextEditingController();
  TextEditingController controllerFieldJumlahUang = TextEditingController();
  String tipeWallet = "Wallet";

  @override
  Widget build(BuildContext context) {
    // Events
    void eventSimpanWallet(){
      if (controllerFieldJudul.text.isEmpty || controllerFieldJumlahUang.text.isEmpty) {
        Navigator.pop(context);
        return;
      }

      SQLModelWallet newWallet = SQLModelWallet(id: -1, tipe: tipeWallet, judul: controllerFieldJudul.text);
      SQLHelperWallet().insert(newWallet, db.database).then((int idWallet) {
        if (idWallet != -1) {
          SQLModelIncome pemasukan = SQLModelIncome(
            id: -1, 
            id_wallet: idWallet, 
            id_kategori: 1, 
            judul: "Wallet Baru - ${newWallet.judul}", 
            deskripsi: "Inisialisasi Wallet", 
            nilai: double.parse(controllerFieldJumlahUang.text), 
            waktu: DateTime.now()
          );
          SQLHelperIncome().insert(pemasukan, db.database);
          tampilkanSnackBar(context, jenisPesan: Pesan.Success, msg: "Data berhasil disimpan");
        } else {
          tampilkanSnackBar(context, jenisPesan: Pesan.Error, msg: "Terdapat kesalahan ...");
        }
      }).catchError((error) {
          tampilkanSnackBar(context, jenisPesan: Pesan.Error, msg: error.toString());
      });
      widget.callback();
    }

    Widget fieldJudul(){
      return 
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: KTextField(
          fieldController: controllerFieldJudul , 
          fieldName: "Judul", 
          icon: Icons.title,
          prefixIconColor: KColors.fontPrimaryBlack
        ),
      );
    }
    Widget fieldJumlahUang(){
      return
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: KTextField(
          fieldController: controllerFieldJumlahUang , 
          fieldName: "Jumlah Uang", 
          icon: Icons.attach_money,
          keyboardType: TextInputType.number,
          prefixIconColor: KColors.fontPrimaryBlack
        ),
      );
    }
    Widget buttonSimpan(){
      return
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: KButton(
          onTap: eventSimpanWallet,
          title: "Simpan", 
          icon: const Icon(Icons.save, color: Colors.white,),
          color: Colors.white,
          bgColor: Colors.green,
        ),
      );
    }
    Widget buttonClear(){
      return KButton(
        onTap: (){
          controllerFieldJudul.text = "";
          controllerFieldJumlahUang.text = "";
        }, 
        color: Colors.white, 
        bgColor: Colors.red, 
        title: "Bersihkan", 
        icon: const Icon(Icons.clear, color: Colors.white));
    }
    Widget dropDownTipeWallet() {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: KDropdownMenu<String>(
          items: SQLModelWallet.tipeWallet.map((String item) {
            return DropdownMenuItem(
              value: item,
              child: Row(
                children: [
                  Icon(SQLModelWallet.geIconData(item)),
                  const SizedBox(width: 5,),
                  Text(item, style: kFontStyle(fontSize: 14, family: "QuickSand_Medium"))
                ],
              ),
            );
          }).toList(), 
          onChanged: (String? value) {
            if (value != null) {
              setState(() {
                tipeWallet = value;
              });
            }
          }, 
          value: tipeWallet, 
          labelText: "Tipe Wallet",
        ).getWidget()
      );
    }

    return Scaffold(
      appBar: KAppBar(title: "Wallet Baru", fontColor: KColors.fontPrimaryBlack).getWidget(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            dummyHeight(height: 25),
            fieldJudul(),
            dummyHeight(height: 25),
            fieldJumlahUang(),
            dummyHeight(height: 25),
            dropDownTipeWallet(),
            dummyHeight(height: 25),
            Row(
              children: [
                buttonSimpan(),
                buttonClear(),
              ],
            )
          ],
        ),
      ),
    );
  }
}