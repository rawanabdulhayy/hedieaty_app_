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
  //Q: What does factory constructor do in the fromMap?
  //A: Factory Constructor in fromMap
  //A factory constructor allows you to create a new instance of a class without directly invoking its default constructor.
  //It's used here for converting a Map (e.g., database query result or JSON object) into a Dart object.
  factory Friend.fromMap(Map<String, dynamic> map) {
    return Friend(
      userId: map['userId'],
      friendId: map['friendId'],
    );
  }
}
