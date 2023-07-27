// packages
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqliteService {
  Future initializeDB() async {
    String path = await getDatabasesPath();

    return openDatabase(join(path, 'database.db'),
        onCreate: (database, version) async {
      await database.execute(
          'CREATE TABLE Resources(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT NOT NULL, type INTEGER NOT NULL, icon INTEGER NOT NULL, color TEXT NOT NULL, card TEXT, account TEXT)');
      await database.execute(
          'CREATE TABLE Categories(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT NOT NULL, type INTEGER NOT NULL, icon INTEGER NOT NULL, color TEXT NOT NULL)');
    }, version: 1);
  }
}
