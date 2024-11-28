import '../../../domain/models/User.dart';
import '../../../domain/models/Wishlist.dart';

class LocalUserModel {
  // Fields
  final String id;
  final String name;
  final String username;
  final String email;
  final String phoneNumber;
  final DateTime birthDate;
  final List<String> events;
  final String wishlist; // JSON string for local storage

  // Constructor
  LocalUserModel({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.phoneNumber,
    required this.birthDate,
    required this.events,
    required this.wishlist,
  });

  // Method to convert LocalUserModel to domain User model
  User toDomain() {
    return User(
      id: id,
      name: name,
      username: username,
      email: email,
      phoneNumber: phoneNumber,
      birthDate: birthDate,
      events: events,
      wishlist: Wishlist.fromJson(wishlist), // Converting the wishlist string to Wishlist object
    );
  }

  // Factory constructor to create a LocalUserModel from a Map (for SQLite or local storage)
  factory LocalUserModel.fromMap(Map<String, dynamic> map) {
    return LocalUserModel(
      id: map['id'],
      name: map['name'],
      username: map['username'],
      email: map['email'],
      phoneNumber: map['phoneNumber'],
      birthDate: DateTime.parse(map['birthDate']),
      events: List<String>.from(map['events'] ?? []),
      wishlist: map['wishlist'] as String, // Assuming the wishlist is stored as a JSON string
    );
  }

  // Method to convert LocalUserModel to Map (for SQLite or local storage)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'username': username,
      'email': email,
      'phoneNumber': phoneNumber,
      'birthDate': birthDate.toIso8601String(),
      'events': events,
      'wishlist': wishlist, // Saving wishlist as JSON string
    };
  }

  // Method to convert from domain User model to LocalUserModel
  static LocalUserModel fromDomain(User user) {
    return LocalUserModel(
      id: user.id,
      name: user.name,
      username: user.username,
      email: user.email,
      phoneNumber: user.phoneNumber,
      birthDate: user.birthDate,
      events: user.events,
      wishlist: user.wishlist.toJson(), // Converting Wishlist object to JSON string
    );
  }
}
