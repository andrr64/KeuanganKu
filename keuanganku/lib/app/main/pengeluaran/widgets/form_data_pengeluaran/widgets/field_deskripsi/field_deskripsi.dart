import 'package:flutter/material.dart';
import 'package:keuanganku/app/app_colors.dart';
import 'package:keuanganku/app/reusable_components/k_textfield/ktext_field.dart';

class FieldDeskripsi {
  FieldDeskripsi(this._controllerFieldDeskripsi);
  final TextEditingController _controllerFieldDeskripsi;

  Widget getWidget(){
    return 
    KTextField(
      fieldController: _controllerFieldDeskripsi,
      icon: Icons.description,
      fieldName: "Deskripsi", 
      prefixIconColor: ApplicationColors.primary
    );
                     
  }
}