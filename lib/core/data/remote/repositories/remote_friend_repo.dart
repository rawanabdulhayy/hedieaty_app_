import '../firebase/crud_operations.dart';
import '../models/remote_friend_model.dart';

class FriendRemoteRepository {
  final FirestoreService _firestoreService;
  final String _friendCollectionPath = 'friends';

  FriendRemoteRepository({FirestoreService? firestoreService})
      : _firestoreService = firestoreService ?? FirestoreService();

  /// Add or update a friend
  Future<void> upsertFriend(FriendRemoteModel friend) async {
    try {
      await _firestoreService.upsertDocument(
        collectionPath: _friendCollectionPath,
        docId: '${friend.userId}_${friend.friendId}', // Unique composite key
        data: friend.toMap(),
      );
    } catch (e) {
      throw Exception('Error upserting friend: $e');
    }
  }

  /// Fetch a friend by composite ID
  Future<FriendRemoteModel?> getFriendById(String userId, String friendId) async {
    final docId = '${userId}_$friendId';
    final data = await _firestoreService.getDocument(
      collectionPath: _friendCollectionPath,
      docId: docId,
    );
    if (data == null) return null;
    return FriendRemoteModel.fromMap(data);
  }

  /// Fetch all friends for a user
  Future<List<FriendRemoteModel>> getFriendsByUserId(String userId) async {
    final documents = await _firestoreService.queryCollection(
      collectionPath: _friendCollectionPath,
      field: 'userId',
      value: userId,
    );
    return documents.map((doc) => FriendRemoteModel.fromMap(doc.data())).toList();
  }

  /// Delete a friend by composite ID
  Future<void> deleteFriend(String userId, String friendId) async {
    final docId = '${userId}_${friendId}';
    await _firestoreService.deleteDocument(
      collectionPath: _friendCollectionPath,
      docId: docId,
    );
  }
}
