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

String formatTanggal(DateTime dateTime) {
  final List<String> namaBulan = [
    "", "Januari", "Februari", "Maret", "April", "Mei", "Juni",
    "Juli", "Agustus", "September", "Oktober", "November", "Desember"
  ];

  String hari = dateTime.day.toString();
  String bulan = namaBulan[dateTime.month];
  String tahun = dateTime.year.toString();

  return '$hari $bulan $tahun';
}
