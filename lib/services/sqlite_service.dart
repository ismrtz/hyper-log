// packages
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqliteService {
  Future initializeDB() async {
    String path = await getDatabasesPath();

    return openDatabase(join(path, 'database.db'),
        onCreate: (database, version) async {
      await database.execute(
          'CREATE TABLE Categories(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT NOT NULL, type INTEGER NOT NULL, icon INTEGER NOT NULL, color TEXT NOT NULL)');
      await database.execute(
          'CREATE TABLE Resources(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT NOT NULL, type INTEGER NOT NULL, icon INTEGER NOT NULL, color TEXT NOT NULL, card TEXT, account TEXT)');
      await database.execute(
          'CREATE TABLE Transactions(id INTEGER PRIMARY KEY AUTOINCREMENT, amount INTEGER NOT NULL, categoryId INTEGER NOT NULL, resourceId INTEGER NOT NULL, createdAt DATETIME NOT NULL, description TEXT, FOREIGN KEY (categoryId) REFERENCES Categories(id), FOREIGN KEY (resourceId) REFERENCES Resources(id))');
    }, version: 1);
  }
}
