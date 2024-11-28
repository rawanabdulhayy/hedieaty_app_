
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

  User toDomain() {
    return User(
      id: id,
      name: name,
      username: username,
      email: email,
      phoneNumber: phoneNumber,
      birthDate: birthDate,
      events: events,
      wishlist: Wishlist.fromJson(wishlist),
    );
  }

  factory LocalUserModel.fromMap(Map<String, dynamic> map) {
    return LocalUserModel(
      id: map['id'],
      name: map['name'],
      username: map['username'],
      email: map['email'],
      phoneNumber: map['phoneNumber'],
      birthDate: DateTime.parse(map['birthDate']),
      events: List<String>.from(map['events'] ?? []),
      wishlist: map['wishlist'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'username': username,
      'email': email,
      'phoneNumber': phoneNumber,
      'birthDate': birthDate.toIso8601String(),
      'events': events,
      'wishlist': wishlist,
    };
  }
}
