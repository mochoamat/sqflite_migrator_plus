import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart' as sqflite_ffi;
import 'package:sqflite_migrator_plus/framework/migration_plus_class.dart';

class DbMigratorInitializer {
  final String dbName;
  final List<MigrationPlus> migrations;
  final Function(Database db)? onConfigure;
  final Function(Database db)? onOpen;
  final bool readOnly;
  final bool singleInstance;

  DbMigratorInitializer({
    required this.dbName,
    required this.migrations,
    this.onConfigure,
    this.onOpen,
    this.readOnly = false,
    this.singleInstance = true,
  });

  Future<Database> openAndRunMigrations() async {
    if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      // On desktop platforms (Windows, Linux, macOS), use sqflite_ffi
      sqflite_ffi.sqfliteFfiInit();
      databaseFactory = sqflite_ffi.databaseFactoryFfi;
    }

    return await openDatabase(
      dbName,
      version: migrations.length,
      onConfigure: onConfigure,
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
      onOpen: onOpen,
      readOnly: readOnly,
      singleInstance: singleInstance,
    );
  }
}
