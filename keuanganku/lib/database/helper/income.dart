import 'package:keuanganku/database/model/income.dart'; // Ganti dengan lokasi file yang benar
import 'package:keuanganku/enum/data_transaksi.dart';
import 'package:sqflite/sqflite.dart';
typedef FutureListPemasukan = Future<List<SQLModelIncome>>;

class SQLHelperIncome {
  static Future createTable(Database db) async {
    await db.execute(SQLHelperIncome().sqlCreateQuery);
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

  final _tableName = "income";
  
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
  FutureListPemasukan readWithClause({required String clause, required Database db}) async {
    final List<Map<String, dynamic>> results = await db.query(
      _tableName,
      where: clause,
    );
    List<SQLModelIncome> data = [];
    for (final result in results) {
      data.add(SQLModelIncome.fromMap(result));
    }
    return data;
  }
  FutureListPemasukan readDataByMonth(int year, int month, {required Database db}) async {
    String formattedMonth = month < 10 ? '0$month' : '$month';
    String startDate = '$year-$formattedMonth-01';
    String endDate = '$year-$formattedMonth-31'; // Sesuaikan dengan bulan tertentu

    List<Map<String, dynamic>> results = await db.rawQuery(
      "SELECT * FROM $_tableName WHERE strftime('%Y-%m-%d', waktu) BETWEEN '$startDate' AND '$endDate'"
    );

    List<SQLModelIncome> data = results.map((map) => SQLModelIncome.fromMap(map)).toList();
    return data;
  }
  FutureListPemasukan readDataByDate(DateTime tanggal, {required Database db}) async {
    String formattedDate = tanggal.toIso8601String().substring(0, 10);
    List<Map<String, dynamic>> results = await db.rawQuery(
      "SELECT * FROM $_tableName WHERE waktu LIKE '$formattedDate%'"
    );

    List<SQLModelIncome> data = results.map((map) => SQLModelIncome.fromMap(map)).toList();
    return data;
  }
  FutureListPemasukan readDataByYear(int year, {required Database db}) async {
    List<Map<String, dynamic>> results = await db.rawQuery(
      "SELECT * FROM $_tableName WHERE strftime('%Y', waktu) = '$year'"
    );

    List<SQLModelIncome> data = results.map((map) => SQLModelIncome.fromMap(map)).toList();
    return data;
  }
  FutureListPemasukan readDataByWalletId(int walletId, Database db) async {
    final data = await db.query(_tableName, where: "id_wallet = $walletId");
    return data.map((e) => SQLModelIncome.fromMap(e)).toList();
  }
  FutureListPemasukan readAll({required Database db}) async {
    return (await db.query(_tableName)).map((e) => SQLModelIncome.fromMap(e)).toList();
  }
  FutureListPemasukan readWeekly(DateTime startDate, {required Database db, required SortirTransaksi sortirBy}) async {
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
        sortirByClause = ""; // Default tidak ada pengurutan
    }

    // Query database untuk mendapatkan data pemasukan dalam rentang waktu seminggu
    List<Map<String, dynamic>> results = await db.rawQuery(
      "SELECT * FROM $_tableName WHERE strftime('%Y-%m-%d', waktu) BETWEEN '$formattedStartDate' AND '$formattedEndDate'$sortirByClause"
    );

    // Konversi hasil query menjadi list model SQLModelPemasukan
    List<SQLModelIncome> data = results.map((map) => SQLModelIncome.fromMap(map)).toList();
    return data;
  }
  FutureListPemasukan readWeeklyByCategoryId(int categoryId, DateTime startDate, {required Database db, required SortirTransaksi sortirBy}) async {
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
        sortirByClause = ""; // Default tidak ada pengurutan
    }

    // Query database untuk mendapatkan data pemasukan dalam rentang waktu seminggu berdasarkan ID kategori
    List<Map<String, dynamic>> results = await db.rawQuery(
      "SELECT * FROM $_tableName WHERE id_kategori = $categoryId AND strftime('%Y-%m-%d', waktu) BETWEEN '$formattedStartDate' AND '$formattedEndDate'$sortirByClause"
    );

    // Konversi hasil query menjadi list model SQLModelPemasukan
    List<SQLModelIncome> data = results.map((map) => SQLModelIncome.fromMap(map)).toList();
    return data;
  }
  FutureListPemasukan readByWaktuAndSortir(WaktuTransaksi waktuTransaksi, SortirTransaksi sortirTransaksi, {required Database db}) async {
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
    List<SQLModelIncome> data = results.map((map) => SQLModelIncome.fromMap(map)).toList();
    return data;
  }
  Future<dynamic> readByCategoryId({
    required Database db,
    required int idKategori,
    bool countOnly = false,
  }) async {
    if (countOnly) {
      // Jika countOnly bernilai true, maka lakukan perhitungan jumlah data
      final result = await db.rawQuery(
        "SELECT COUNT(*) FROM $_tableName WHERE id_kategori = $idKategori",
      );
      return result[0]["COUNT(*)"];
    } else {
      // Jika countOnly bernilai false, maka ambil data sesuai kategori
      final List<Map<String, dynamic>> results = await db.rawQuery(
        "SELECT * FROM $_tableName WHERE id_kategori = $idKategori",
      );
      List<SQLModelIncome> data = results.map((map) => SQLModelIncome.fromMap(map)).toList();
      return data;
    }
  }
  
  // CREATE METHODS
  Future<int> insert(SQLModelIncome data, Database db) async {
    return 
    await db.rawInsert(
      "INSERT INTO $_tableName(id_kategori, id_wallet, waktu, judul, deskripsi, nilai) VALUES(?,?,?,?,?,?)", 
      [data.id_kategori, data.id_wallet, data.waktu.toIso8601String(), data.judul, data.deskripsi, data.nilai]
    );
  }

  // DELETE METHOD
  Future<int> delete(int id, Database db) async {
    return await db.delete(_tableName, where: "id = ?", whereArgs: [id]);
  }
  Future<int> deleteAllByWalletId(int walletId, Database db) async {
    return await db.delete(_tableName, where: "id_wallet = ?", whereArgs: [walletId]);
  }
  
  // UPDATE METHOD
  Future<int> update(SQLModelIncome data, Database db) async {
    return await db.update(
      _tableName,
      data.toMap(),
      where: "id = ?",
      whereArgs: [data.id],
    );
  }
}
