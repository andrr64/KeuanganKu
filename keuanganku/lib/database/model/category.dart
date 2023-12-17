class SQLModelCategory {
  String judul;
  int id;

  SQLModelCategory({
    required this.id,
    required this.judul,
  });

  // Fungsi untuk membuat objek dari Map
  factory SQLModelCategory.fromMap(Map<String, dynamic> map) {
    return SQLModelCategory(
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
