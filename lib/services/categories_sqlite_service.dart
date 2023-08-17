// packages
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

// models
import 'package:hyper_log/models/category.dart';

class CategoriesSqliteService {
  Future initializeDB() async {
    String path = await getDatabasesPath();

    return openDatabase(join(path, 'database.db'), version: 1);
  }

  Future<void> insertCategory(Category category) async {
    final Database db = await initializeDB();

    await db.insert(
      'Categories',
      category.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Category>> getCategories(type) async {
    final Database db = await initializeDB();

    final List<Map<String, dynamic>> queryResult = type == null
        ? await db.query('Categories')
        : await db.query('Categories', where: 'type = ?', whereArgs: [type]);

    return List.generate(queryResult.length, (index) {
      return Category(
        id: queryResult[index]['id'],
        title: queryResult[index]['title'],
        type: queryResult[index]['type'],
        icon: queryResult[index]['icon'],
        color: queryResult[index]['color'],
      );
    });
  }

  Future<void> updateCategory(Category category) async {
    final db = await initializeDB();

    return await db.update('Categories', db.toMap(),
        where: 'id = ?', whereArgs: [category.id]);
  }

  Future<void> deleteCategory(int id) async {
    final db = await initializeDB();

    return await db.delete('Categories', where: 'id = ?', whereArgs: [id]);
  }
}
