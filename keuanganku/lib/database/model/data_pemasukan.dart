import 'package:keuanganku/database/model/kategori_pemasukan.dart';

class DataPemasukan {
  DataPemasukan({
    required this.id,
    required this.judul,
    required this.deskripsi,
    required this.nilai,
    required this.waktu,
    required this.kategoriPemasukan
  });

  int id;
  String judul;
  String deskripsi;
  double nilai;
  DateTime waktu;
  KategoriPemasukan kategoriPemasukan;

  int get tanggal => waktu.toLocal().day;
  int get tahun => waktu.toLocal().year;
  int get bulan => waktu.toLocal().month;
}