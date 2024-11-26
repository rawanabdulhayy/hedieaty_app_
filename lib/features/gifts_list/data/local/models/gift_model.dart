class GiftModel {
  final int? id; // Primary key for SQLite
  final String name;
  final String description;
  final String category; // e.g., Electronics, Books
  final double price;
  final String status; // available/pledged/purchased
  final int eventId; // Foreign key referencing EventModel

  GiftModel({
    this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.price,
    required this.status,
    required this.eventId,
  });

  // Convert a Gift object to a Map (for SQLite)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'category': category,
      'price': price,
      'status': status,
      'eventId': eventId,
    };
  }

  // Create a Gift object from a Map (from SQLite)
  factory GiftModel.fromMap(Map<String, dynamic> map) {
    return GiftModel(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      category: map['category'],
      price: map['price'],
      status: map['status'],
      eventId: map['eventId'],
    );
  }
}
