// ignore_for_file: non_constant_identifier_names

import 'package:keuanganku/database/helper/income_category.dart';
import 'package:keuanganku/database/helper/wallet.dart';
import 'package:keuanganku/database/model/category.dart';
import 'package:keuanganku/database/model/wallet.dart';
import 'package:keuanganku/main.dart';

class SQLModelIncome {
  int id = -1;
  int id_wallet;
  int id_kategori;
  String judul;
  String deskripsi;
  double nilai;
  DateTime waktu;

  SQLModelIncome({
    required this.id,
    required this.id_wallet,
    required this.id_kategori,
    required this.judul,
    required this.deskripsi,
    required this.nilai,
    required this.waktu,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'id_wallet': id_wallet,
      'id_kategori': id_kategori,
      'judul': judul,
      'deskripsi': deskripsi,
      'nilai': nilai,
      'waktu': waktu.toIso8601String(),
    };
  }

  String titleWithLimitedString(int n){
    return judul.length > n? "${judul.substring(0, n)}..." : judul;
  }

  String get type {
    return id_kategori == 1 ? "Bank" : "Wallet";
  }

  String formatWaktu() {
    final List<String> namaBulan = [
      '', // indeks 0 tidak digunakan
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember',
    ];

    String hari = waktu.day.toString();
    String bulan = namaBulan[waktu.month];
    String tahun = waktu.year.toString();
    String jam = waktu.hour.toString().padLeft(2, '0');
    String menit = waktu.minute.toString().padLeft(2, '0');

    return '$hari $bulan $tahun, $jam:$menit';
  }
  Future<SQLModelWallet> get wallet async {
    return await SQLHelperWallet().readById(id_wallet, db: db.database);
  }
  Future<SQLModelCategory> get kategori async {
    return await SQLHelperIncomeCategory().readById(id_kategori, db: db.database);
  }
  static SQLModelIncome fromMap(Map<String, dynamic> map) {
    return SQLModelIncome(
      id: map['id'] ?? -1,
      id_wallet: map['id_wallet'] ?? -1,
      id_kategori: map['id_kategori'] ?? -1,
      judul: map['judul'] ?? '',
      deskripsi: map['deskripsi'] ?? '',
      nilai: map['nilai'] ?? 0.0,
      waktu: DateTime.parse(map['waktu'] ?? ''),
    );
  }
}