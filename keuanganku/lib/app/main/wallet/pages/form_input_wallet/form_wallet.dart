import 'package:flutter/material.dart';
import 'package:keuanganku/app/app_colors.dart';
import 'package:keuanganku/app/reusable_components/heading_text/heading_text.dart';
import 'package:keuanganku/app/reusable_components/k_button/k_button.dart';
import 'package:keuanganku/app/reusable_components/k_textfield/ktext_field.dart';
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
    return SizedBox(
      width: size.width * 0.9,
      height: size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          dummyPadding(height: 50),
          Row(
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
          ),
          dummyPadding(height: 25),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: KTextField(
              fieldController: controllerFieldJudul , 
              fieldName: "Judul", 
              icon: Icons.title,
              prefixIconColor: ApplicationColors.primary
            ),
          ),
          dummyPadding(height: 25),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: KButton(
              onTap: (){}, 
              title: "Simpan", 
              icon: const Icon(Icons.save, color: Colors.white,),
              color: Colors.white,
              bgColor: ApplicationColors.primary,
            ),
          )
        ],
      ),
    );
  }
}