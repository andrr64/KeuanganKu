import 'package:flutter/material.dart';
import 'package:keuanganku/app/app_colors.dart';
import 'package:keuanganku/util/font_style.dart';

class KDropdownMenu<T> {
  DropdownButtonFormField<T>? dropdownMenu;
  String labelText;
  bool? activeColor;

  KDropdownMenu({required List<DropdownMenuItem<T>> items, required void Function(T?) onChanged, required T value, required this.labelText, Widget? icon, this.activeColor}) {
    dropdownMenu = DropdownButtonFormField<T>(
      items: items,
      onChanged: onChanged,
      value: value,
      borderRadius: BorderRadius.circular(15),
      dropdownColor: Colors.white,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: kFontStyle(fontSize: 15, family: "QuickSand_Medium"),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: KColors.fontPrimaryBlack, width: 1),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: KColors.fontPrimaryBlack, width: 1),
        ),
        prefixIcon: icon,
      )
    );
  }

  Widget getWidget(){
    return dropdownMenu!;
  }
}
