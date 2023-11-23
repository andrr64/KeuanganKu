import 'package:keuanganku/database/model/kategori_pengeluaran.dart';

class DataPengeluaran {
  DataPengeluaran({
    required this.id,
    required this.judul,
    required this.deskripsi,
    required this.nilai,
    required this.waktu,
    required this.kategoriPengeluaran
  });

  int id;
  String judul;
  String deskripsi;
  double nilai;
  DateTime waktu;
  KategoriPengeluaran kategoriPengeluaran;

  int get tanggal => waktu.toLocal().day;
  int get tahun => waktu.toLocal().year;
  int get bulan => waktu.toLocal().month;
}