class Event {
  final String id;
  final String name;
  final DateTime date;
  final String location;
  final String description;
  final String userId;
  final String type;

  // Constructor
  Event({
    required this.id,
    required this.name,
    required this.date,
    required this.location,
    required this.description,
    required this.userId,
    required this.type,
  });

  // Named constructor for creating a new event with default ID
  Event.create({
    this.id = '', // Default empty ID for new events
    required this.name,
    required this.date,
    required this.location,
    required this.description,
    required this.userId,
    required this.type,
  });

  // Convert Event to Map for local storage or Firebase
  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'date': date.toIso8601String(),
    'location': location,
    'description': description,
    'userId': userId,
    'type': type,
  };

  // Convert from Map to Event instance
  static Event fromMap(Map<String, dynamic> map) {
    return Event(
      id: map['id'],
      name: map['name'],
      date: DateTime.parse(map['date']),
      location: map['location'],
      description: map['description'],
      userId: map['userId'],
      type: map['type'],
    );
  }

  // Convert Event to JSON for remote operations
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'date': date.toIso8601String(),
    'location': location,
    'description': description,
    'userId': userId,
    'type': type,
  };

  // Convert from JSON to Event instance
  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'],
      name: json['name'],
      date: DateTime.parse(json['date']),
      location: json['location'],
      description: json['description'],
      userId: json['userId'],
      type: json['type'],
    );
  }

  // CopyWith method for creating a new instance with updated values
  Event copyWith({
    String? id,
    String? name,
    DateTime? date,
    String? location,
    String? description,
    String? userId,
    String? type,

  }) {
    return Event(
      id: id ?? this.id,
      name: name ?? this.name,
      date: date ?? this.date,
      location: location ?? this.location,
      description: description ?? this.description,
      userId: userId ?? this.userId,
      type: type?? this.type,
    );
  }
}
