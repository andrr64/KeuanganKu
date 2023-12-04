import 'package:flutter/material.dart';
import 'package:keuanganku/app/app_colors.dart';

class KIconField extends StatelessWidget {
  const KIconField({super.key, required this.fieldName, required this.boxWidth, required this.fieldWidth,  required this.controller, required this.icon, required this.onTap});
  
  final TextEditingController controller;
  final Icon icon;
  final void Function() onTap;
  final double boxWidth;
  final double fieldWidth;
  final String fieldName;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: boxWidth,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: fieldWidth, 
            child: TextField(
              readOnly: true,
              controller: controller,
              decoration: InputDecoration(
                labelText: fieldName,
                border: const OutlineInputBorder(),
                labelStyle: const TextStyle(color: ApplicationColors.primary)
              ),
            ),
          ),
          GestureDetector(
            onTap: onTap,
            child: icon,
          )
        ],
      ),
    );
  }
}