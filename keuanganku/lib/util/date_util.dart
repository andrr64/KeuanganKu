import 'package:flutter/material.dart';
import 'package:keuanganku/enum/data_transaksi.dart';

List<DateTime> getHariMingguan() {
  List<DateTime> tanggalSeninKeMinggu = [];

  DateTime now = DateTime.now();
  DateTime monday = now.subtract(Duration(days: now.weekday - 1)); // Mendapatkan hari Senin saat ini

  // Tambahkan tanggal Senin hingga Minggu ke dalam list
  for (int i = 0; i < 7; i++) {
    DateTime day = monday.add(Duration(days: i));
    tanggalSeninKeMinggu.add(day);
  }

  return tanggalSeninKeMinggu;
}

String formatTanggal(DateTime dateTime) {
  final List<String> namaBulan = [
    "", "Januari", "Februari", "Maret", "April", "Mei", "Juni",
    "Juli", "Agustus", "September", "Oktober", "November", "Desember"
  ];

  String hari = dateTime.day.toString();
  String bulan = namaBulan[dateTime.month];
  String tahun = dateTime.year.toString();

  return '$hari $bulan $tahun';
}

String formatWaktu(TimeOfDay waktu) {
  String jam = waktu.hour < 10 ? '0${waktu.hour}' : '${waktu.hour}';
  String menit = waktu.minute < 10 ? '0${waktu.minute}' : '${waktu.minute}';
  return '$jam.$menit';
}

String enumDataTransaksiInfo(WaktuTransaksi waktuTransaksi){
  switch (waktuTransaksi){
    case (WaktuTransaksi.Mingguan):
      return "Minggu Ini";
    case (WaktuTransaksi.Tahunan):
      return "Tahun Ini";
    default:
      return "Ringkasan";
  }
}

DateTime combineDtTod(DateTime dt, TimeOfDay tod) {
  // Mendapatkan tanggal dari DateTime dt
  DateTime date = DateTime(dt.year, dt.month, dt.day);

  // Menggabungkan tanggal dan waktu dari tod
  DateTime combinedDateTime = date.add(Duration(
    hours: tod.hour,
    minutes: tod.minute,
  ));

  return combinedDateTime;
}
