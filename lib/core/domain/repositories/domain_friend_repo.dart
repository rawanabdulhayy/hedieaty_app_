import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';
import '../../../features/home_page/domain/usecases/fetch_Friend_User_Data.dart';
import '../../data/remote/models/remote_friend_model.dart';
import '../../data/remote/repositories/remote_friend_repo.dart';
import '../models/Friend.dart';

class DomainFriendRepository {
  final FriendRemoteRepository _friendRemoteRepository;

  DomainFriendRepository(this._friendRemoteRepository);
  //
  // Future<void> addFriend(Friend friend) async {
  //   // Get the current user ID
  //   final uid = FirebaseAuth.instance.currentUser?.uid;
  //   if (uid == null) {
  //     throw Exception('No authenticated user found. Ensure the user is logged in.');
  //   }
  //
  //   // Generate a new friend ID if not provided
  //   final friendId = friend.friendId.isEmpty ? const Uuid().v4() : friend.friendId;
  //
  //   // Create a FriendRemoteModel with the current user's ID
  //   final remoteFriendModel = FriendRemoteModel.fromDomain(friend)
  //       .copyWith(userId: uid, friendId: friendId);
  //
  //   // Upsert the friend to the remote repository
  //   await _friendRemoteRepository.upsertFriend(remoteFriendModel);
  // }
  Future<void> addFriend(String friendName, String friendEmail) async {
    // Get the current user's ID
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) {
      throw Exception('No authenticated user found. Ensure the user is logged in.');
    }

    try {
      // Step 1: Validate the friend's details and fetch related data
      final result = await fetchUserDataAndRelatedDetails(friendName, friendEmail);

      // Extract the friend's userId (ID from the 'users' collection)
      final friendUserId = result['friendUser']['friendUserId'];

      // Step 2: Create the Friend object
      final friend = Friend(
        userId: uid, // Current user's ID
        friendId: const Uuid().v4(), // Generate a unique ID for the friend relationship
        friendName: friendName,
        friendEmail: friendEmail,
      );

      // Step 3: Convert Friend to a Remote Model
      final remoteFriendModel = FriendRemoteModel.fromDomain(friend).copyWith(
        friendId: friendUserId, // Friend's user ID from Firestore
      );

      // Step 4: Add or update the friend relationship in Firestore
      await _friendRemoteRepository.upsertFriend(remoteFriendModel);

      print('Friend added successfully with associated user and data.');
    } catch (e) {
      throw Exception('Failed to add friend: ${e.toString()}');
    }
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
