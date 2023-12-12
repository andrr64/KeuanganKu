import 'package:flutter/material.dart';
import 'package:keuanganku/app/app_colors.dart';
import 'package:keuanganku/app/reusable%20widgets/heading_text/heading_text.dart';
import 'package:keuanganku/app/reusable%20widgets/k_button/k_button.dart';
import 'package:keuanganku/app/reusable%20widgets/k_textfield/ktext_field.dart';
import 'package:keuanganku/app/snack_bar.dart';
import 'package:keuanganku/database/helper/data_pemasukan.dart';
import 'package:keuanganku/database/helper/data_wallet.dart';
import 'package:keuanganku/database/model/data_pemasukan.dart';
import 'package:keuanganku/database/model/data_wallet.dart';
import 'package:keuanganku/enum/status.dart';
import 'package:keuanganku/main.dart';
import 'package:keuanganku/util/dummy.dart';
import 'package:keuanganku/util/font_style.dart';

class FormWallet extends StatefulWidget {
  const FormWallet({super.key, required this.onFinished});
  final VoidCallback onFinished;

  @override
  State<FormWallet> createState() => _FormWalletState();
}

class _FormWalletState extends State<FormWallet> {
  TextEditingController controllerFieldJudul = TextEditingController();
  TextEditingController controllerFieldJumlahUang = TextEditingController();
  String tipeWallet = "Wallet";

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    
    // Widgets
    Widget heading(){
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25,),
            child: HeadingText().h1("+ Wallet Baru"),
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
      return 
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: KTextField(
          fieldController: controllerFieldJudul , 
          fieldName: "Judul", 
          icon: Icons.title,
          prefixIconColor: ApplicationColors.primary
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
          prefixIconColor: ApplicationColors.primary
        ),
      );
    }
    Widget buttonSimpan(){
      return
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: KButton(
          onTap: () {
            Navigator.pop(context);
            SQLModelWallet newWallet = SQLModelWallet(id: -1, tipe: tipeWallet, judul: controllerFieldJudul.text);
            SQLHelperWallet().insert(newWallet, db.database).then((int idWallet) {
              if (idWallet != -1) {
                SQLModelPemasukan pemasukan = SQLModelPemasukan(
                  id: -1, 
                  id_wallet: idWallet, 
                  id_kategori: -1, 
                  judul: "Wallet Baru - ${newWallet.judul}", 
                  deskripsi: "Inisialisasi Wallet", 
                  nilai: double.parse(controllerFieldJumlahUang.text), 
                  waktu: DateTime.now()
                );
                SQLHelperPemasukan().insert(pemasukan, db.database);
                showSnackBar(context, jenisPesan: Pesan.Success, msg: "Data berhasil disimpan");
              } else {
                showSnackBar(context, jenisPesan: Pesan.Error, msg: "Terdapat kesalahan ...");
              }
            }).catchError((error) {
                showSnackBar(context, jenisPesan: Pesan.Error, msg: error.toString());
            });
            widget.onFinished();
          },
          title: "Simpan", 
          icon: const Icon(Icons.save, color: Colors.white,),
          color: Colors.white,
          bgColor: ApplicationColors.primary,
        ),
      );
    }
    Widget dropDownTipeWallet() {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: DropdownButtonFormField<String>(
          items: SQLModelWallet.tipeWallet.map((String item) {
            return DropdownMenuItem(
              value: item,
              child: Text(item, style: kFontStyle(fontSize: 14, family: "QuickSand_Medium")),
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
          decoration: InputDecoration(
            labelText: "Tipe Wallet",
            border: const OutlineInputBorder(),
            prefixIcon: Icon(tipeWallet == "Wallet"? Icons.wallet: Icons.account_balance),
          ),
        ),
      );
    }

    return Container(
      width: size.width * 0.90,
      height: size.height * 0.95,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          dummyPadding(height: 25),
          heading(),
          dummyPadding(height: 25),
          fieldJudul(),
          dummyPadding(height: 25),
          fieldJumlahUang(),
          dummyPadding(height: 25),
          dropDownTipeWallet(),
          dummyPadding(height: 25),
          Row(
            children: [
              buttonSimpan(),
              KButton(
                onTap: (){
                  controllerFieldJudul.text = "";
                  controllerFieldJumlahUang.text = "";
                }, 
                color: Colors.white, 
                bgColor: Colors.red, 
                title: "Clear", 
                icon: const Icon(Icons.clear, color: Colors.white)),
            ],
          )
        ],
      ),
    );
  }
}