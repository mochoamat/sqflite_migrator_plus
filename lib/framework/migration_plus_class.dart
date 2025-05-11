import 'package:sqflite/sqflite.dart';

abstract class MigrationPlus {
  Future<void> execute(Database db);
}
