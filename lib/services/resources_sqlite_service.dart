// models
import '../models/resource.dart';

// packages
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ResourcesSqliteService {
  Future initializeDB() async {
    String path = await getDatabasesPath();

    return openDatabase(join(path, 'database.db'), version: 1);
  }

  Future<void> insertResource(Resource resource) async {
    final Database db = await initializeDB();
    await db.insert(
      'Resources',
      resource.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Resource>> getResources(type) async {
    final Database db = await initializeDB();

    final List<Map<String, dynamic>> queryResult = type == null
        ? await db.query('Resources')
        : await db.query('Resources', where: 'type = ?', whereArgs: [type]);

    return List.generate(queryResult.length, (index) {
      return Resource(
        id: queryResult[index]['id'],
        title: queryResult[index]['title'],
        type: queryResult[index]['type'],
        icon: queryResult[index]['icon'],
        color: queryResult[index]['color'],
      );
    });
  }

  Future<void> updateResource(Resource resource) async {
    final db = await initializeDB();

    return await db.update('Resources', db.toMap(),
        where: 'id = ?', whereArgs: [resource.id]);
  }

  Future<void> deleteResource(int id) async {
    final db = await initializeDB();

    return await db.delete('Resources', where: 'id = ?', whereArgs: [id]);
  }
}
