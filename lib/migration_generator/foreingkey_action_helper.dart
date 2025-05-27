import 'package:sqflite_migrator_plus/migration_generator/foreingkey_actions.dart';

class ForeingkeyActionHelper {
  static String getActionString(ForeingkeyActions? action) {
    switch (action) {
      case ForeingkeyActions.noAction:
        return 'NO ACTION';
      case ForeingkeyActions.restrict:
        return 'RESTRICT';
      case ForeingkeyActions.setNull:
        return 'SET NULL';
      case ForeingkeyActions.setDefault:
        return 'SET DEFAULT';
      case ForeingkeyActions.cascade:
        return 'CASCADE';
      default:
        throw ArgumentError('Unknown Foreingkey Action: $action');
    }
  }
}
