import 'package:intl/intl.dart';

String formatCurrency(double total) {
  final currencyFormat = NumberFormat.currency(locale: 'id_ID', symbol: 'IDR', decimalDigits: 0);
  String formattedTotal = currencyFormat.format(total);

  return formattedTotal;
}

String percentageFormat(double prc) {
  return '${prc.toStringAsFixed(1)}%';
}

String toThousandK(double amount) {
  if (amount >= 1000) {
    double amountInK = amount / 1000;
    return 'IDR ${amountInK.toString()}K';
  } else {
    return 'IDR ${amount.toString()}';
  }
}