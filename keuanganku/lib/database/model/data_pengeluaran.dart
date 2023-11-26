class ModelDataPengeluaran {
  int id;
  int id_wallet;
  int id_kategori;
  String judul;
  String deskripsi;
  double nilai;
  DateTime waktu;
  
  ModelDataPengeluaran({
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
  
  // Metode untuk membuat objek DataPengeluaran dari Map (output SQL)
  static ModelDataPengeluaran fromMap(Map<String, dynamic> map){
    return ModelDataPengeluaran(
      id: map['id'] ?? 0,
      id_wallet: map['id_wallet'] ?? 0,
      id_kategori: map['id_kategori'] ?? 0,
      judul: map['judul'] ?? '',
      deskripsi: map['deskripsi'] ?? '',
      nilai: map['nilai'] ?? 0.0,
      waktu: DateTime.parse(map['waktu'] ?? ''),
    );
  }
}
