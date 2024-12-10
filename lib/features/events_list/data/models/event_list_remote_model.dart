import '../../domain/entities/Event.dart';

class EventRemoteModel {
  final String id;
  final String name;
  final DateTime date;
  final String location;
  final String description;
  final String userId;
  final String type;

  EventRemoteModel({
    required this.id,
    required this.name,
    required this.date,
    required this.location,
    required this.description,
    required this.userId,
    required this.type,
  });

  // Add the copyWith method
  EventRemoteModel copyWith({
    String? id,
    String? name,
    DateTime? date,
    String? location,
    String? description,
    String? userId,
    String? type,
  }) {
    return EventRemoteModel(
      id: id ?? this.id,
      name: name ?? this.name,
      date: date ?? this.date,
      location: location ?? this.location,
      description: description ?? this.description,
      userId: userId ?? this.userId,
      type: type ?? this.type,
    );
  }

  factory EventRemoteModel.fromMap(Map<String, dynamic> map) {
    return EventRemoteModel(
      id: map['id'],
      name: map['name'],
      date: DateTime.parse(map['date']),
      location: map['location'],
      description: map['description'],
      userId: map['userId'],
      type: map["type"],
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'date': date.toIso8601String(),
        'location': location,
        'description': description,
        'userId': userId,
         "type": type,
      };

  factory EventRemoteModel.fromJson(Map<String, dynamic> json) {
    return EventRemoteModel(
      id: json['id'],
      name: json['name'],
      date: DateTime.parse(json['date']),
      location: json['location'],
      description: json['description'],
      userId: json['userId'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'date': date.toIso8601String(),
      'location': location,
      'description': description,
      'userId': userId,
      'type': type,
    };
  }

  static EventRemoteModel fromDomain(Event event) {
    return EventRemoteModel(
      id: event.id,
      name: event.name,
      date: event.date,
      location: event.location,
      description: event.description,
      userId: event.userId,
      type: event.type,
    );
  }

  /// Converts a remote EventRemoteModel to a domain Event model
  Event toDomain() {
    return Event(
      id: id,
      name: name,
      date: date,
      location: location,
      description: description,
      userId: userId,
      type: type,
    );
  }
}
