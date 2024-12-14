import '../../../domain/models/Friend.dart';

class FriendRemoteModel {
  final String userId;
  final String friendId;

  FriendRemoteModel({
    required this.userId,
    required this.friendId,
  });

  // Convert FriendRemoteModel to Map
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'friendId': friendId,
    };
  }

  // Create FriendRemoteModel from Map
  factory FriendRemoteModel.fromMap(Map<String, dynamic> map) {
    return FriendRemoteModel(
      userId: map['userId'],
      friendId: map['friendId'],
    );
  }

  // CopyWith method
  FriendRemoteModel copyWith({
    String? userId,
    String? friendId,
  }) {
    return FriendRemoteModel(
      userId: userId ?? this.userId,
      friendId: friendId ?? this.friendId,
    );
  }

  // Convert FriendRemoteModel to domain Friend
  Friend toDomain() {
    return Friend(
      userId: userId,
      friendId: friendId,
    );
  }

  // Create FriendRemoteModel from domain Friend
  factory FriendRemoteModel.fromDomain(Friend friend) {
    return FriendRemoteModel(
      userId: friend.userId,
      friendId: friend.friendId,
    );
  }
}
