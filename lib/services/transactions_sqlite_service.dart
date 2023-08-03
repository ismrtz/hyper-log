// models
import 'package:hyper_log/models/transaction.dart' as model;

// packages
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class TransactionsSqliteService {
  Future initializeDB() async {
    String path = await getDatabasesPath();

    return openDatabase(join(path, 'database.db'), version: 1);
  }

  Future<void> insertTransaction(model.Transaction transaction) async {
    final Database db = await initializeDB();

    await db.insert(
      'Transactions',
      transaction.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<model.Transaction>> getTransactions(type) async {
    final Database db = await initializeDB();

    final List<Map<String, dynamic>> queryResult = type == null
        ? await db.query('Transactions')
        : await db.query('Transactions', where: 'type = ?', whereArgs: [type]);

    return List.generate(queryResult.length, (index) {
      return model.Transaction(
        id: queryResult[index]['id'],
        amount: queryResult[index]['amount'],
        categoryId: queryResult[index]['categoryId'],
        resourceId: queryResult[index]['resourceId'],
        createdAt: queryResult[index]['createdAt'],
        description: queryResult[index]['description'],
      );
    });
  }

  Future<List<Map>> getResourcesWithCredit(type) async {
    final Database db = await initializeDB();

    final List<Map<String, dynamic>> queryResult = type == null
        ? await db.rawQuery(
            'SELECT r.title, r.type, r.icon, r.color, r.card, r.account, SUM(amount) AS [amount] FROM Transactions txn JOIN Resources r ON r.id = txn.resourceId GROUP BY txn.resourceId, r.id')
        : await db.rawQuery(
            'SELECT r.title, r.icon, r.color, SUM(amount) AS [amount] FROM Transactions txn WHERE type = $type JOIN Resources r ON r.id = txn.resourceId GROUP BY txn.resourceId, r.id');
    return List.generate(
        queryResult.length,
        (index) => {
              'type': queryResult[index]['type'],
              'icon': queryResult[index]['icon'],
              'card': queryResult[index]['card'],
              'title': queryResult[index]['title'],
              'color': queryResult[index]['color'],
              'amount': queryResult[index]['amount'],
              'account': queryResult[index]['account'],
            });
  }

  Future<void> updateTransaction(model.Transaction transaction) async {
    final db = await initializeDB();

    return await db.update('Transactions', db.toMap(),
        where: 'id = ?', whereArgs: [transaction.id]);
  }

  Future<void> deleteTransaction(int id) async {
    final db = await initializeDB();

    return await db.delete('Transactions', where: 'id = ?', whereArgs: [id]);
  }
}
