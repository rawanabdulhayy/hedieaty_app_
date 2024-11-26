class EventModel {
  final int? id; // Primary key for SQLite
  final String name;
  final String date;
  final String location;
  final String description;
  final int userId; // Foreign key referencing UserModel

  EventModel({
    this.id,
    required this.name,
    required this.date,
    required this.location,
    required this.description,
    required this.userId,
  });

  // Convert an Event object to a Map (for SQLite)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'date': date,
      'location': location,
      'description': description,
      'userId': userId,
    };
  }

  // Create an Event object from a Map (from SQLite)
  factory EventModel.fromMap(Map<String, dynamic> map) {
    return EventModel(
      id: map['id'],
      name: map['name'],
      date: map['date'],
      location: map['location'],
      description: map['description'],
      userId: map['userId'],
    );
  }
}
