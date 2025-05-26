import 'package:sqflite_migrator_plus/framework/migration_plus_foreingkey_action_helper.dart';

import 'migration_plus_column.dart';

abstract class MigrationPlusStatementGeneratorBase {
  final String tableName;
  final List<MigrationPlusColumn> columns;

  MigrationPlusStatementGeneratorBase(this.tableName, this.columns);

  String getSqlStatement();

  String getColumnSpec(MigrationPlusColumn col) {
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
        spec += ' ON UPDATE ${MigrationPlusForeingkeyActionHelper.getActionString(fk.foreingKeyOnUpdate)}';
      }

      if (fk.foreingKeyOnDelete != null) {
        spec += ' ON DELETE ${MigrationPlusForeingkeyActionHelper.getActionString(fk.foreingKeyOnDelete)}';
      }
    }

    return spec;
  }

  void throwMigrationException(String param) {
    throw ArgumentError('MigrationPlus generating SQL exception: $param');
  }
}
