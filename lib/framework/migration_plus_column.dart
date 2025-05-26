import 'package:sqflite_migrator_plus/framework/migration_plus_alter_column_type.dart';
import 'package:sqflite_migrator_plus/framework/migration_plus_column_types.dart';
import 'package:sqflite_migrator_plus/framework/migration_plus_foreingkey.dart';

class MigrationPlusColumn {
  final String columnName;
  final MigrationPlusColumnTypes type;
  final bool isPrimaryKey;
  final bool isUnique;
  final bool isAutoIncrement;
  final bool isNotNull;
  final String? defaultValue;
  final MigrationPlusForeingkey? foreingKey;
  final MigrationPlusAlterColumnType? alterColumnType;
  final String? newColumnName;

  MigrationPlusColumn({
    required this.columnName,
    required this.type,
    this.isPrimaryKey = false,
    this.isUnique = false,
    this.isAutoIncrement = false,
    this.isNotNull = true,
    this.defaultValue,
    this.foreingKey,
    this.alterColumnType,
    this.newColumnName,
  });
}
