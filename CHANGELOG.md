## 1.0.0

** Breaking change

* Refactoring the Alter Table class.

  Previously it returns one string with several SQL statements. But the SQLite only runs one statement and stops.

  Now it returns a list of string, so it runs all the statements, one at a time.

* New CreateIndexGenerator class to easy the index creation


## 0.0.4

* Renamed Migrator Plus Generator classes for easing code writting/reading


## 0.0.3

* This release Added Migrator Plus Generator, easing the migration with classes and not writting SQL statements


## 0.0.2

* This release implements the DbMigratorRunner with migrations table


## 0.0.1

* This release implements the DbMigratorInitializer
