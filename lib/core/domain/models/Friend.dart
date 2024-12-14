class Friend {
  final String userId;
  final String friendId;

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

  // CopyWith method
  Friend copyWith({
    String? userId,
    String? friendId,
  }) {
    return Friend(
      userId: userId ?? this.userId,
      friendId: friendId ?? this.friendId,
    );
  }
}
