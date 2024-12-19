import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

// This explicitly declares TableOperation as a function type that takes a Database object as input and returns a Future<void>
typedef TableOperation = Future<void> Function(Database db);

class DBHelper {
  // Singleton instance
  static DBHelper? _instance;

  // Database instance
  static Database? _database;

  final List<TableOperation> _createOperations = [];
  final Map<int, List<TableOperation>> _upgradeOperations = {};

  // Private constructor
  DBHelper._();

  /// Factory constructor to return the singleton instance
  factory DBHelper() {
    _instance ??= DBHelper._();
    return _instance!;
  }

  /// Get the database instance, initialize if not already done
  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initializeDatabase();
    return _database!;
  }

  Future<Database> _initializeDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'app_database.db');

    return await openDatabase(
      path,
      version: 2, // Update this version for schema changes
      onCreate: (db, version) async {
        print('Database created with version $version');
        for (var operation in _createOperations) {
          await operation(db);
        }
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        print("Database upgraded from version $oldVersion to $newVersion.");
        for (var i = oldVersion + 1; i <= newVersion; i++) {
          if (_upgradeOperations.containsKey(i)) {
            for (var operation in _upgradeOperations[i]!) {
              await operation(db);
            }
          }
        }
      },
    );
  }

  /// Register a table creation operation
  Future<void> registerTableCreation(TableOperation operation) async {
    print('Registering table creation...');
    _createOperations.add(operation);
    // If the database is already initialized, apply the creation operation immediately
    if (_database != null) {
      print('Executing table creation operation on existing database...');
      await operation(_database!);
      print('Executed.');

    }

  }

  /// Register upgrade operations for a specific version
  Future<void> registerUpgrade(int version, TableOperation operation) async {
    if (_upgradeOperations[version] == null) {
      _upgradeOperations[version] = [];
    }
    _upgradeOperations[version]!.add(operation);
    if (_database != null) {
      print('updating table creation operation on existing database...');
      await operation(_database!);
      print('updated.');

    }
  }
  Future<void> upsert({
    required String tableName,
    required Map<String, dynamic> data,
  }) async {
    final db = await database;
    try {
      await db.insert(
        tableName,
        data,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      print('Error inserting/updating in table $tableName: $e');
      throw Exception('Error inserting/updating in table $tableName: $e');
    }
  }


  /// Fetch all rows from a table
  Future<List<Map<String, dynamic>>> getAll({
    required String tableName,
  }) async {
    final db = await database;
    try {
      return await db.query(tableName);
    } catch (e) {
      throw Exception('Error fetching all records from table $tableName: $e');
    }
  }

  /// Fetch a single record by ID
  Future<Map<String, dynamic>?> getById({
    required String tableName,
    required String primaryKey,
    required dynamic id,
  }) async {
    final db = await database;
    try {
      final result = await db.query(
        tableName,
        where: '$primaryKey = ?',
        whereArgs: [id],
      );
      return result.isNotEmpty ? result.first : null;
    } catch (e) {
      throw Exception('Error fetching record from table $tableName: $e');
    }
  }

  Future<List<Map<String, dynamic>>> query({
    required String tableName,
    required String column,
    required dynamic value,
  }) async {
    final db = await database;
    try {
      final result = await db.query(
        tableName,
        where: '$column = ?',
        whereArgs: [value],
      );
      print('Query result from $tableName for $column=$value: $result');
      return result;
    } catch (e) {
      print('Error querying table $tableName: $e');
      throw Exception('Error querying table $tableName: $e');
    }
  }


  /// Delete a record by its primary key
  Future<void> deleteById({
    required String tableName,
    required String primaryKey,
    required dynamic id,
  }) async {
    final db = await database;
    try {
      await db.delete(
        tableName,
        where: '$primaryKey = ?',
        whereArgs: [id],
      );
    } catch (e) {
      throw Exception('Error deleting record from table $tableName: $e');
    }
  }

  /// Close the database connection
  Future<void> closeDatabase() async {
    if (_database != null) {
      await _database!.close();
      _database = null;
    }
  }
}
