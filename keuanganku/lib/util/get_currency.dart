import 'package:intl/intl.dart';

String formatCurrency(double total) {
  // Menggunakan NumberFormat untuk memformat angka menjadi mata uang
  final currencyFormat = NumberFormat.currency(locale: 'id_ID');
  String formattedTotal = currencyFormat.format(total);

  return formattedTotal;
}