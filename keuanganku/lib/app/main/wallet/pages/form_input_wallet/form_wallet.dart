import 'package:flutter/material.dart';
import 'package:keuanganku/app/app_colors.dart';
import 'package:keuanganku/app/reusable%20widgets/heading_text/heading_text.dart';
import 'package:keuanganku/app/reusable%20widgets/k_button/k_button.dart';
import 'package:keuanganku/app/reusable%20widgets/k_textfield/ktext_field.dart';
import 'package:keuanganku/database/helper/data_wallet.dart';
import 'package:keuanganku/database/model/data_wallet.dart';
import 'package:keuanganku/main.dart';
import 'package:keuanganku/util/dummy.dart';

class FormWallet extends StatefulWidget {
  const FormWallet({super.key});

  @override
  State<FormWallet> createState() => _FormWalletState();
}

class _FormWalletState extends State<FormWallet> {
  TextEditingController controllerFieldJudul = TextEditingController();

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
    Widget buttonSimpan(){
      return
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: KButton(
          onTap: () async {
            SQLModelWallet newWallet = SQLModelWallet(id: -1, tipe: "Wallet", judul: controllerFieldJudul.text);
            int exitCode = await SQLHelperWallet().insert(newWallet, db.database);
            if (exitCode != 1){
              // Something wrong
            } else {
              // Everything is good
            }
          }, 
          title: "Simpan", 
          icon: const Icon(Icons.save, color: Colors.white,),
          color: Colors.white,
          bgColor: ApplicationColors.primary,
        ),
      );
    }

    return SizedBox(
      width: size.width * 0.95,
      height: size.height * 0.95,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          dummyPadding(height: 25),
          heading(),
          dummyPadding(height: 25),
          fieldJudul(),
          dummyPadding(height: 25),
          buttonSimpan(),
        ],
      ),
    );
  }
}