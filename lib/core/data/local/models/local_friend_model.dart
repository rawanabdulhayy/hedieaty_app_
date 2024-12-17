class LocalFriendModel {
  final int id; // SQLite primary key
  final int userId; // Foreign key reference to LocalUserModel
  final String friendId;
  final String friendName;
  final String friendEmail;

  LocalFriendModel({
    required this.id,
    required this.userId,
    required this.friendId,
    required this.friendName,
    required this.friendEmail,
  });

  // Convert LocalFriendModel to Map for SQLite insertion
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'friendId': friendId,
      'friendName': friendName,
      'friendEmail': friendEmail,
    };
  }

  // Create LocalFriendModel from SQLite row
  factory LocalFriendModel.fromMap(Map<String, dynamic> map) {
    return LocalFriendModel(
      id: map['id'],
      userId: map['userId'],
      friendId: map['friendId'],
      friendName: map['friendName'],
      friendEmail: map['friendEmail'],
    );
  }
}
