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

### Create your migrations

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

### METHOD 1: Using the Initializer

```dart
final dbMigratorInitializer = DbMigratorInitializer(dbName: "my_database.db", migrations: migrations);
final Database db = await dbMigratorInitializer.openAndRunMigrations();
```

### To keep in mind with the Initializer

IMPORTANT: Always add new migrations to the end of the list, never in the middle.


### METHOD 2: Using the Runner

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
