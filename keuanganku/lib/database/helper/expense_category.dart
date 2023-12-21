import 'package:keuanganku/database/model/category.dart';
import 'package:sqflite/sqflite.dart';

class SQLHelperExpenseCategory {
  static const String _tableName = "income_category";
  static final Map<String, Map<String, String>> _table = {
    "id": {
      "name": "id",
      "type": "INTEGER PRIMARY KEY",
    },
    "judul" : {
      "name" : "judul",
      "type" : "TEXT",
      "constraint" : "NOT NULL"
    },
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
  static final List<String> _defaultType = [
    "Makan dan Minum",
    "Gaya Hidup",
    "Transportasi",
  ];
  static final List<SQLModelCategory> _listOfType = List.generate(_defaultType.length, (index){
    return SQLModelCategory(id: index + 1, judul: _defaultType[index]);
  });
  static Future createTable({required Database db}) async{
    await db.execute(sqlCreateQuery);
    int defaultTypeLength = _defaultType.length;
    for (var i = 0; i < defaultTypeLength; i++) {
      await db.rawQuery("INSERT INTO $_tableName(id, judul) VALUES(?,?)", [_listOfType[i].id, _listOfType[i].judul]);
    }
  }

  // READ METHODS
  Future<List<SQLModelCategory>> readAll({required Database db}) async {
    return (await db.query(_tableName)).map((e) => SQLModelCategory.fromMap(e)).toList();
  }
  Future<SQLModelCategory> readById(int id, {required Database db}) async {
    Map<String, dynamic> results = (await db.query(_tableName, where: "id = $id"))[0]; // Mengambil data dari database => Map<String, dynamic>
    return SQLModelCategory.fromMap(results);
  }

  // INSERT METHODS
  Future insert(SQLModelCategory dataBaru, {required Database db}){
    return db.rawInsert("INSERT INTO $_tableName(judul) VALUES(?)", [dataBaru.judul]);
  }
}