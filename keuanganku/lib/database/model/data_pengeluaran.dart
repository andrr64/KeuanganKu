import 'package:keuanganku/database/model/data_transaksi.dart';

class ModelDataPengeluaran extends DataTransaksi{
  int? id_wallet;
  int? id_kategori;
  int? rating;

  ModelDataPengeluaran(
      int id, String judul, String deskripsi, double nilai, DateTime waktu,int id_wallet, int id_kategori, int? rating){
    super.init(id, judul, deskripsi, nilai, waktu);
    this.id_wallet = id_wallet;
    this.id_kategori = id_kategori;
    this.rating = rating?? 0;
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
      'waktu': waktu!.toIso8601String(),
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

    String hari = waktu!.day.toString();
    String bulan = namaBulan[waktu!.month];
    String tahun = waktu!.year.toString();
    String jam = waktu!.hour.toString().padLeft(2, '0');
    String menit = waktu!.minute.toString().padLeft(2, '0');

    return '$hari $bulan $tahun, $jam:$menit';
  }

  // Metode untuk membuat objek DataPengeluaran dari Map (output SQL)
  static ModelDataPengeluaran fromMap(Map<String, dynamic> map){
    return ModelDataPengeluaran(
      map['id'] ?? 0,
      map['judul'] ?? '',
      map['deskripsi'] ?? '',
      map['nilai'] ?? 0.0,
      DateTime.parse(map['waktu'] ?? ''),
      map['id_wallet'] ?? 0,
      map['id_kategori'] ?? 0,
      map['rating'] ?? 0
    );
  }
}
