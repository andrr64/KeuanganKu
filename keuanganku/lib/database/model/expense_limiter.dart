import 'package:keuanganku/database/model/category.dart';

class SQLModelExpenseLimiter {
  int id;
  String deskripsi;
  double nilai;
  SQLModelCategory kategori;
  String waktu;

  SQLModelExpenseLimiter({
    required this.id,
    required this.deskripsi,
    required this.nilai,
    required this.waktu,
    required this.kategori
  });
}