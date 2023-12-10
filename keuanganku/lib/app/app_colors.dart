import 'dart:ui';

class ApplicationColors {
  static const Color primary = Color.fromARGB(255, 56, 54, 81);
  static const Color secondaryOrange = Color.fromARGB(255,255,111,49);
  static const Color secondaryYoungPurple = Color(0xffD3C3FA);
  static const Color buttonBgColor = Color(0xffF5F5F6);
  
  static Color primaryColorWidthPercentage({double? percentage}) {
    if (percentage != null) {
      // Konversi persentase alpha ke nilai antara 0 dan 255
      int alpha = (255 * (percentage)/100).round();

      // Tentukan nilai ARGB dengan alpha yang sudah dikonversi
      return Color.fromARGB(
          alpha, primary.red, primary.green, primary.blue);
    }
    return primary;
  }
}
