class Friend {
  final String userId; // ID of the user
  final String friendId; // ID of the friend

  Friend({
    required this.userId,
    required this.friendId,
  });

  // Convert Friend to Map
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'friendId': friendId,
    };
  }

  // Create Friend from Map
  factory Friend.fromMap(Map<String, dynamic> map) {
    return Friend(
      userId: map['userId'],
      friendId: map['friendId'],
    );
  }
}
