List<DateTime> getRangeTanggalSeninKeMinggu() {
  List<DateTime> tanggalSeninKeMinggu = [];

  DateTime now = DateTime.now();
  DateTime monday = now.subtract(Duration(days: now.weekday - 1)); // Mendapatkan hari Senin saat ini

  // Tambahkan tanggal Senin hingga Minggu ke dalam list
  for (int i = 0; i < 7; i++) {
    DateTime day = monday.add(Duration(days: i));
    tanggalSeninKeMinggu.add(day);
  }

  return tanggalSeninKeMinggu;
}
