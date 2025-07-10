class CreateIndexGenerator {
  /// The indexName is by convention compounded by "table_name + _ + name + _idx"
  ///
  /// If not provided it's generated automatically using onTableName and each indexedColumn
  ///
  /// In example:
  /// - table: products
  /// - name [may be column name]: cliendId
  /// - prefix: _idx
  ///
  /// ** Index Name = products_clientId_idx
  String? indexName;
  String onTableName;
  bool unique;
  bool ifNotExist;
  List<String> indexedColumns;
  String? where;

  CreateIndexGenerator({
    this.indexName,
    required this.onTableName,
    this.unique = false,
    this.ifNotExist = false,
    required this.indexedColumns,
    this.where,
  }) {
    // ignore: prefer_interpolation_to_compose_strings
    indexName ??= onTableName + '_' + indexedColumns.join('_') + '_idx';
  }

  String getSqlStatement() {
    var lines = <String>[];
    String stmt =
        'CREATE ${unique ? 'UNIQUE' : ''} INDEX ${ifNotExist ? 'IF NOT EXIST' : ''} $indexName ON $onTableName (';
    String closingStmt = ') ${where != null ? 'WHERE $where' : ''};';

    lines.add(stmt);
    lines.add(indexedColumns.join(', '));
    lines.add(closingStmt);

    return lines.join('\n');
  }
}

class DropIndexGenerator {
  String indexName;
  bool ifExist;

  DropIndexGenerator({
    required this.indexName,
    this.ifExist = false,
  });

  String getSqlStatement() {
    String stmt = 'DROP INDEX ${ifExist ? 'IF EXIST' : ''} $indexName';

    return stmt;
  }
}
