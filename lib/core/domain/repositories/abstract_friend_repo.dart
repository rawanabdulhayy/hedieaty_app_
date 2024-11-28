import '../../data/local/repositories/local_friend_repo.dart';
import '../../data/remote/repositories/remote_friend_repo.dart';
import '../models/Friend.dart';

class FriendRepository {
  final LocalFriendRepository _localRepo;
  final RemoteFriendRepository _remoteRepo;

  FriendRepository(this._localRepo, this._remoteRepo);

  Future<void> addFriend(Friend friend, {bool syncRemote = true}) async {
    await _localRepo.addFriend(friend);
    if (syncRemote) {
      await _remoteRepo.addFriend(friend);
    }
  }

  Future<List<Friend>> getFriends(String userId,
      {bool useRemote = false}) async {
    return useRemote ? await _remoteRepo.getFriends(userId) : await _localRepo
        .getFriends(userId);
  }

  Future<void> removeFriend(String userId, String friendId,
      {bool syncRemote = true}) async {
    await _localRepo.removeFriend(userId, friendId);
    if (syncRemote) {
      await _remoteRepo.removeFriend(userId, friendId);
    }
  }

  Future<void> clearFriends(String userId, {bool syncRemote = true}) async {
    await _localRepo.clearFriends(userId);
    if (syncRemote) {
      await _remoteRepo.clearFriends(userId);
    }
  }
}