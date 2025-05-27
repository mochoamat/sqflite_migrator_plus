import 'package:sqflite_migrator_plus/migration_generator/foreingkey_action_helper.dart';

import 'column_def.dart';

abstract class StatementGeneratorBase {
  final String tableName;
  final List<ColumnDef> columns;

  StatementGeneratorBase(this.tableName, this.columns);

  String getSqlStatement();

  String getColumnSpec(ColumnDef col) {
    String spec = '';

    spec += col.isPrimaryKey ? ' PRIMARY KEY' : '';
    spec += col.isUnique ? ' UNIQUE' : '';
    spec += col.isAutoIncrement ? ' AUTOINCREMENT' : '';
    spec += col.isNotNull ? ' NOT NULL' : ' NULL';

    if (col.defaultValue != null) {
      spec += ' DEFAULT ${col.defaultValue}';
    }

    if (col.foreingKey != null) {
      var fk = col.foreingKey!;
      spec += ' REFERENCES ${fk.table} (${fk.column})';

      if (fk.foreingKeyOnUpdate != null) {
        spec += ' ON UPDATE ${ForeingkeyActionHelper.getActionString(fk.foreingKeyOnUpdate)}';
      }

      if (fk.foreingKeyOnDelete != null) {
        spec += ' ON DELETE ${ForeingkeyActionHelper.getActionString(fk.foreingKeyOnDelete)}';
      }
    }

    return spec;
  }

  void throwMigrationException(String param) {
    throw ArgumentError('MigrationPlus generating SQL exception: $param');
  }
}
