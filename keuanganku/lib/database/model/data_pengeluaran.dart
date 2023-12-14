// ignore_for_file: non_constant_identifier_names

class SQLModelPengeluaran {
  final int id;
  final int id_wallet;
  final int id_kategori;
  final String judul;
  final String deskripsi;
  final double nilai;
  final double rating;
  final DateTime waktu;


  SQLModelPengeluaran({
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
      return 'Sia-Sia';
    } else if (rating > 2.0 && rating <= 3.0) {
      return 'Cukup';
    } else if (rating > 3.0 && rating <= 4.0) {
      return 'Baik';
    } else if (rating > 4.0 && rating <= 5.0) {
      return 'Sangat Baik';
    } else {
      return 'Invalid';
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
  static SQLModelPengeluaran fromMap(Map<String, dynamic> map){
    return SQLModelPengeluaran(
      id: map['id'] ?? 0,
      judul: map['judul'] ?? '',
      deskripsi: map['deskripsi'] ?? '',
      nilai: map['nilai'] ?? 0.0,
      waktu: DateTime.parse(map['waktu'] ?? ''),
      id_wallet: map['id_wallet'] ?? 0,
      id_kategori: map['id_kategori'] ?? 0,
      rating: map['rating'] ?? 0
    );
  }
}
