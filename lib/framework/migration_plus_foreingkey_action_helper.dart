import 'package:sqflite_migrator_plus/framework/migration_plus_foreingkey_actions.dart';

class MigrationPlusForeingkeyActionHelper {
  static String getActionString(MigrationPlusForeingkeyActions? action) {
    switch (action) {
      case MigrationPlusForeingkeyActions.noAction:
        return 'NO ACTION';
      case MigrationPlusForeingkeyActions.restrict:
        return 'RESTRICT';
      case MigrationPlusForeingkeyActions.setNull:
        return 'SET NULL';
      case MigrationPlusForeingkeyActions.setDefault:
        return 'SET DEFAULT';
      case MigrationPlusForeingkeyActions.cascade:
        return 'CASCADE';
      default:
        throw ArgumentError('Unknown Foreingkey Action: $action');
    }
  }
}
