import 'package:flutter/material.dart';

Color mapValueToColor(double value) {
  if (value == -1) {
    return Colors.grey;
  }
  if (value < 1.0 || value > 5.0) {
    throw ArgumentError('Nilai harus di antara 1 dan 5');
  }

  // Hitung nilai Hue untuk gradient dari merah ke hijau
  double hue = (value - 1.0) / 4.0 * 120.0;

  // Ubah nilai Hue menjadi warna menggunakan HSLColor
  HSLColor color = HSLColor.fromAHSL(1.0, hue, 1.0, 0.5);

  // Konversi HSLColor menjadi Color
  return color.toColor();
}