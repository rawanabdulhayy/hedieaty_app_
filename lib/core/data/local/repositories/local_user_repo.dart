import '../helpers/database_helper.dart';
import '../models/local_user_model.dart';

class UserLocalRepository {
  final DBHelper _dbHelper;
  final String _tableName = 'users';

  UserLocalRepository({DBHelper? dbHelper}) : _dbHelper = dbHelper ?? DBHelper() {
    _initialize();
  }

  void _initialize() {
    _dbHelper.registerTableCreation((db) async {
      const query = '''
        CREATE TABLE IF NOT EXISTS users (
          userId TEXT PRIMARY KEY,
          name TEXT,
          email TEXT
        );
      ''';
      await db.execute(query);
    });

    // Example upgrade operation for version 2 (add a new column)
    _dbHelper.registerUpgrade(2, (db) async {
      await db.execute('ALTER TABLE users ADD COLUMN phone TEXT;');
    });
  }

  Future<void> upsertUser(LocalUserModel user) async {
    await _dbHelper.upsert(
      tableName: _tableName,
      data: user.toMap(),
    );
  }

  Future<LocalUserModel?> getUserById(String userId) async {
    final result = await _dbHelper.getById(
      tableName: _tableName,
      primaryKey: 'userId',
      id: userId,
    );
    return result != null ? LocalUserModel.fromMap(result) : null;
  }

  Future<List<LocalUserModel>> getAllUsers() async {
    final result = await _dbHelper.getAll(tableName: _tableName);
    return result.map((map) => LocalUserModel.fromMap(map)).toList();
  }

  Future<void> deleteUser(String userId) async {
    await _dbHelper.deleteById(
      tableName: _tableName,
      primaryKey: 'userId',
      id: userId,
    );
  }
}
