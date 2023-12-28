// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keuanganku/app/app_colors.dart';
import 'package:keuanganku/app/widgets/k_button/k_button.dart';
import 'package:keuanganku/app/widgets/k_dialog/k_dialog_info.dart';
import 'package:keuanganku/app/widgets/k_textfield/ktext_field.dart';
import 'package:keuanganku/database/helper/user_data.dart';
import 'package:keuanganku/database/model/user_data.dart';
import 'package:keuanganku/enum/status.dart';
import 'package:keuanganku/k_typedef.dart';
import 'package:keuanganku/main.dart';
import 'package:keuanganku/util/dummy.dart';
import 'package:keuanganku/util/font_style.dart';

class FormInputUsername extends StatefulWidget {
  const FormInputUsername({super.key});

  @override
  State<FormInputUsername> createState() => _FormInputUsernameState();
}

class _FormInputUsernameState extends State<FormInputUsername> {
  TextEditingController controllerUsername = TextEditingController();

  KFormWidget   fieldNama (){
    return KTextField(
      fieldController: controllerUsername,
      fieldName: "Nama",
      prefixIconColor: KColors.fontPrimaryBlack,
      icon: CupertinoIcons.person_crop_circle,
    );
  }
  KButton       tombolOk  (){
    return KButton(
      onTap: () async {
        if (controllerUsername.text.isEmpty){
          KDialogInfo(
              title: "Hmmm...", info: "Masukin nama dulu dong :(", jenisPesan: Pesan.Warning).tampilkanDialog(context);
        } else {
          SQLModelUserdata userdataBaru = SQLModelUserdata(id: -1, username: controllerUsername.text);
          int exitCode = await SQLHelperUserData().updateById(db.database,1, userdataBaru);
          if (exitCode != -1){
            Navigator.pushReplacementNamed(context, routes.mainPage);
          } else {
            KDialogInfo(
                title: "Exception",
                info: "Terjadi kesalahan saat menyimpan data",
                jenisPesan: Pesan.Warning
            ).tampilkanDialog(context);
            Navigator.pop(context);
          }
        }
      },
      title: "Ok",
      icon: null,
      bgColor: KColors.fontPrimaryBlack, color: Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Hai, boleh kenalan gak?", style: kFontStyle(fontSize: 20),),
            dummyHeight(height: 15),
            fieldNama(),
            dummyHeight(height: 15),
            tombolOk(),
          ],
        ),
      ),
    );
  }
}