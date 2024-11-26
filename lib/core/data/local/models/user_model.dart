class UserModel {
  final int? id; // Primary key for SQLite
  final String name;
  final String email;
  final String preferences;

  UserModel({
    this.id,
    required this.name,
    required this.email,
    required this.preferences,
  });

  // Convert a User object to a Map (for SQLite)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'preferences': preferences,
    };
  }

  // Create a User object from a Map (from SQLite)
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      preferences: map['preferences'],
    );
  }
}
