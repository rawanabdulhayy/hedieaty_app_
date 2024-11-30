class FriendModel {
  final int userId; // Foreign key referencing UserModel
  final int friendId; // Foreign key referencing UserModel

  FriendModel({
    required this.userId,
    required this.friendId,
  });

  // Convert a Friend object to a Map (for SQLite)
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'friendId': friendId,
    };
  }

  // Create a Friend object from a Map (from SQLite)
  factory FriendModel.fromMap(Map<String, dynamic> map) {
    return FriendModel(
      userId: map['userId'],
      friendId: map['friendId'],
    );
  }
}
//Q: Why Only One Model for Friends?
//A: Friends are simpler entities without distinct local/remote storage needs. Both SQLite and Firebase use a straightforward mapping structure (userId and friendId).
//TODO: Why are there no fromDomain and toDomain in friend class but existing in user classes models?