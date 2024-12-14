import 'package:firebase_auth/firebase_auth.dart';
import '../../data/remote/models/remote_friend_model.dart';
import '../../data/remote/repositories/remote_friend_repo.dart';
import '../models/Friend.dart';

class DomainFriendRepository {
  final FriendRemoteRepository _friendRemoteRepository;

  DomainFriendRepository(this._friendRemoteRepository);

  Future<void> addFriend(Friend friend) async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) {
      throw Exception('No authenticated user found. Ensure the user is logged in.');
    }

    final remoteFriendModel = FriendRemoteModel.fromDomain(friend);

    await _friendRemoteRepository.upsertFriend(remoteFriendModel);
  }

  Future<Friend?> getFriend(String userId, String friendId) async {
    final remoteFriendModel = await _friendRemoteRepository.getFriendById(userId, friendId);
    return remoteFriendModel?.toDomain();
  }

  Future<List<Friend>> getFriendsForUser(String userId) async {
    final remoteFriends = await _friendRemoteRepository.getFriendsByUserId(userId);
    return remoteFriends.map((remoteFriend) => remoteFriend.toDomain()).toList();
  }

  Future<void> deleteFriend(String userId, String friendId) async {
    await _friendRemoteRepository.deleteFriend(userId, friendId);
  }
}
