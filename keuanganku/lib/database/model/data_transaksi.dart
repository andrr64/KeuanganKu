import 'package:intl/intl.dart';
import 'package:keuanganku/database/model/kategori.dart';
import 'package:keuanganku/enum/data_transaksi.dart';

class DataTransaksi {
  int id;
  String judul;
  String deskripsi;
  double nilai;
  DateTime waktu;
  KategoriTransaksi kategoriTransaksi;
  JenisTransaksi jenisTransaksi;
  
  DataTransaksi({
    required this.id,
    required this.judul,
    required this.deskripsi,
    required this.nilai,
    required this.waktu,
    required this.kategoriTransaksi,
    required this.jenisTransaksi,
  });
  
  String limitedDeskripsi(int limit) => deskripsi.length > limit? '${deskripsi.substring(0, limit - 3)}...' : deskripsi;    int get tanggal => waktu.toLocal().day;
  int get tahun => waktu.toLocal().year;
  int get bulan => waktu.toLocal().month;

  String get dateTime {
    final formattedDate = DateFormat('d MMMM y, HH:mm').format(waktu.toLocal());
    return formattedDate;
  }
  String get jam => "${waktu.toLocal().hour}:${waktu.toLocal().minute}";
  String get kategori => kategoriTransaksi.judul;
}