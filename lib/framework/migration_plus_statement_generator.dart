import 'package:sqflite_migrator_plus/framework/migration_plus_alter_column_type.dart';
import 'package:sqflite_migrator_plus/framework/migration_plus_column.dart';

import 'migration_plus_statement_generator_base.dart';

class MigrationGeneratorCreateTable extends MigrationPlusStatementGeneratorBase {
  MigrationGeneratorCreateTable(super.tableName, super.columns);

  @override
  String getSqlStatement() {
    var lines = <String>[];
    String stmt = 'CREATE TABLE $tableName (';
    String closingStmt = ');';

    lines.add(stmt);
    for (var x = 0; x < columns.length; x++) {
      var colDef = _genColumn(columns.elementAt(x), x == columns.length - 1);
      lines.add(colDef);
    }
    lines.add(closingStmt);

    return lines.join('\n');
  }

  String _genColumn(MigrationPlusColumn col, bool isLast) {
    return '${col.columnName} ${col.type.name.toUpperCase()} ${getColumnSpec(col)}${isLast ? '' : ','}';
  }
}

class MigrationGeneratorAlterTable extends MigrationPlusStatementGeneratorBase {
  final String? newTableName;

  MigrationGeneratorAlterTable(super.tableName, super.columns, {this.newTableName});

  @override
  String getSqlStatement() {
    var lines = <String>[];
    String alterStmt = 'ALTER TABLE $tableName';

    if (newTableName != null) {
      lines.add('$alterStmt RENAME TO $newTableName;');
    }

    for (var col in columns) {
      lines.add('$alterStmt ${_genColumn(col)};');
    }

    return lines.join('\n');
  }

  String _genColumn(MigrationPlusColumn col) {
    switch (col.alterColumnType) {
      case MigrationPlusAlterColumnType.add:
        return 'ADD COLUMN ${col.columnName} ${col.type.name.toUpperCase()} ${getColumnSpec(col)}';

      case MigrationPlusAlterColumnType.rename:
        if (col.newColumnName == null) {
          throwMigrationException('newColumnName is null when renamin the column');
        }

        return 'RENAME COLUMN ${col.columnName} TO ${col.newColumnName}';

      case MigrationPlusAlterColumnType.drop:
        return 'DROP COLUMN ${col.columnName}';

      default:
        throwMigrationException('alterColumnType is invalid');
    }

    return '';
  }
}
