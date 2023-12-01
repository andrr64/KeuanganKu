double sumList(List<double> numbers) {
  // Gunakan metode reduce untuk menjumlahkan semua elemen dalam daftar
  if (numbers.isEmpty) return 0;
  double total = numbers.reduce((value, element) => value + element);
  return total;
}