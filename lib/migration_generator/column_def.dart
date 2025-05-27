import 'package:sqflite_migrator_plus/migration_generator/alter_column_type.dart';
import 'package:sqflite_migrator_plus/migration_generator/column_types.dart';
import 'package:sqflite_migrator_plus/migration_generator/foreingkey_ref.dart';

class ColumnDef {
  final String columnName;
  final ColumnTypes type;
  final bool isPrimaryKey;
  final bool isUnique;
  final bool isAutoIncrement;
  final bool isNotNull;
  final String? defaultValue;
  final ForeingkeyRef? foreingKey;
  final AlterColumnType? alterColumnType;
  final String? newColumnName;

  ColumnDef({
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
