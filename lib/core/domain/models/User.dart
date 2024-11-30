import 'Wishlist.dart';
//TODO: User table structure holds preferences?
//TODO: User events should be an instance of a separate class to events
class User {
  final String id;
  final String name;
  final String username;
  final String email;
  final String phoneNumber;
  final DateTime birthDate;
  final List<String> events;
  final Wishlist wishlist;
  DateTime updatedAt;
  // Add if needed for syncing
  //Initialize updatedAt in the User class with a default:


  //can we have a default value here assigned upon last update otherwise null
  User({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.phoneNumber,
    required this.birthDate,
    required this.events,
    required this.wishlist,
    DateTime? updatedAt,
      }) : updatedAt = updatedAt ?? DateTime.now();

  // Convert User to Map for SQLite
  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'email': email,
    'events': events,
    'wishlist': wishlist,
    'updatedAt': updatedAt.toIso8601String(),
    'username': username,
    'phoneNumber': phoneNumber,
    'birthDate': birthDate,
  };


  // Convert from Map (SQLite row) to User
  static User fromMap(Map<String, dynamic> map) => User(
    id: map['id'],
    name: map['name'],
    email: map['email'],
    events: map['events'],
    wishlist: map['wishlist'],
    updatedAt: DateTime.parse(map['updatedAt']),
    username: map['username'],
    phoneNumber: map['phoneNumber'],
    birthDate: map['birthDate'],
    //TODO: This needs to be of type date
  );
}
