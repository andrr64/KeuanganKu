import 'package:keuanganku/util/date_util.dart';

abstract class DataTransaksi {
  int? id = -1;
  String? judul;
  String? deskripsi;
  double? nilai;
  DateTime? waktu;

  void init(int id, String judul, String deskripsi, double nilai, DateTime waktu){
    this.id = id;
    this.judul = judul;
    this.deskripsi = deskripsi;
    this.nilai = nilai;
    this.waktu = waktu;
  }

  String get waktuTerformat => formatTanggal(waktu!); 
}