// ignore_for_file: constant_identifier_names

enum JenisTransaksi {
  Pemasukan,
  Pengeluaran,
  NULL
}

enum WaktuTransaksi {
  /// Dari hari senin ampe minggu
  Mingguan,
  /// Bulanan dari tanggal 1 sampe 31
  Bulanan,
  /// Dari Januari sampe Desember
  Tahunan,
}

enum SortirTransaksi {
  Default,
  Terbaru,
  Terlama,
  Tertinggi,
  Terendah
}