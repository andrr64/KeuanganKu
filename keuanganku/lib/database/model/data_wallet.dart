class SQLModelWallet {
  SQLModelWallet({required this.id, required this.judul});

  final int id;
  final String judul;

  Map<String, dynamic> toMap(){
    return {
      'id' : id,
      'judul' : judul
    };
  }

  static SQLModelWallet fromMap(Map<String, dynamic> map){
    return SQLModelWallet(id: map['id'], judul: map['judul']);
  }
}