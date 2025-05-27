import 'foreingkey_actions.dart';

class ForeingkeyRef {
  final String table;
  final String column;
  final ForeingkeyActions? foreingKeyOnDelete;
  final ForeingkeyActions? foreingKeyOnUpdate;

  const ForeingkeyRef({
    required this.table,
    required this.column,
    this.foreingKeyOnDelete,
    this.foreingKeyOnUpdate,
  });
}
