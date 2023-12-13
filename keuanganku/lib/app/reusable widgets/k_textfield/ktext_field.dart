import 'package:flutter/material.dart';
import 'package:keuanganku/app/app_colors.dart';

class KTextField extends StatelessWidget {
  const KTextField({
    super.key,
    required this.fieldController,
    required this.fieldName,
    required this.prefixIconColor,
    this.icon,
    this.keyboardType,
    this.readOnly,
    this.onTap
  }
  );

  final String fieldName;
  final IconData? icon;
  final Color prefixIconColor;
  final TextEditingController fieldController;
  final TextInputType? keyboardType;
  final bool? readOnly;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return  
      TextFormField(
        controller: fieldController,
        keyboardType: keyboardType,
        readOnly: readOnly?? false,
        onTap: onTap,
        decoration: InputDecoration(
          labelText: fieldName,
          border: const OutlineInputBorder(),
          prefixIcon: Icon(icon, color: prefixIconColor,),
          labelStyle: const TextStyle(color: ApplicationColors.primary)
        ),
      );
  }
}