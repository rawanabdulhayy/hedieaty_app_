class Friend {
  final String userId;
  final String friendId;
  final String friendName;
  final String friendEmail;

  Friend({
    required this.userId,
    required this.friendId,
    required this.friendName,
    required this.friendEmail,
  });

  // Convert Friend to Map
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'friendId': friendId,
      'friendName': friendName,
      'friendEmail': friendEmail,
    };
  }

  // Create Friend from Map
  factory Friend.fromMap(Map<String, dynamic> map) {
    return Friend(
      userId: map['userId'],
      friendId: map['friendId'],
      friendName: map['friendName'],
      friendEmail: map['friendEmail'],
    );
  }

  // CopyWith method
  Friend copyWith({
    String? userId,
    String? friendId,
    String? friendName,
    String? friendEmail,
  }) {
    return Friend(
      userId: userId ?? this.userId,
      friendId: friendId ?? this.friendId,
      friendName: friendName ?? this.friendName,
      friendEmail: friendEmail ?? this.friendEmail,
    );
  }
}