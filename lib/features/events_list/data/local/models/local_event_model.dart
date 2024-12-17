class LocalEventModel {
  final int id; // SQLite primary key
  final String name;
  final String date;
  final String location;
  final String description;

  LocalEventModel({
    required this.id,
    required this.name,
    required this.date,
    required this.location,
    required this.description,
  });

  // Convert LocalEventModel to Map for SQLite insertion
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'date': date,
      'location': location,
      'description': description,
    };
  }

  // Create LocalEventModel from SQLite row
  factory LocalEventModel.fromMap(Map<String, dynamic> map) {
    return LocalEventModel(
      id: map['id'],
      name: map['name'],
      date: map['date'],
      location: map['location'],
      description: map['description'],
    );
  }
}
