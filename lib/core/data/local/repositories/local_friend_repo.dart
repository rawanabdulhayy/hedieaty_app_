import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../../../domain/models/Friend.dart';

class LocalFriendRepository {
  static const String _tableName = 'friends';

  //TODO: UserID should be a foreign key not a primary one in friends table?
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
  //TODO: Added to add friend page button in home.
  Future<void> addFriend(Friend friend) async {
    final db = await _getDatabase();
    await db.insert(
      _tableName,
      friend.toMap(),
      //conflictAlgorithm: ConflictAlgorithm.replace,
      conflictAlgorithm: ConflictAlgorithm.abort,
    ).catchError((e) {
      print('Conflict detected: $e');
    }
      //TODO: toMap is used to insert a friend? does the insert function require the friend to be in a map format?
      //TODO: ConflictAlgorithm should announce the pre-existence of this friend in the table, not just replace it.
    );
  }

  // Get all friends for a user
  Future<List<Friend>> getFriends(String userId) async {
    final db = await _getDatabase();
    final List<Map<String, dynamic>> maps = await db.query(
      _tableName,
      where: 'userId = ?',
      //Q: What does this 'userId = ?' condition mean? does this specify all -- no filters getter? or it specifies the id in whereargs?
      //A: SQLite uses ? as a placeholder for parameters in SQL queries to prevent SQL injection.
      whereArgs: [userId],
    );

    return List.generate(maps.length, (i) {
      return Friend.fromMap(maps[i]);
      //TODO: What does this function do?
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
  Future<List<Friend>> searchFriendsByName(String name) async {
    final db = await _getDatabase();
    final maps = await db.query(
      'friends',
      where: 'name LIKE ?',
      whereArgs: ['%$name%'],
    );
    return maps.map((e) => Friend.fromMap(e)).toList();
  }
}
//Q: I need a function that gets a specific user from searching their names to associate with my search bar in homepage that looks up friends in the friends table.
//A:
//Future<List<User>> searchUsersByName(String name) async {
//   final db = await _getDatabase();
//   final List<Map<String, dynamic>> maps = await db.query(
//     'users',
//     where: 'name LIKE ?',
//     whereArgs: ['%$name%'],
//   );
//   return maps.map((map) => LocalUserModel.fromMap(map).toDomain()).toList();
// }
//
// class LocalFriendRepository {
//   Future<List<Friend>> searchFriends(String query) async {
//     final db = await _getDatabase();
//     final List<Map<String, dynamic>> maps = await db.query(
//       'friends',
//       where: 'friendId LIKE ? OR name LIKE ?',
//       whereArgs: ['%$query%', '%$query%'],
//     );
//     return maps.map((map) => Friend.fromMap(map)).toList();
//   }
// }
