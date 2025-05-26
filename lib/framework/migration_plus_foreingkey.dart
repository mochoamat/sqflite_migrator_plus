import 'migration_plus_foreingkey_actions.dart';

class MigrationPlusForeingkey {
  final String table;
  final String column;
  final MigrationPlusForeingkeyActions? foreingKeyOnDelete;
  final MigrationPlusForeingkeyActions? foreingKeyOnUpdate;

  const MigrationPlusForeingkey({
    required this.table,
    required this.column,
    this.foreingKeyOnDelete,
    this.foreingKeyOnUpdate,
  });
}
