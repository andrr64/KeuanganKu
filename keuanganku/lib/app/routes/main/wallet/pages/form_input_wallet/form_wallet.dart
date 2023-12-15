import 'package:flutter/material.dart';
import 'package:keuanganku/app/app_colors.dart';
import 'package:keuanganku/app/reusable_widgets/app_bar/app_bar.dart';
import 'package:keuanganku/app/reusable_widgets/k_button/k_button.dart';
import 'package:keuanganku/app/reusable_widgets/k_dropdown_menu/k_drodpown_menu.dart';
import 'package:keuanganku/app/reusable_widgets/k_textfield/ktext_field.dart';
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
    // Events
    void eventSimpanWallet(){
      if (controllerFieldJudul.text.isEmpty || controllerFieldJumlahUang.text.isEmpty) {
        Navigator.pop(context);
        return;
      }

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
          tampilkanSnackBar(context, jenisPesan: Pesan.Success, msg: "Data berhasil disimpan");
        } else {
          tampilkanSnackBar(context, jenisPesan: Pesan.Error, msg: "Terdapat kesalahan ...");
        }
      }).catchError((error) {
          tampilkanSnackBar(context, jenisPesan: Pesan.Error, msg: error.toString());
      });
      widget.onFinished();
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
          labelText: "Tipe Wallet",
          icon: Icon(tipeWallet == "Wallet"? Icons.wallet: Icons.account_balance),
        ).getWidget()
      );
    }

    return Scaffold(
      appBar: KAppBar(title: "Wallet Baru", fontColor: ApplicationColors.primary).getWidget(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
              buttonClear(),
            ],
          )
        ],
      ),
    );
  }
}