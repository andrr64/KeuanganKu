import 'package:keuanganku/database/model/expense.dart';
import 'package:keuanganku/enum/data_transaksi.dart';
import 'package:sqflite/sqflite.dart';

class SQLHelperExpense {
  static Future createTable(Database db) async {
    await db.execute(SQLHelperExpense().sqlCreateQuery);
  }
  
  static final Map<String, Map<String, String>> _table = {
    "id": {
      "name": "id",
      "type": "INTEGER",
      "constraint": "PRIMARY KEY AUTOINCREMENT",
    },
    "id_kategori": {
      "name": "id_kategori",
      "type": "INTEGER",
      "constraint": "NOT NULL",
    },
    "id_wallet": {
      "name": "id_wallet",
      "type": "INTEGER",
      "constraint": "NOT NULL",
    },
    "waktu": {
      "name": "waktu",
      "type": "TEXT",
      "constraint": "NOT NULL",
    },
    "judul": {
      "name": "judul",
      "type": "TEXT",
      "constraint": "",
    },
    "rating": {
      "name": "rating",
      "type": "REAL",
      "constraint": "NOT NULL",
    },
    "deskripsi": {
      "name": "deskripsi",
      "type": "TEXT",
      "constraint": "",
    },
    "nilai": {
      "name": "nilai",
      "type": "REAL",
      "constraint": "NOT NULL",
    },
  };

  static const _tableName = "expense";
  
  Future<List<SQLModelExpense>> readByWaktu(WaktuTransaksi waktuTransaksi, {required Database db}) async {
    switch (waktuTransaksi) {
      case WaktuTransaksi.Mingguan:
        return (await SQLHelperExpense().readWeekly(db: db.database));
      case WaktuTransaksi.Bulanan:
        DateTime now = DateTime.now();
        return (await SQLHelperExpense().readDataByMonth(now.year, now.month, db: db));
      case WaktuTransaksi.Tahunan:
        return (await SQLHelperExpense().readDataByYear(DateTime.now().year, db: db.database));
      default:
        return [];
    }
  }

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

  String waktuClauseTanggal(DateTime time){
      String formattedDate = time.toIso8601String().substring(0, 10);
      return "waktu LIKE '$formattedDate%'";
  }

