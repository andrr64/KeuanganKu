import 'package:keuanganku/database/helper/data_kategori_pemasukan.dart';
import 'package:keuanganku/database/helper/data_kategori_pengeluaran.dart';
import 'package:keuanganku/database/helper/data_pemasukan.dart';
import 'package:keuanganku/database/helper/data_pengeluaran.dart';
import 'package:keuanganku/database/helper/data_wallet.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  final String _databaseName = "keuanganku.db";
  final int _databaseVersion = 1;
  
  /// Pointer Database
  Database? _database;  

  /// Fungsi saat file database dibuat
  createTable(Database db, version){
    SQLHelperPengeluaran.createTable(db);
    SQLHelperPemasukan.createTable(db);
    SQLHelperWallet.createTable(db);
    SQLHelperKategoriPengeluaran.createTable(db: db);
    SQLHelperKategoriPemasukan.createTable(db: db);
  }

  /// Panggil fungsi ini untuk satu kali saja disaat inisialisasi database
  Future<void> openDB() async {
    try {
      final path = join(await getDatabasesPath(), _databaseName);
      _database = await openDatabase(
        path,
        version: _databaseVersion,
        onCreate: createTable
      );
    } catch (e) {
      e;
    }
  }

  get database => _database;
}
