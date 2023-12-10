import 'package:sqflite/sqflite.dart';

class SQLHelperWallet {
    Future createTable(Database db) async {
    await db.execute(SQLHelperWallet().sqlCreateQuery);
  }

  final Map<String, Map<String, String>> _table = {
    "id": {
      "name": "id",
      "type": "INTEGER",
      "constraint": "AUTO INCREMENT PRIMARY KEY",
    },
    "tipe" : {
      "name" : "tipe",
      "type" : "TEXT",
      "constraint" : "NOT NULL"
    },
    "judul": {
      "name" : "judul",
      "type" : "TEXT",
      "constraint" : "NOT NULL"
    }
  };

  final _tableName = "wallet";
  
  String get sqlCreateQuery {
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

}