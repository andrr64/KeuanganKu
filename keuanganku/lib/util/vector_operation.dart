double sumList(List<double> numbers) {
  // Gunakan metode reduce untuk menjumlahkan semua elemen dalam daftar
  double total = numbers.reduce((value, element) => value + element);
  return total;
}