import '../../../domain/models/Friend.dart';

class FriendRemoteModel {
  final String userId;
  final String friendId;
  final String friendName;
  final String friendEmail;

  FriendRemoteModel({
    required this.userId,
    required this.friendId,
    required this.friendName,
    required this.friendEmail,
  });

  // Convert FriendRemoteModel to Map
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'friendId': friendId,
      'friendName': friendName,
      'friendEmail': friendEmail,
    };
  }

  // Create FriendRemoteModel from Map
  factory FriendRemoteModel.fromMap(Map<String, dynamic> map) {
    return FriendRemoteModel(
      userId: map['userId'],
      friendId: map['friendId'],
      friendName: map['friendName'],
      friendEmail: map['friendEmail'],
    );
  }

  // CopyWith method
  FriendRemoteModel copyWith({
    String? userId,
    String? friendId,
    String? friendName,
    String? friendEmail,
  }) {
    return FriendRemoteModel(
      userId: userId ?? this.userId,
      friendId: friendId ?? this.friendId,
      friendName: friendName ?? this.friendName,
      friendEmail: friendEmail ?? this.friendEmail,
    );
  }

  // Convert FriendRemoteModel to domain Friend
  Friend toDomain() {
    return Friend(
      userId: userId,
      friendId: friendId,
      friendName: friendName,
      friendEmail: friendEmail,
    );
  }

  // Create FriendRemoteModel from domain Friend
  factory FriendRemoteModel.fromDomain(Friend friend) {
    return FriendRemoteModel(
      userId: friend.userId,
      friendId: friend.friendId,
      friendName: friend.friendName,
      friendEmail: friend.friendEmail,
    );
  }
}
