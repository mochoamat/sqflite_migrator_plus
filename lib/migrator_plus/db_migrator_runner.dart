import 'package:sqflite/sqflite.dart';
import 'package:sqflite_migrator_plus/framework/migration_plus_class.dart';
import 'package:sqflite_migrator_plus/migrator_plus/db_migration_plus_store.dart';

class DbMigratorRunner {
  final List<MigrationPlus> migrationList;

  DbMigratorRunner({required this.migrationList});

  Future<void> runMigrations(Database db) async {
    await DbMigrationPlusStore.createMigrationTable(db);

    final savedMigrations = await DbMigrationPlusStore.getAllMigrations(db);

    for (var migration in migrationList) {
      var migrationName = migration.runtimeType.toString();

      if (!savedMigrations.contains(migrationName)) {
        await migration.execute(db);
        await DbMigrationPlusStore.save(db, migrationName);
      }
    }
  }
}
