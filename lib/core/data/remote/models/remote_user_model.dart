
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
      wishlist: wishlist,
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
    };
  }
}
// // RemoteUserModel.dart
// import '../../../domain/models/User.dart';
//   // toDomain method to convert RemoteUserModel to domain User model
//   User toDomain() {
//     return User(
//       id: id,
//       name: name,
//       username: username,
//       email: email,
//     );
//   }
// }
