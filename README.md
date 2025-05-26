# sqflite_migrator_plus 📦

Managing your migrations with sqflite made a breeze in Flutter.

## 📌 Recursos

✅ Create and update your table structures incrementally
✅ Easy table maintenance with no worries

## 🚀 Instalação

Add this dependecies to you `pubspec.yaml` file:

```yaml
dependencies:
  sqflite: ^2.4.1
  sqflite_migrator_plus: ^0.0.1
```

Then run the command:

```sh
flutter pub get
```

## 📄 How to use it?

### BASIC: Create your migrations

```dart
import 'package:sqflite_migrator_plus/sqflite_migrator_plus.dart';

// create_table_products
class Migration_202505091026_CreateTableProducts extends MigrationPlus {
  @override
  Future<void> execute(Database db) async {
    await db.execute('''
      CREATE TABLE products (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        product_name TEXT
      )
    ''');
  }
}

// add_price_to_products
class Migration_202505101415_AddPriceToProducts extends MigrationPlus {
  @override
  Future<void> execute(Database db) async {
    await db.execute('ALTER TABLE products ADD COLUMN price REAL DEFAULT 0');
  }
}

final List<MigrationPlus> migrations = [
  Migration_202505091026_CreateTableProducts(),
  Migration_202505101415_AddPriceToProducts(),
];
```

### PROGRAMMATIC: Create your migrations

With programmatic way you use our "SQL Statement Generator"

* MigrationPlusGeneratorCreateTable
* MigrationPlusGeneratorAlterTable

Making easier for you to construct your migrations without having to write SQL statements manually.


```dart
import 'package:sqflite_common/sqlite_api.dart';
import 'package:sqflite_migrator_plus/sqflite_migrator_plus.dart';

// create table products
class Migration_202505261951_create_table_products extends MigrationPlus {
  @override
  Future<void> execute(Database db) {
    List<MigrationPlusColumn> columns = [
      MigrationPlusColumn(columnName: 'id', type: MigrationPlusColumnTypes.integer, isPrimaryKey: true, isAutoIncrement: true),
      MigrationPlusColumn(columnName: 'product_name', type: MigrationPlusColumnTypes.text),
    ];

    var generator = MigrationGeneratorCreateTable('products', columns);

    return db.execute(generator.getSqlStatement());
  }
}

// add_price_to_products
class Migration_202505262211_add_price_table_products extends MigrationPlus {
  @override
  Future<void> execute(Database db) {
    List<MigrationPlusColumn> columns = [
      MigrationPlusColumn(alterColumnType: MigrationPlusAlterColumnType.add, columnName: 'price', type: MigrationPlusColumnTypes.numeric, defaultValue: '0'),
    ];

    var generator = MigrationGeneratorAlterTable('products', columns);

    return db.execute(generator.getSqlStatement());
  }
}

final List<MigrationPlus> migrations = [
  Migration_202505261951_create_table_products(),
  Migration_202505262211_add_price_table_products(),
];
```

### METHOD INITIALIZER: Using the Initializer

```dart
final dbMigratorInitializer = DbMigratorInitializer(dbName: "my_database.db", migrations: migrations);
final Database db = await dbMigratorInitializer.openAndRunMigrations();
```

### To keep in mind with the Initializer

IMPORTANT: Always add new migrations to the end of the list, never in the middle.


### METHOD RUNNER: Using the Runner

The runner creates the table 'migrations' to track migrations.

This way allows you to insert the new migration into any position of list.

Of course, you can check which migrations have been run.

```dart
final Database db = await openDatabase("my_database.db");
final DbMigratorRunner runner = DbMigratorRunner(migrationList: migrations);
await runner.runMigrations(db);
```


### Access your tables as usual

```dart
await db.insert("products", {"product_name": "Laptop Gamer", "price": 849.99});
List<Map<String, dynamic>> products = await db.query("products");
print(products);
```

### Smart and easy

🔹 Don't loose your data on app updates
🔹 Update your table schemas programmatically
🔹 Runs needed migrtations only

### Contributions

🔹 Make a repository fork
🔹 Create a branch: git checkout -b my-branch
🔹 Make a commit with your changes: git add . && git commit -m "Describe your feature"
🔹 Upload your changes: git push origin my-branch
🔹 Then create a Pull Request

### License

This project is licensed under MIT License - Read the file LICENSE.


### 🔗 Links Úteis

[Sqflite Docs]()
[GitHub Repository]()
