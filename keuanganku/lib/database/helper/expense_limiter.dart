import 'package:keuanganku/database/helper/expense_category.dart';
import 'package:keuanganku/database/model/expense_limiter.dart';
import 'package:sqflite/sqflite.dart';

class SQLHelperExpenseLimiter {
  static const String _tableName = "expense_limiter";
  static final Map<String, Map<String, String>> _table = {
    "id": {
      "name": "id",
      "type": "INTEGER",
      "constraint" :" PRIMARY KEY AUTOINCREMENT"
    },
    "deskripsi" : {
      "name" : "deskripsi",
      "type" : "TEXT",
      "constraint" : ""
    },
    "Waktu" : {
      'name' : 'waktu',
      'type' : 'TEXT',
    },
    "Nilai Batas Pengeluaran" : {
      "name" : "nilai",
      "type" : "REAL",
      "constraint" : "NOT NULL"
    },
    "Id Kategori" : {
      "name" : "id_kategori",
      "type" : "INTEGER",
      "constraint": "NOT NULL"
    }
  };
  
  static String get sqlCreateQuery {
    String columns = "";
    _table.forEach((key, value) {
      columns += "${value['name']} ${value['type']} ${value['constraint']}, ";
    });

    // Hapus spasi dan koma pada baris terakhir
    columns = columns.substring(0, columns.length - 2);

    return """
      CREATE TABLE IF NOT EXISTS $_tableName (
        $columns
      )
    """;
  }
  static Future createTable(Database db) async {  
    await db.execute(sqlCreateQuery);
  }
  static List<Map<String, dynamic>> defaultData = [];

  Future<List<SQLModelExpenseLimiter>> readAll(Database db) async {
    try {
      List<Map<String, dynamic>> results = await db.query(_tableName); 
      List<SQLModelExpenseLimiter> listData = [];
      for (var dataJson in results) {
        final dataBaru = SQLModelExpenseLimiter.fromJson(
          dataJson, 
          await SQLHelperExpenseCategory().readById(dataJson['id_kategori'], db: db)
        );
        listData.add(dataBaru);
      }
      return listData;

    } catch(errorKetikaMengambilDataDariDatabase){
      throw Exception("gagal mengambil data");
    }
  }
  Future<int> insert(SQLModelExpenseLimiter newLimiter, {required Database db}) async {
    try {
      return await db.rawInsert(
        "INSERT INTO $_tableName(deskripsi,nilai,waktu,id_kategori) VALUES(?,?,?,?)",
        [newLimiter.deskripsi,newLimiter.nilai,newLimiter.waktu, newLimiter.kategori.id]
      );
    } catch(errorPasMasukinData){
      return -1;
    }
    
  }
  Future<int> update(SQLModelExpenseLimiter data, {required Database db}) async {
    return await db.update(_tableName, data.toMap(), where: "id = ?", whereArgs: [data.id]);
  }
  Future<int> delete(int id, {required Database db}) async {
    return await db.delete(_tableName, where: "id = ?", whereArgs: [id]);
  }
}