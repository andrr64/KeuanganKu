import 'package:keuanganku/util/get_currency.dart';

class SQLModelWallet {
  SQLModelWallet({required this.id,required this.tipe,required this.judul});

  final int id;
  final String judul;
  final String tipe;

  Map<String, dynamic> toMap(){
    return {
      'id' : id,
      'tipe' : tipe,
      'judul' : judul
    };
  }

  static SQLModelWallet fromMap(Map<String, dynamic> map){
    return SQLModelWallet(id: map['id'],tipe: map['tipe'],  judul: map['judul']);
  }

  // getter
  double get nilai => 2000000;
  String get nilaiString => formatCurrency(nilai);
}