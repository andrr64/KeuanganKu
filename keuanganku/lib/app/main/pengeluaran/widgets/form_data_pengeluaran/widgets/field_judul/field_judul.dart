import 'package:flutter/material.dart';
import 'package:keuanganku/app/app_colors.dart';
import 'package:keuanganku/app/reusable%20widgets/k_textfield/ktext_field.dart';

class FieldJudul {
  FieldJudul(this._controllerFieldJudul);

  final TextEditingController _controllerFieldJudul;

  Widget getWidget(){
    return 
    KTextField(
      fieldController: _controllerFieldJudul,
      icon: Icons.title,
      fieldName: "Judul", 
      prefixIconColor: ApplicationColors.primary
    );
  }
}