import 'package:keuanganku/database/helper/income_category.dart';
import 'package:keuanganku/database/helper/expense_limiter.dart';
import 'package:keuanganku/database/helper/income.dart';
import 'package:keuanganku/database/helper/expense.dart';
import 'package:keuanganku/database/helper/expense_category.dart';
import 'package:keuanganku/database/helper/user_data.dart';
import 'package:keuanganku/database/helper/wallet.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  final String _databaseName = "keuanganku.db";
  final int _databaseVersion = 1;
  
  /// Pointer Database
  Database? _database;  

  /// Fungsi saat file database dibuat
  createTable(Database db, version){
    SQLHelperExpense.createTable(db);
    SQLHelperIncome.createTable(db);
    SQLHelperWallet.createTable(db);
    SQLHelperExpenseCategory.createTable(db: db);
    SQLHelperIncomeCategory.createTable(db: db);
    SQLHelperExpenseLimiter.createTable(db.database);
    SQLHelperUserData.createTable(db.database);
  }

  /// Panggil fungsi ini untuk satu kali saja disaat inisialisasi database
  Future<void> openDB() async {
    try {
      final path = join(await getDatabasesPath(), _databaseName);
      _database = await openDatabase(
        path,
        version: _databaseVersion,
        onCreate: createTable
      );
    } catch (e) {
      e;
    }
  }

  get database => _database;
}
