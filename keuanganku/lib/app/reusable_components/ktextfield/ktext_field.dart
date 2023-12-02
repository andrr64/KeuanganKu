import 'package:flutter/material.dart';
import 'package:keuanganku/app/app_colors.dart';

class KTextField extends StatelessWidget {
  const KTextField({super.key, required this.fieldController, required this.fieldName, required this.prefixIconColor, this.icon, this.keyboardType});
  final String fieldName;
  final IconData? icon;
  final Color prefixIconColor;
  final TextEditingController fieldController;
  final TextInputType? keyboardType;
  
  @override
  Widget build(BuildContext context) {
    return  
      SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: TextFormField(
          controller: fieldController,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            labelText: fieldName,
            border: const OutlineInputBorder(),
            prefixIcon: Icon(icon, color: prefixIconColor,),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: prefixIconColor)
            ),
            labelStyle: const TextStyle(color: ApplicationColors.primary)
          ),
        ),
    );
  }
}