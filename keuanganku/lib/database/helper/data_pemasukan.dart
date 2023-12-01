import 'package:keuanganku/database/model/data_pemasukan.dart'; // Ganti dengan lokasi file yang benar
import 'package:keuanganku/database/model/data_pengeluaran.dart';
import 'package:keuanganku/enum/data_transaksi.dart';
import 'package:sqflite/sqflite.dart';

class SQLDataPemasukan {
  Future createTable(Database db) async {
    await db.execute(SQLDataPemasukan().sqlCreateQuery);
  }

  final Map<String, Map<String, String>> _table = {
    "id": {
      "name": "id",
      "type": "INTEGER",
      "constraint": "AUTO INCREMENT PRIMARY KEY",
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
      "constraint": "",
    },
  };

  final _tableName = "data_pemasukan";
  
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
  Future<List<ModelDataPemasukan>> readAll(Database db) async {
    final List<Map<String, dynamic>> results = await db.query(_tableName);
    List<ModelDataPemasukan> data = [];
    for (final result in results) {
      data.add(ModelDataPemasukan.fromMap(result));
    }
    return data;
  }

  Future<List<ModelDataPengeluaran>> readSpecific(WaktuTransaksi waktuTransaksi, Database db) async {
    String whereClause;

    switch (waktuTransaksi) {
      case WaktuTransaksi.MINGGUAN:
        DateTime now = DateTime.now();
        DateTime startOfWeek =
            now.subtract(Duration(days: now.weekday - 1)); // Monday
        DateTime endOfWeek = startOfWeek.add(const Duration(days: 6)); // Sunday

        whereClause = "waktu BETWEEN '${startOfWeek.toIso8601String()}' AND '${endOfWeek.toIso8601String()}'";
        break;
      case WaktuTransaksi.BULANAN:
        DateTime now = DateTime.now();
        DateTime startOfMonth = DateTime(now.year, now.month, 1);
        DateTime endOfMonth = DateTime(now.year, now.month + 1, 1)
            .subtract(const Duration(days: 1));

        whereClause =
            "waktu BETWEEN '${startOfMonth.toIso8601String()}' AND '${endOfMonth.toIso8601String()}'";
        break;
      case WaktuTransaksi.TAHUNAN:
        whereClause =
            "strftime('%Y', waktu) = strftime('%Y', 'now')";
        break;
      case WaktuTransaksi.SEMUANYA:
        whereClause = "";
        break;
      case WaktuTransaksi.KHUSUS:
        // Biarkan whereClause kosong untuk menangani kasus khusus
        whereClause = "";
        break;
      default:
        whereClause = "";
    }

    final List<Map<String, dynamic>> results = await db.query(
      _tableName,
      where: whereClause,
    );

    List<ModelDataPengeluaran> data = [];
    for (final result in results) {
      data.add(ModelDataPengeluaran.fromMap(result));
    }
    return data;
  }

  // CREATE METHODS
  Future<int> create(ModelDataPemasukan data, Database db) async {
    return 
    await db.rawInsert(
      "INSERT INTO $_tableName(id_kategori, id_wallet, waktu, judul, deskripsi, nilai) VALUES(?,?,?,?,?,?)", 
      [data.id_kategori, data.id_wallet, data.waktu.toIso8601String(), data.judul, data.deskripsi, data.nilai]
    );
  }
}
