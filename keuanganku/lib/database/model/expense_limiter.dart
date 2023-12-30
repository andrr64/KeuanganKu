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

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'deskripsi': deskripsi,
      'nilai': nilai,
      'waktu': waktu,
      'id_kategori': kategori.id, // Memanggil toMap dari objek kategori
    };
  }

  factory SQLModelExpenseLimiter.fromJson(Map<String, dynamic> json, SQLModelCategory kategori) {
    return SQLModelExpenseLimiter(
      id: json['id'] as int,
      deskripsi: json['deskripsi'] as String,
      nilai: json['nilai'] as double,
      waktu: json['waktu'] as String,
      kategori: kategori
    );
  }
}