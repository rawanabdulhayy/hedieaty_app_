import '../../../domain/models/User.dart';
import '../../../domain/models/Wishlist.dart';

class RemoteUserModel {
  // Fields
  final String id;
  final String name;
  final String username;
  final String email;
  final String phoneNumber;
  final DateTime birthDate;
  final List<String> events;
  final Wishlist wishlist;
  // final DateTime updatedAt;

  // Constructor
  RemoteUserModel({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.phoneNumber,
    required this.birthDate,
    required this.events,
    required this.wishlist,
    // required this.updatedAt,
  });

  factory RemoteUserModel.fromMap(Map<String, dynamic> map) {
    return RemoteUserModel(
      id: map['id'],
      name: map['name'],
      username: map['username'],
      email: map['email'],
      phoneNumber: map['phoneNumber'],
      birthDate: map['birthDate'],
      events: map['events'],
      wishlist: map['wishlist'],
      // updatedAt: DateTime.parse(map['updatedAt']),
    );
  }
  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'username': username,
    'phoneNumber': phoneNumber,
    'birthDate': birthDate,
    'email': email,
    'events': events,
    'wishlist': wishlist,
    // 'updatedAt': updatedAt.toIso8601String(),
  };

  User toDomain() {
    return User(
      id: id,
      name: name,
      username: username,
      email: email,
      phoneNumber: phoneNumber,
      birthDate: birthDate,
      events: events,
      wishlist: wishlist,
      // updatedAt: updatedAt,
    );
  }
  // Method to convert from domain User model to RemoteUserModel
  static RemoteUserModel fromDomain(User user) {
    return RemoteUserModel(
      id: user.id,
      name: user.name,
      username: user.username,
      email: user.email,
      phoneNumber: user.phoneNumber,
      birthDate: user.birthDate,
      events: user.events,
      wishlist: user.wishlist,
      // updatedAt: user.updatedAt,
    );
  }
  factory RemoteUserModel.fromJson(String id, Map<String, dynamic> json) {
    return RemoteUserModel(
      id: id,
      name: json['name'],
      username: json['username'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      birthDate: DateTime.parse(json['birthDate']),
      events: List<String>.from(json['events'] ?? []),
      wishlist: Wishlist.fromMap(json['wishlist'] ?? {}),
      // updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'username': username,
      'email': email,
      'phoneNumber': phoneNumber,
      'birthDate': birthDate.toIso8601String(),
      'events': events,
      'wishlist': wishlist.toMap(),
      // 'updatedAt': updatedAt,
    };

  }

}
//Q: How are the two classes localusermodel and remoteusermodel different?
//A: Difference Between Local and Remote Models
//
// Local Models:

// Optimized for local storage systems like SQLite.
// Use structures like JSON strings or flattened schemas for ease of persistence.
// Example: wishlist stored as a JSON string in LocalUserModel.

// Remote Models:

// Designed for remote databases like Firebase.
// Use hierarchical data structures (e.g., nested objects) to mirror remote schemas.
// Example: wishlist stored as a Wishlist object in RemoteUserModel.
// Conversion methods (toDomain, fromDomain) translate between local/remote models and domain models (User), ensuring consistency across layers.
