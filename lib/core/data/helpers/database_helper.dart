//TODO: If this works out, we need to use this as our main CRUD class thing for all tables needed locally.
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static const String _dbName = 'app_database.db';
  static const int _dbVersion = 2;

  static const String userTable = 'users';
  static const String changeLogTable = 'changelogs';

  static final DatabaseHelper instance = DatabaseHelper._internal();
  Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(
      join(dbPath, _dbName),
      version: _dbVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $userTable (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        email TEXT NOT NULL,
        events TEXT,
        wishlist TEXT,
        updatedAt TEXT
      )
    ''');
    await db.execute('''
      CREATE TABLE $changeLogTable (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        userId TEXT,
        operation TEXT NOT NULL,
        timestamp TEXT NOT NULL
      )
    ''');
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute('''
        ALTER TABLE $userTable ADD COLUMN wishlist TEXT
      ''');
    }
  }
}
