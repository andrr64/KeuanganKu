import 'package:flutter/material.dart';
import 'package:keuanganku/app/app_colors.dart';

class KTextField extends StatefulWidget {
  const KTextField({super.key, required this.fieldController, required this.fieldName, required this.prefixIconColor, this.icon});
  final String fieldName;
  final IconData? icon;
  final Color prefixIconColor;
  final TextEditingController fieldController;

  @override
  State<KTextField> createState() => _KTextFieldState();
}

class _KTextFieldState extends State<KTextField> {

  @override
  Widget build(BuildContext context) {
    return  
      SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: TextFormField(
          controller: widget.fieldController,
          decoration: InputDecoration(
            labelText: widget.fieldName,
            border: const OutlineInputBorder(),
            prefixIcon: Icon(widget.icon, color: widget.prefixIconColor,),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: widget.prefixIconColor)
            ),
            labelStyle: const TextStyle(color: ApplicationColors.primary)
          ),
        ),
    );
  }
}