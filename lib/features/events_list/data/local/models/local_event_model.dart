import '../../../domain/entities/Event.dart';

class LocalEventModel {
  final String id; // SQLite primary key
  final String name;
  final String date;
  final String location;
  final String description;
  final String userId;
  final String type;

  LocalEventModel({
    required this.id,
    required this.name,
    required this.date,
    required this.location,
    required this.description,
    required this.type,
    required this.userId,
  });

  // Convert LocalEventModel to Map for SQLite insertion
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'date': date,
      'location': location,
      'description': description,
      'type': type,
      'userId' : userId,
    };
  }

  factory LocalEventModel.fromMap(Map<String, dynamic> map) {
    return LocalEventModel(
      id: map['id'] as String,
      name: map['name'] as String,
      date: map['date'] as String,
      location: map['location'] as String,
      description: map['description'] as String,
      type: map['type'] as String,
      userId: map['userId'] as String,
    );
  }

  // Convert back to Event domain model
  Event toDomain() {
    return Event(
      id: id,
      name: name,
      description: description,
      date: DateTime.parse(date), // Convert String to DateTime
      location: location,
      userId: userId,
      type: type,
    );
  }

  // Factory method to create LocalEventModel from Event (domain)
  factory LocalEventModel.fromDomain(Event event) {
    return LocalEventModel(
      id: event.id,
      name: event.name,
      description: event.description,
      date: event.date.toIso8601String(), // Convert DateTime to String
      location: event.location,
      type: event.type,
      userId: event.userId,
    );
  }
}
