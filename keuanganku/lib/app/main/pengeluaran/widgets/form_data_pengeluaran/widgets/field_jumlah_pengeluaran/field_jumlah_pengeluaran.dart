import 'package:flutter/material.dart';
import 'package:keuanganku/app/app_colors.dart';
import 'package:keuanganku/app/reusable%20widgets/k_textfield/ktext_field.dart';

class FieldJumlahIDR {
  final TextEditingController _controller;
  FieldJumlahIDR(this._controller);

  Widget getWidget(){
    return
    KTextField(
      fieldController: _controller,
      icon: Icons.attach_money,
      fieldName: "Jumlah Pengeluaran", 
      keyboardType: TextInputType.number,
      prefixIconColor: ApplicationColors.primary
    );
  }
}