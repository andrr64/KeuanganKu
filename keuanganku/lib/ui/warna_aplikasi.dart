import 'dart:ui';

class Warna {
  static const Color primaryColor = Color.fromARGB(255, 56, 54, 81);

  static const Color secondaryColorOrange = Color.fromARGB(255,255,111,49);

  static Color getColorByPercentage({double? percentage}) {
    if (percentage != null) {
      // Konversi persentase alpha ke nilai antara 0 dan 255
      int alpha = (255 * (percentage)/100).round();

      // Tentukan nilai ARGB dengan alpha yang sudah dikonversi
      return Color.fromARGB(
          alpha, primaryColor.red, primaryColor.green, primaryColor.blue);
    }
    return primaryColor;
  }
}
