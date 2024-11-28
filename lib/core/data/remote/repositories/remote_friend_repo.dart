import 'package:firebase_database/firebase_database.dart';
import '../../../domain/models/Friend.dart';

class RemoteFriendRepository {
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref().child('friends');

  // Add a friend relationship
  Future<void> addFriend(Friend friend) async {
    await _dbRef.child(friend.userId).child(friend.friendId).set(friend.toMap());
  }

  // Get all friends for a user
  Future<List<Friend>> getFriends(String userId) async {
    final snapshot = await _dbRef.child(userId).get();
    final data = snapshot.value as Map<dynamic, dynamic>?;

    if (data == null) return [];

    return data.entries.map((entry) {
      final map = Map<String, dynamic>.from(entry.value);
      return Friend.fromMap(map);
    }).toList();
  }

  // Remove a friend relationship
  Future<void> removeFriend(String userId, String friendId) async {
    await _dbRef.child(userId).child(friendId).remove();
  }

  // Clear all friends for a user
  Future<void> clearFriends(String userId) async {
    await _dbRef.child(userId).remove();
  }
}
