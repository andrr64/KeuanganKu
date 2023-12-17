import 'package:sqflite/sqflite.dart';

class SQLHelperExpenseLimiter {
  static const String _tableName = "expense_limiter";
  static final Map<String, Map<String, String>> _table = {
    "id": {
      "name": "id",
      "type": "INTEGER PRIMARY KEY",
    },
    "deskripsi" : {
      "name" : "judul",
      "type" : "TEXT",
      "constraint" : ""
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
}