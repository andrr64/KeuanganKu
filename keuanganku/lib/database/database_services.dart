import 'package:keuanganku/database/helper/data_pengeluaran.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  final String _databaseName = "keuanganku.db";
  final int _databaseVersion = 1;
  
  Database? _database;  

  createTable(Database db, version){
    DataPengeluaran().createTable(db);
  }

  Future<void> openDB() async {
    try {
      final path = join(await getDatabasesPath(), _databaseName);
      _database = await openDatabase(
        path,
        version: _databaseVersion,
        onCreate: createTable
      );
    } catch (e) {
      print(e);
    }
  }

  get database => _database;
}
