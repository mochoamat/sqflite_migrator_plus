import 'package:sqflite/sqflite.dart';
import 'package:sqflite_migrator_plus/framework/migration_plus_class.dart';

class DbMigratorInitializer {
  final String dbName;
  final List<MigrationPlus> migrations;

  DbMigratorInitializer({required this.dbName, required this.migrations});

  Future<Database> openAndRunMigrations() async {
    return await openDatabase(
      dbName,
      version: migrations.length,
      onCreate: (db, version) async {
        for (var migration in migrations) {
          await migration.execute(db);
        }
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        for (int i = oldVersion; i < newVersion; i++) {
          await migrations[i].execute(db);
        }
      },
    );
  }
}
