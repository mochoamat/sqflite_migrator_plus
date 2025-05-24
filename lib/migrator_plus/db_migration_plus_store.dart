import 'package:sqflite/sqflite.dart';

const String migrationsTable = 'migrations';
const String migrationField = 'class_name';

class DbMigrationPlusStore {
  static Future<void> createMigrationTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS $migrationsTable (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        $migrationField TEXT UNIQUE
      )
    ''');
  }

  static Future<void> save(Database db, String description) async {
    await db.insert(migrationsTable, {migrationField: description});
  }

  static Future<List<String>> getAllMigrations(Database db) async {
    final List<Map<String, dynamic>> results = await db.query(migrationsTable);

    return results
        .map(
          (row) => row[migrationField] as String,
        )
        .toList();
  }
}
