import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Database? _database;

  // ignore: non_constant_identifier_names
  String USER_BALANCE = 'user_balance';
  // ignore: non_constant_identifier_names
  String TRANSACTIONS_TABLE = 'transactions';

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = join(directory.path, 'dayang.db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE user_balance (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          balance REAL NOT NULL DEFAULT 0.0,
          init BOOLEAN NOT NULL DEFAULT 0,
          income REAL NOT NULL DEFAULT 0.0,
          expenses REAL NOT NULL DEFAULT 0.0
      );
      CREATE TABLE transactions (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          description TEXT NOT NULL,
          amount REAL NOT NULL,
          date TEXT NOT NULL,
          current_balance REAL NOT NULL
      );
    ''');
  }

  Future<int> saveBalance(double balance) async {
    final db = await database;
    return await db.insert(USER_BALANCE, {'balance': balance, 'init': 1});
  }

  Future<Map<String, dynamic>> getBalance() async {
    final db = await database;
    List<Map<String, dynamic>> balances = await db.query(USER_BALANCE);
    return balances.isEmpty ? {'balance': 0.0, 'init': 0} : balances.first;
  }
}
