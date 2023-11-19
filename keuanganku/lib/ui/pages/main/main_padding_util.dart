import 'package:flutter/material.dart';

/// Fungsi ini akan memberikan padding vertical ke 'child'
Widget formatWidget({required Widget child}){
  const double paddingSz = 5;
  return Padding(padding: const EdgeInsets.symmetric(vertical: paddingSz), child: child,);
}
