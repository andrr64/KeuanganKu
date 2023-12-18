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

  factory SQLModelExpenseLimiter.fromJson(Map<String, dynamic> json) {
    return SQLModelExpenseLimiter(
      id: json['id'] as int,
      deskripsi: json['deskripsi'] as String,
      nilai: json['nilai'] as double,
      waktu: json['waktu'] as String,
      kategori: SQLModelCategory.fromMap(json['kategori'] as Map<String, dynamic>),
    );
  }
}