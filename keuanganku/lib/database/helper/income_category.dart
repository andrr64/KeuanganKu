import 'package:keuanganku/database/helper/income.dart';
import 'package:keuanganku/database/model/category.dart';
import 'package:sqflite/sqflite.dart';

class SQLHelperIncomeCategory {
  static const String _tableName = "expense_category";
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
    "Penghasilan",
    "Penghasilan Sampingan",
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
  Future<List<SQLModelCategory>>  readAll({required Database db}) async {
    return (await db.query(_tableName, orderBy: "${_table['judul']?['name']}", )).map((e) => SQLModelCategory.fromMap(e)).toList();
  }
  Future<SQLModelCategory>        readById(int id, {required Database db}) async {
    Map<String, dynamic> results = (await db.query(_tableName, where: "id = $id"))[0]; // Mengambil data dari database => Map<String, dynamic>
    return SQLModelCategory.fromMap(results);
  }
  
  /// Fungsi ini akan memeriksa apakah terdapat data pemasukan yang mereferensikan kategori (via id)
  Future<bool>                    readIsThereAnyReferencedData(int id, Database db) async {
    return (await SQLHelperIncome().readByCategoryId(db: db, idKategori: id, countOnly: true)) > 0;
  }

  // INSERT METHODS
  Future insert(SQLModelCategory? dataBaru, {required Database db}) async{
    if (dataBaru == null){
      return -1;
    }
    return await db.rawInsert("INSERT INTO $_tableName(judul) VALUES(?)", [dataBaru.judul]);
  }
}