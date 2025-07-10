import 'package:sqflite_migrator_plus/migration_generator/alter_column_type.dart';
import 'package:sqflite_migrator_plus/migration_generator/column_def.dart';

import 'statement_generator_base.dart';

class CreateTableGenerator extends StatementGeneratorBase {
  CreateTableGenerator(super.tableName, super.columns);

  @override
  List<String> getSqlStatements() {
    var lines = <String>[];
    String stmt = 'CREATE TABLE $tableName (';
    String closingStmt = ');';

    lines.add(stmt);
    for (var x = 0; x < columns.length; x++) {
      var colDef = _genColumn(columns.elementAt(x), x == columns.length - 1);
      lines.add(colDef);
    }
    lines.add(closingStmt);

    return [lines.join('\n')];
  }

  String _genColumn(ColumnDef col, bool isLast) {
    return '${col.columnName} ${col.type.name.toUpperCase()} ${getColumnSpec(col)}${isLast ? '' : ','}';
  }
}

class AlterTableGenerator extends StatementGeneratorBase {
  final String? newTableName;

  AlterTableGenerator(super.tableName, super.columns, {this.newTableName});

  @override
  List<String> getSqlStatements() {
    var lines = <String>[];
    String alterStmt = 'ALTER TABLE $tableName';

    if (newTableName != null) {
      lines.add('$alterStmt RENAME TO $newTableName;');
    }

    for (var col in columns) {
      lines.add('$alterStmt ${_genColumn(col)};');
    }

    return lines;
  }

  String _genColumn(ColumnDef col) {
    switch (col.alterColumnType) {
      case AlterColumnType.add:
        return 'ADD COLUMN ${col.columnName} ${col.type.name.toUpperCase()} ${getColumnSpec(col)}';

      case AlterColumnType.rename:
        if (col.newColumnName == null) {
          throwMigrationException('newColumnName is null. Required when renamin the column');
        }

        return 'RENAME COLUMN ${col.columnName} TO ${col.newColumnName}';

      case AlterColumnType.drop:
        return 'DROP COLUMN ${col.columnName}';

      default:
        throwMigrationException('alterColumnType is invalid');
    }

    return '';
  }
}
