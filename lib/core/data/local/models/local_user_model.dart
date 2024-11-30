import '../../../domain/models/User.dart';
import '../../../domain/models/Wishlist.dart';
import '../../remote/models/remote_user_model.dart';
import 'dart:convert';

class LocalUserModel {
  // Fields
  final String id;
  final String name;
  final String username;
  final String email;
  final String phoneNumber;
  final DateTime birthDate;
  final List<String> events;
  //final String wishlist; // JSON string for local storage
  final Wishlist wishlist; // Wishlist Object
  final DateTime updatedAt;

  // Constructor
  LocalUserModel( {
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.phoneNumber,
    required this.birthDate,
    required this.events,
    required this.wishlist,
    required this.updatedAt,
  });

  // Method to convert LocalUserModel to domain User model
  //TODO: Where is this used? Usecase? as well as every toDomain and fromDomain, toMap and fromMap, toJSON and fromJSON?
  // 1- Purpose of toDomain and fromDomain
  //
  // These methods bridge:
  // Domain Model: Represents business logic (e.g., User class).
  // Data Models: Represent persistence-specific logic (e.g., LocalUserModel or RemoteUserModel).
  // Use Case:
  // Ensures domain logic remains independent of persistence mechanisms.
  // Example:
  // Data is fetched as RemoteUserModel from Firebase.
  // Converted to User for use in business logic.
  // Optionally stored as LocalUserModel in SQLite.
  //
  // 2- toMap Usage
  //
  // Converts objects to Map<String, dynamic> for persistence in databases or APIs.
  // Example in addFriend:
  // await _dbRef.child(friend.userId).child(friend.friendId).set(friend.toMap());

  // SO SQLITE holds json string data, Realtime database holds maps, app business logic holds objects?
  User toDomain() {
    //syntax (domain : data)
    return User(
      id: id,
      name: name,
      username: username,
      email: email,
      phoneNumber: phoneNumber,
      birthDate: birthDate,
      events: events,
      // wishlist: Wishlist.fromJson(wishlist),
      wishlist: wishlist,
      // No need for toJson() here, it's directly a Wishlist object and since the user domain class holds objects, so all set
      updatedAt: updatedAt, // Converting the wishlist json string (data) to Wishlist object (domain)
    );
  }

  // Method to convert LocalUserModel to JSON string (for local storage)
  String toJson() {
    return jsonEncode({
      'id': id,
      'name': name,
      'username': username,
      'email': email,
      'phoneNumber': phoneNumber,
      'birthDate': birthDate.toIso8601String(),
      'events': events,
      'wishlist': wishlist.toJson(),  // Convert wishlist object to JSON string
      'updatedAt': updatedAt.toIso8601String(),
    });
  }

  // Method to create a LocalUserModel from JSON string
  factory LocalUserModel.fromJson(String jsonString) {
    final map = jsonDecode(jsonString);
    return LocalUserModel.fromMap(map);
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
      //wishlist: map['wishlist'] as String,
      wishlist: Wishlist.fromMap(map['wishlist']),  // Create Wishlist object from Map
      updatedAt: map ['updatedAt'], // Assuming the wishlist is stored as a JSON string
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
      'wishlist': wishlist.toMap(), // Convert wishlist to Map
      'updatedAt': updatedAt,
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
      //wishlist: user.wishlist.toJson(),
      wishlist: user.wishlist,  // Directly use the Wishlist object
      updatedAt: user.updatedAt, // Converting Wishlist object to JSON string
    );
  }
  factory LocalUserModel.fromRemoteModel(RemoteUserModel remoteModel) {
    return LocalUserModel(
      id: remoteModel.id,
      name: remoteModel.name,
      username: remoteModel.username,
      email: remoteModel.email,
      phoneNumber: remoteModel.phoneNumber,
      birthDate: remoteModel.birthDate,
      events: remoteModel.events,
      wishlist: remoteModel.wishlist,
      updatedAt: remoteModel.updatedAt, // Ensure the formats align
    );
  }

}