  // READ METHODS
  Future<List<SQLModelExpense>> readAll(Database db) async {
    final List<Map<String, dynamic>> results = await db.query(_tableName);
    List<SQLModelExpense> data = [];
    for (final result in results) {
      data.add(SQLModelExpense.fromMap(result));
    }
    return data;
  }
  Future<List<SQLModelExpense>> readWeeklyByCategoryId(int categoryId, DateTime startDate, {required Database db, required SortirTransaksi sortirBy}) async {
    // Hitung tanggal akhir, seminggu setelah tanggal awal
    DateTime endDate = startDate.add(const Duration(days: 6));
    
    // Format tanggal ke format yang sesuai dengan format tanggal di database
    String formattedStartDate = startDate.toIso8601String().substring(0, 10);
    String formattedEndDate = endDate.toIso8601String().substring(0, 10);

    // Gunakan enum SortirTransaksi untuk menentukan klausa ORDER BY
    String sortirByClause;
    switch (sortirBy) {
      case SortirTransaksi.Terbaru:
        sortirByClause = " ORDER BY waktu DESC";
        break;
      case SortirTransaksi.Terlama:
        sortirByClause = " ORDER BY waktu ASC";
        break;
      case SortirTransaksi.Tertinggi:
        sortirByClause = " ORDER BY waktu ASC";
        break;
      case SortirTransaksi.Terendah:
        sortirByClause = " ORDER BY nilai DESC";
        break;
      default:
        sortirByClause = "ORDER BY id DESC"; // Default tidak ada pengurutan
    }

  // Query database untuk mendapatkan data pengeluaran dalam rentang waktu seminggu berdasarkan ID kategori
  List<Map<String, dynamic>> results = await db.rawQuery(
    "SELECT * FROM $_tableName WHERE id_kategori = $categoryId AND strftime('%Y-%m-%d', waktu) BETWEEN '$formattedStartDate' AND '$formattedEndDate'$sortirByClause"
  );

  // Konversi hasil query menjadi list model SQLModelPengeluaran
  List<SQLModelExpense> data = results.map((map) => SQLModelExpense.fromMap(map)).toList();
  return data;
}
  Future<List<SQLModelExpense>> readByWaktuAndSortir(WaktuTransaksi waktuTransaksi, SortirTransaksi sortirTransaksi, {required Database db}) async {
      String query = "";
      String sortirByClause = "";

      switch (waktuTransaksi) {
        case WaktuTransaksi.Mingguan:
          DateTime startDate = DateTime.now().subtract(Duration(days: DateTime.now().weekday - 1));
          query = "SELECT * FROM $_tableName WHERE strftime('%Y-%m-%d', waktu) BETWEEN '${startDate.toIso8601String().substring(0, 10)}' AND '${DateTime.now().toIso8601String().substring(0, 10)}'";
          break;
        case WaktuTransaksi.Bulanan:
          DateTime firstDayOfMonth = DateTime(DateTime.now().year, DateTime.now().month, 1);
          query = "SELECT * FROM $_tableName WHERE strftime('%Y-%m-%d', waktu) BETWEEN '${firstDayOfMonth.toIso8601String().substring(0, 10)}' AND '${DateTime.now().toIso8601String().substring(0, 10)}'";
          break;
        case WaktuTransaksi.Tahunan:
          DateTime firstDayOfYear = DateTime(DateTime.now().year, 1, 1);
          query = "SELECT * FROM $_tableName WHERE strftime('%Y-%m-%d', waktu) BETWEEN '${firstDayOfYear.toIso8601String().substring(0, 10)}' AND '${DateTime.now().toIso8601String().substring(0, 10)}'";
          break;
      }

      switch (sortirTransaksi) {
        case SortirTransaksi.Terbaru:
          sortirByClause = " ORDER BY waktu DESC";
          break;
        case SortirTransaksi.Terlama:
          sortirByClause = " ORDER BY waktu ASC";
          break;
        case SortirTransaksi.Tertinggi:
          sortirByClause = " ORDER BY waktu ASC";
          break;
        case SortirTransaksi.Terendah:
          sortirByClause = " ORDER BY nilai DESC";
          break;
        default:
          sortirByClause = ""; // Default tidak ada pengurutan
      }

      query += sortirByClause;

      List<Map<String, dynamic>> results = await db.rawQuery(query);
      List<SQLModelExpense> data = results.map((map) => SQLModelExpense.fromMap(map)).toList();
      return data;
    }
  Future<List<SQLModelExpense>> readByWalletId(int id, Database db) async {
    final results  = (await db.rawQuery("SELECT * FROM $_tableName WHERE id_wallet = ?", [id]));
    return results.map((e) => SQLModelExpense.fromMap(e)).toList();
  }
  Future<List<SQLModelExpense>> readWeekly({required Database db}) async {
    DateTime now = DateTime.now();
    DateTime startDate = now.subtract(Duration(days: now.weekday - 1)); // Minggu ini dimulai dari hari Senin
    DateTime endDate = startDate.add(const Duration(days: 6)); // Minggu ini berakhir pada hari Minggu
    String formattedStartDate = startDate.toIso8601String().substring(0, 10);
    String formattedEndDate = endDate.toIso8601String().substring(0, 10);
    List<Map<String, dynamic>> results = await db.rawQuery(
      "SELECT * FROM $_tableName WHERE strftime('%Y-%m-%d', waktu) BETWEEN '$formattedStartDate' AND '$formattedEndDate'"
    );

    List<SQLModelExpense> data = results.map((map) => SQLModelExpense.fromMap(map)).toList();
    return data;
  }
  Future<List<SQLModelExpense>> readWithClause({required String clause, required Database db}) async {
      final List<Map<String, dynamic>> results = await db.query(
        _tableName,
        where: clause,
      );
      List<SQLModelExpense> data = [];
      for (final result in results) {
        data.add(SQLModelExpense.fromMap(result));
      }
      return data;
  }
  Future<List<SQLModelExpense>> readDataByMonth(int year, int month, {required Database db}) async {
    String formattedMonth = month < 10 ? '0$month' : '$month';
    String startDate = '$year-$formattedMonth-01';
    String endDate = '$year-$formattedMonth-31'; // Anda bisa memperbarui ini sesuai dengan bulan tertentu

    List<Map<String, dynamic>> results = await db.rawQuery(
      "SELECT * FROM $_tableName WHERE strftime('%Y-%m-%d', waktu) BETWEEN '$startDate' AND '$endDate'"
    );

    List<SQLModelExpense> data = results.map((map) => SQLModelExpense.fromMap(map)).toList();
    return data;
  }
  Future<List<SQLModelExpense>> readDataByDate(DateTime tanggal, {required Database db}) async {
    String formattedDate = tanggal.toIso8601String().substring(0, 10);
    List<Map<String, dynamic>> results = await db.rawQuery(
      "SELECT * FROM $_tableName WHERE waktu LIKE '$formattedDate%'"
    );

    List<SQLModelExpense> data = results.map((map) => SQLModelExpense.fromMap(map)).toList();
    return data;
  }
  Future<List<SQLModelExpense>> readDataByYear(int year, {required Database db}) async {
    List<Map<String, dynamic>> results = await db.rawQuery(
      "SELECT * FROM $_tableName WHERE strftime('%Y', waktu) = '$year'"
    );

    List<SQLModelExpense> data = results.map((map) => SQLModelExpense.fromMap(map)).toList();
    return data;
  }

  // INSERT METHODS
  Future<int> insert(SQLModelExpense data, {required Database db}) async {
    return 
    await db.rawInsert(
      "INSERT INTO $_tableName(id_kategori, id_wallet, waktu, judul, deskripsi, nilai, rating) VALUES(?,?,?,?,?,?,? )", 
      [data.id_kategori, data.id_wallet, data.waktu.toIso8601String(), data.judul, data.deskripsi, data.nilai, data.rating]
    );
  }

  // DELETE METHOD
  /// Fungsi ini akan menghapus pengeluaran yang memiliki id = id
  Future<int> delete(int id, {required Database db}) async {
    return await db.delete(_tableName, where: "id = ?", whereArgs: [id]);
  }
  Future<int> deleteAllByWalletId(int walletId, Database db) async {
    return await db.delete(_tableName, where: "id_wallet = ?", whereArgs: [walletId]);
  }
  
  /// Fungsi ini akan menghapus semua pengeluaran yang memiliki id wallet = idwallet
  Future<int> deleteByWalletId(int idWallet, {required Database db}) async {
    return await db.delete(_tableName, where: "id_wallet = ?", whereArgs: [idWallet]);
  }
  
  // UPDATE METHOD
  Future<int> update(SQLModelExpense newData, {required Database db}) async {
    return await db.update(_tableName, newData.toMap(),
        where: "id = ?", whereArgs: [newData.id]);
  }
}