import 'package:depi/ExpenseTracker/expenseModel.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';


class SqliteDatabase {

  static late Database database;
  static const String tableName = "ExpenseTracker";

  static Future<void> initDatabase() async {
    // Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'expenseTracker.db');

    // Delete the database
    // await deleteDatabase(path);

    // open the database
    database = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        // When creating the db, create the table
        await db.execute(
          'CREATE TABLE $tableName (id INTEGER PRIMARY KEY AUTOINCREMENT, date TEXT, amount REAL, category TEXT, note TEXT)',
        );
      },
    );
  }

  static Future<void> insertNewExpense(ExpenseModel expense) async {
    await database.insert(
      tableName,
      expense.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print(expense.toMap());
  }


  static Future<void> updateExpense(ExpenseModel expense) async {
    await database.update(
      tableName,
      expense.toMap(),
      where: 'id = ?',
      whereArgs: [expense.id],
    );
  }

  static Future<void> clear() async {
    await database.delete(tableName);
  }


  static Future<void> deleteExpense(ExpenseModel expense) async {
    await database.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [expense.id],
    );
  }


  static Future<List<ExpenseModel>> getAllExpense() async {
    final List<Map<String,dynamic>> maps = await database.query(tableName);
    return maps.map((e) =>ExpenseModel.fromMap(e)).toList();
  }


}