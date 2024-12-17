import '../helpers/database_helper.dart';
import '../models/local_friend_model.dart';

class FriendLocalRepository {
  final DBHelper _dbHelper;
  final String _tableName = 'friends';

  FriendLocalRepository({DBHelper? dbHelper}) : _dbHelper = dbHelper ?? DBHelper() {
    _initialize();
  }

  void _initialize() {
    _dbHelper.registerTableCreation((db) async {
      const query = '''
        CREATE TABLE IF NOT EXISTS friends (
          userId TEXT NOT NULL,
          friendId TEXT NOT NULL,
          name TEXT,
          UNIQUE (userId, friendId) ON CONFLICT REPLACE
        );
      ''';
      await db.execute(query);
    });
  }

  Future<void> upsertFriend(LocalFriendModel friend) async {
    await _dbHelper.upsert(
      tableName: _tableName,
      data: friend.toMap(),
    );
  }

  Future<List<LocalFriendModel>> getFriendsByUserId(String userId) async {
    final result = await _dbHelper.query(
      tableName: _tableName,
      column: 'userId',
      value: userId,
    );
    return result.map((map) => LocalFriendModel.fromMap(map)).toList();
  }

  Future<void> deleteFriend(String userId, String friendId) async {
    await _dbHelper.database.then((db) {
      db.delete(
        _tableName,
        where: 'userId = ? AND friendId = ?',
        whereArgs: [userId, friendId],
      );
    });
  }
}
