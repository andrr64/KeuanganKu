class SQLModelKategoriTransaksi {
  String judul;
  int id;

  SQLModelKategoriTransaksi({
    required this.id,
    required this.judul,
  });

  // Fungsi untuk membuat objek dari Map
  factory SQLModelKategoriTransaksi.fromMap(Map<String, dynamic> map) {
    return SQLModelKategoriTransaksi(
      id: map['id'],
      judul: map['judul'],
    );
  }

  // Fungsi untuk mengubah objek menjadi Map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'judul': judul,
    };
  }
}
