import 'package:dayang/types.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Database? _database;

  // ignore: non_constant_identifier_names
  String USER_BALANCE = 'user_balance';
  // ignore: non_constant_identifier_names
  String TRANSACTIONS_TABLE = 'transactions';
  // ignore: non_constant_identifier_names
  String CATEGORIES_TABLE = 'categories';

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
    ''');
    await db.execute('''
      CREATE TABLE categories (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT NOT NULL UNIQUE
      );
    ''');
    await db.execute('''
      INSERT INTO categories (name) VALUES 
        ('Uncategorized'),
        ('Salary'),
        ('Rent/Mortgage'),
        ('Utilities'),
        ('Food & Groceries'),
        ('Transportation'),
        ('Entertainment'),
        ('Medical'),
        ('Savings'),
        ('Education'),
        ('Travel'),
        ('Donations'),
        ('Miscellaneous');
    ''');
    await db.execute('''
      CREATE TABLE budgets (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          category_id INTEGER NOT NULL,
          limit_amount REAL NOT NULL CHECK(limit_amount >= 0), 
          period TEXT NOT NULL CHECK(period IN ('daily', 'weekly', 'monthly', 'yearly')),
          FOREIGN KEY (category_id) REFERENCES categories(id) ON DELETE CASCADE
      );
    ''');
    await db.execute('''
      CREATE TABLE transactions (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          description TEXT NOT NULL,
          amount REAL NOT NULL,
          date TEXT NOT NULL,
          current_balance REAL NOT NULL,
          category_id INTEGER NOT NULL,
          FOREIGN KEY (category_id) REFERENCES categories(id) ON DELETE SET NULL
      );
    ''');
  }

  Future<int> saveBalance(double balance) async {
    final db = await database;
    return await db.insert(USER_BALANCE, {'balance': balance, 'init': 1});
  }

  Future<UserBalance> getBalance() async {
    final db = await database;
    List<Map<String, dynamic>> balances = await db.query(USER_BALANCE);
    return balances.isEmpty
        ? UserBalance(
          rawUserBalance: {
            'balance': 0.0,
            'init': 0,
            'income': 0.0,
            'expenses': 0.0,
          },
        )
        : UserBalance(rawUserBalance: balances.first);
  }

  Future<void> registerTransaction(
    double amount,
    String description,
    int categoryId,
  ) async {
    final db = await database;
    final UserBalance userBalance = await getBalance();

    Map<String, dynamic> data = {'balance': userBalance.balance + amount};

    if (amount >= 0) {
      data['income'] = userBalance.income + amount;
    } else {
      data['expenses'] = userBalance.expenses - amount;
    }

    await db.update(USER_BALANCE, data, where: 'id = 1');

    await db.insert(TRANSACTIONS_TABLE, {
      'description': description,
      'amount': amount,
      'date': DateTime.now().toString(),
      'current_balance': userBalance.balance,
      'category_id': categoryId,
    });
  }

  Future<List<UserTransaction>> getTransactions(int? limit) async {
    final db = await database;

    final List<Map<String, dynamic>> transactions = await db.rawQuery(
      '''SELECT t.id as id, description, amount, date, current_balance, name as category_name
      FROM $TRANSACTIONS_TABLE as t
      INNER JOIN $CATEGORIES_TABLE as c ON t.category_id = c.id
      ORDER BY date DESC
      ${limit != null ? "LIMIT ?" : ""};''',
      limit != null ? [limit] : [],
    );

    return transactions.map((transaction) {
      return UserTransaction(rawTransaction: transaction);
    }).toList();
  }

  Future<List<UserCategory>> getCategories() async {
    final db = await database;

    List<Map<String, dynamic>> categories = await db.query(CATEGORIES_TABLE);

    return categories.map((category) {
      return UserCategory(rawCategory: category);
    }).toList();
  }
}
