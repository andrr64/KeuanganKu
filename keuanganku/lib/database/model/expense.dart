// ignore_for_file: non_constant_identifier_names

import 'package:keuanganku/database/helper/expense_category.dart';
import 'package:keuanganku/database/helper/wallet.dart';
import 'package:keuanganku/database/model/category.dart';
import 'package:keuanganku/database/model/wallet.dart';
import 'package:keuanganku/main.dart';

class SQLModelExpense {
  final int id;
  final int id_wallet;
  final int id_kategori;
  final String judul;
  final String deskripsi;
  final double nilai;
  final double rating;
  final DateTime waktu;


  SQLModelExpense({
    required this.id,
    required this.id_wallet,
    required this.id_kategori,
    required this.judul,
    required this.deskripsi,
    required this.nilai,
    required this.rating,
    required this.waktu,
  });

  static String infoRating(double rating) {
    if (rating >= 1.0 && rating <= 2.0) {
      return 'Sangat tidak penting';
    } else if (rating > 2.0 && rating <= 3.0) {
      return 'Cukup';
    } else if (rating > 3.0 && rating <= 4.0) {
      return 'Lumayan Hemat';
    } else if (rating > 4.0 && rating <= 5.0) {
      return 'Hemat Uang';
    } else {
      return 'Invalid';
    }
  }
  static String getInfoBasedOnRating(double rating) {
    String info = infoRating(rating);

    switch (info) {
      case 'Sangat tidak penting':
        return 'Pengeluaranmu sangat buruk. Sebaiknya perhatikan pengelolaan keuanganmu dengan lebih baik.';
      case 'Cukup':
        return 'Pengeluaranmu cukup baik, namun masih ada ruang untuk peningkatan.';
      case 'Lumayan Hemat':
        return 'Pengeluaranmu baik. Tetap pertahankan dan perbaiki aspek-aspek yang perlu ditingkatkan.';
      case 'Hemat Uang':
        return 'Pengeluaranmu sangat baik. Selamat! Tetap konsisten dalam pengelolaan keuanganmu.';
      case 'Invalid':
        return 'Nilai rating tidak valid.';
      default:
        return 'Informasi tidak tersedia.';
    }
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'id_wallet': id_wallet,
      'id_kategori': id_kategori,
      'judul': judul,
      'deskripsi': deskripsi,
      'nilai': nilai,
      'rating': rating,
      'waktu': waktu.toIso8601String(),
    };
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

  // Metode untuk membuat objek DataPengeluaran dari Map (output SQL)
  static SQLModelExpense fromMap(Map<String, dynamic> map){
    return SQLModelExpense(
      id: map['id'] ?? -1,
      judul: map['judul'] ?? '',
      deskripsi: map['deskripsi'] ?? '',
      nilai: map['nilai'] ?? -1,
      waktu: DateTime.parse(map['waktu'] ?? ''),
      id_wallet: map['id_wallet'] ?? -1,
      id_kategori: map['id_kategori'] ?? -1,
      rating: map['rating'] ?? -1
    );
  }

  Future<SQLModelCategory> get kategori async {
    return await SQLHelperExpenseCategory().readById(id_kategori, db: db.database);
  }

  Future<SQLModelWallet> get wallet async {
    return await SQLHelperWallet().readById(id_wallet, db: db.database);
  }

  static double totalPengeluaranByMonth(int year, int month, List<SQLModelExpense> listPengeluaran) {
    // Filter listPengeluaran berdasarkan bulan dan tahun
    List<SQLModelExpense> filteredList = listPengeluaran
        .where((pengeluaran) =>
            pengeluaran.waktu.year == year &&
            pengeluaran.waktu.month == month)
        .toList();

    // Hitung total nilai pengeluaran
    double totalNilai = 0.0;
    for (var pengeluaran in filteredList) {
      totalNilai += pengeluaran.nilai;
    }

    return totalNilai;
  }
  static double totalPengeluaranByDate(DateTime tanggal, List<SQLModelExpense> listPengeluaran) {
    // Filter listPengeluaran berdasarkan tanggal
    List<SQLModelExpense> filteredList = listPengeluaran
        .where((pengeluaran) =>
            pengeluaran.waktu.year == tanggal.year &&
            pengeluaran.waktu.month == tanggal.month &&
            pengeluaran.waktu.day == tanggal.day)
        .toList();

    // Hitung total nilai pengeluaran
    double totalNilai = 0.0;
    for (var pengeluaran in filteredList) {
      totalNilai += pengeluaran.nilai;
    }

    return totalNilai;
  }
}
