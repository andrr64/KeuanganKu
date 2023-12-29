import 'package:keuanganku/database/helper/income.dart';
import 'package:keuanganku/database/helper/expense.dart';
import 'package:keuanganku/database/model/wallet.dart';
import 'package:keuanganku/main.dart';
import 'package:keuanganku/util/vector_operation.dart';
import 'package:sqflite/sqflite.dart';

class SQLHelperWallet {
  static Future createTable(Database db) async {
    await db.execute(SQLHelperWallet().sqlCreateQuery);
  }

  final Map<String, Map<String, String>> _table = {
    "id": {
      "name": "id",
      "type": "INTEGER PRIMARY KEY",
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

  // READ METHODS 
  Future<List<SQLModelWallet>> readAll(Database db) async {
    final List<Map<String, dynamic>> maps = await db.query(_tableName);

    return List.generate(maps.length, (i) {
      return SQLModelWallet(
        id: maps[i]['id'],
        tipe: maps[i]['tipe'],
        judul: maps[i]['judul'],
      );
    });
  }
  Future<SQLModelWallet> readById(int id, {required Database db}) async {
    final mapWallet = await db.query(_tableName, where: "id == $id");
    return SQLModelWallet.fromMap(mapWallet[0]);
  }
  Future<double> readTotalUang(SQLModelWallet wallet) async{
    final dataPemasukan = await SQLHelperIncome().readDataByWalletId(wallet.id, db.database);
    final dataPengeluaran = await SQLHelperExpense().readByWalletId(wallet.id, db.database);
    return sumList(dataPemasukan.map((e) => e.nilai).toList()) - sumList(dataPengeluaran.map((e) => e.nilai).toList());
  }
  Future<double> readSeluruhTotalUangTersedia()  async {
    List<SQLModelWallet> seluruhWallet = await SQLHelperWallet().readAll(db.database);
    double totalUang = 0;
    for(var wallet in seluruhWallet){
      totalUang += await wallet.totalUang();
    }

    return totalUang;
  }

  // INSERT METHODS
  Future<int> insert(SQLModelWallet wallet, Database db) async {
    return await db.rawInsert(
      "INSERT INTO $_tableName(tipe, judul) VALUES(?, ?)",
      [wallet.tipe, wallet.judul]
    );
  }

  // UPDATE METHODS
  Future<int> update(SQLModelWallet updatedWallet, Database db) async {
    return await db.update(_tableName, updatedWallet.toMap(), where: "id = ?", whereArgs: [updatedWallet.id]);
  }

  // DELETE METHOD
  Future<int> delete(SQLModelWallet wallet, Database db) async {
    Future deleteWallet() async {
      return db.delete(_tableName, where: "id = ?", whereArgs: [wallet.id]);
    }
    if (await SQLHelperIncome().deleteAllByWalletId(wallet.id, db.database)  == -1){
      return -0xa1;
    }
    if (await SQLHelperExpense().deleteAllByWalletId(wallet.id, db.database) == -1){
      return -0xa2;
    }
    
    if (await deleteWallet() == -1){
      return -0xa3;
    }
    return 0;
  }
}