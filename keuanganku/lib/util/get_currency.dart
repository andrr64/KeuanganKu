import 'package:intl/intl.dart';

String formatCurrency(double total) {
  final currencyFormat = NumberFormat.currency(locale: 'id_ID', symbol: 'IDR', decimalDigits: 0);
  String formattedTotal = currencyFormat.format(total);

  return formattedTotal;
}

String percentageFormat(double prc) {
  return '${prc.toStringAsFixed(1)}%';
}