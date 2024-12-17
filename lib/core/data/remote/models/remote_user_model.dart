import '../../../domain/models/User.dart';

class RemoteUserModel {
  // Fields
  final String id;
  final String name;
  final String username;
  final String email;
  final String phoneNumber;
  final DateTime birthDate;
  final List<String> pledgedGifts;
 // final Wishlist wishlist;
  // final DateTime updatedAt;

  // Constructor
  RemoteUserModel({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.phoneNumber,
    required this.birthDate,
    required this.pledgedGifts,
   // required this.wishlist,
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
      pledgedGifts: map['pledgedGifts'],
      //wishlist: map['wishlist'],
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
    'pledgedGifts': pledgedGifts,
   // 'wishlist': wishlist,
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
      pledgedGifts: pledgedGifts,
      //wishlist: wishlist,
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
      pledgedGifts: user.pledgedGifts,
      //wishlist: user.wishlist,
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
      pledgedGifts: List<String>.from(json['pledgedGifts'] ?? []),
      //wishlist: Wishlist.fromMap(json['wishlist'] ?? {}),
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
      'pledgedGifts': pledgedGifts,
      //'wishlist': wishlist.toMap(),
      // 'updatedAt': updatedAt,
    };
  }

  // CopyWith method to create a new instance with updated values
  RemoteUserModel copyWith({
    String? id,
    String? name,
    String? username,
    String? email,
    String? phoneNumber,
    DateTime? birthDate,
    List<String>? pledgedGifts,
    // Wishlist? wishlist,
    // DateTime? updatedAt,
  }) {
    return RemoteUserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      username: username ?? this.username,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      birthDate: birthDate ?? this.birthDate,
      pledgedGifts: pledgedGifts ?? this.pledgedGifts,
      // wishlist: wishlist ?? this.wishlist,
      // updatedAt: updatedAt ?? this.updatedAt,
    );
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
//
// import '../../../domain/models/User.dart';
// import '../../../domain/models/Event.dart';  // Add Event model
//
// class RemoteUserModel {
//   // Fields
//   final String id;
//   final String name;
//   final String username;
//   final String email;
//   final String phoneNumber;
//   final DateTime birthDate;
//   final List<Event> events;  // Change events to list of Event objects
//   // final Wishlist wishlist;
//   // final DateTime updatedAt;
//
//   // Constructor
//   RemoteUserModel({
//     required this.id,
//     required this.name,
//     required this.username,
//     required this.email,
//     required this.phoneNumber,
//     required this.birthDate,
//     required this.events,
//     // required this.wishlist,
//     // required this.updatedAt,
//   });
//
//   factory RemoteUserModel.fromMap(Map<String, dynamic> map) {
//     return RemoteUserModel(
//       id: map['id'],
//       name: map['name'],
//       username: map['username'],
//       email: map['email'],
//       phoneNumber: map['phoneNumber'],
//       birthDate: DateTime.parse(map['birthDate']),
//       events: List<Event>.from(map['events']?.map((e) => Event.fromMap(e)) ?? []),  // Convert event data to Event objects
//       //wishlist: map['wishlist'],
//       // updatedAt: DateTime.parse(map['updatedAt']),
//     );
//   }
//
//   Map<String, dynamic> toMap() => {
//     'id': id,
//     'name': name,
//     'username': username,
//     'phoneNumber': phoneNumber,
//     'birthDate': birthDate.toIso8601String(),
//     'email': email,
//     'events': events.map((e) => e.toMap()).toList(),  // Convert events to map
//     // 'wishlist': wishlist,
//     // 'updatedAt': updatedAt.toIso8601String(),
//   };
//
//   User toDomain() {
//     return User(
//       id: id,
//       name: name,
//       username: username,
//       email: email,
//       phoneNumber: phoneNumber,
//       birthDate: birthDate,
//       events: events.map((e) => e.toDomain()).toList(),  // Convert events to domain model
//       //wishlist: wishlist,
//       // updatedAt: updatedAt,
//     );
//   }
//
//   // Method to convert from domain User model to RemoteUserModel
//   static RemoteUserModel fromDomain(User user) {
//     return RemoteUserModel(
//       id: user.id,
//       name: user.name,
//       username: user.username,
//       email: user.email,
//       phoneNumber: user.phoneNumber,
//       birthDate: user.birthDate,
//       events: user.events.map((e) => Event.fromDomain(e)).toList(),  // Convert events to Event objects
//       //wishlist: user.wishlist,
//       // updatedAt: user.updatedAt,
//     );
//   }
//
//   factory RemoteUserModel.fromJson(String id, Map<String, dynamic> json) {
//     return RemoteUserModel(
//       id: id,
//       name: json['name'],
//       username: json['username'],
//       email: json['email'],
//       phoneNumber: json['phoneNumber'],
//       birthDate: DateTime.parse(json['birthDate']),
//       events: List<Event>.from(json['events']?.map((e) => Event.fromJson(e)) ?? []),  // Convert event data to Event objects
//       //wishlist: Wishlist.fromMap(json['wishlist'] ?? {}),
//       // updatedAt: json['updatedAt'],
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'name': name,
//       'username': username,
//       'email': email,
//       'phoneNumber': phoneNumber,
//       'birthDate': birthDate.toIso8601String(),
//       'events': events.map((e) => e.toJson()).toList(),  // Convert events to JSON
//       // 'wishlist': wishlist.toMap(),
//       // 'updatedAt': updatedAt,
//     };
//   }
//
//   // CopyWith method to create a new instance with updated values
//   RemoteUserModel copyWith({
//     String? id,
//     String? name,
//     String? username,
//     String? email,
//     String? phoneNumber,
//     DateTime? birthDate,
//     List<Event>? events,
//     // Wishlist? wishlist,
//     // DateTime? updatedAt,
//   }) {
//     return RemoteUserModel(
//       id: id ?? this.id,
//       name: name ?? this.name,
//       username: username ?? this.username,
//       email: email ?? this.email,
//       phoneNumber: phoneNumber ?? this.phoneNumber,
//       birthDate: birthDate ?? this.birthDate,
//       events: events ?? this.events,
//       // wishlist: wishlist ?? this.wishlist,
//       // updatedAt: updatedAt ?? this.updatedAt,
//     );
//   }
// }
