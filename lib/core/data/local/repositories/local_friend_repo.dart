import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../../../domain/models/Friend.dart';

class LocalFriendRepository {
  static const String _tableName = 'friends';

  Future<Database> _getDatabase() async {
    final path = join(await getDatabasesPath(), 'app_database.db');
    return openDatabase(
      path,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE $_tableName(userId TEXT, friendId TEXT, PRIMARY KEY(userId, friendId))',
        );
      },
      version: 1,
    );
  }

  // Add a friend relationship
  Future<void> addFriend(Friend friend) async {
    final db = await _getDatabase();
    await db.insert(
      _tableName,
      friend.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Get all friends for a user
  Future<List<Friend>> getFriends(String userId) async {
    final db = await _getDatabase();
    final List<Map<String, dynamic>> maps = await db.query(
      _tableName,
      where: 'userId = ?',
      whereArgs: [userId],
    );

    return List.generate(maps.length, (i) {
      return Friend.fromMap(maps[i]);
    });
  }

  // Remove a friend relationship
  Future<void> removeFriend(String userId, String friendId) async {
    final db = await _getDatabase();
    await db.delete(
      _tableName,
      where: 'userId = ? AND friendId = ?',
      whereArgs: [userId, friendId],
    );
  }

  // Clear all friends for a user
  Future<void> clearFriends(String userId) async {
    final db = await _getDatabase();
    await db.delete(
      _tableName,
      where: 'userId = ?',
      whereArgs: [userId],
    );
  }
}
