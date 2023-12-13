import 'package:flutter/material.dart';

class KDropdownMenu<T> {
  DropdownButtonFormField<T>? dropdownMenu;
  String labelText;

  KDropdownMenu({required List<DropdownMenuItem<T>> items, required void Function(T?) onChanged, required T value, required this.labelText, Icon? icon}) {
    dropdownMenu = DropdownButtonFormField<T>(
      items: items,
      onChanged: onChanged,
      value: value,
      decoration: InputDecoration(
        labelText: labelText,
        border: const OutlineInputBorder(),
        prefixIcon: icon,
      )
    );
  }

  Widget getWidget(){
    return dropdownMenu!;
  }
}
