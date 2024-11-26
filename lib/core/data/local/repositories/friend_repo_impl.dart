import 'package:sqflite/sqflite.dart';
import '../models/friend_model.dart';

class FriendRepository {
  final Database database;

  FriendRepository(this.database);

  Future<int> addFriend(FriendModel friend) async {
    return await database.insert('friends', friend.toMap());
  }

  Future<int> removeFriend(int userId, int friendId) async {
    return await database.delete(
      'friends',
      where: 'userId = ? AND friendId = ?',
      whereArgs: [userId, friendId],
    );
  }

  Future<List<FriendModel>> getFriendsForUser(int userId) async {
    final result = await database.query(
      'friends',
      where: 'userId = ?',
      whereArgs: [userId],
    );
    return result.map((map) => FriendModel.fromMap(map)).toList();
  }
}
