class EventRemoteModel {
  final String id;
  final String name;
  final DateTime date;
  final String location;
  final String description;
  final String userId;

  EventRemoteModel({
    required this.id,
    required this.name,
    required this.date,
    required this.location,
    required this.description,
    required this.userId,
  });

  factory EventRemoteModel.fromMap(Map<String, dynamic> map) {
    return EventRemoteModel(
      id: map['id'],
      name: map['name'],
      date: DateTime.parse(map['date']),
      location: map['location'],
      description: map['description'],
      userId: map['userId'],
    );
  }

  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'date': date.toIso8601String(),
    'location': location,
    'description': description,
    'userId': userId,
  };

  factory EventRemoteModel.fromJson(Map<String, dynamic> json) {
    return EventRemoteModel(
      id: json['id'],
      name: json['name'],
      date: DateTime.parse(json['date']),
      location: json['location'],
      description: json['description'],
      userId: json['userId'],
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
    };
  }
}
