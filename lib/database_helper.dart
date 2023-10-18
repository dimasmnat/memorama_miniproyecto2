import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), 'memorama_database.db');
    return await openDatabase(path, version: 1, onCreate: _createDatabase);
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE records(
        id INTEGER PRIMARY KEY,
        level INTEGER,
        time INTEGER
      )
    ''');
  }

  Future<void> insertRecord(int level, int time) async {
    Database db = await database;
    await db.insert('records', {'level': level, 'time': time});
  }

  Future<int> getMinTime(int level) async {
    Database db = await database;
    List<Map<String, dynamic>> records = await db.rawQuery(
        'SELECT MIN(time) AS minTime FROM records WHERE level = ?', [level]);
    return records[0]['minTime'] ?? 0;
  }
}
