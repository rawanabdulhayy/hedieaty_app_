import '../../../domain/entity/Gift.dart';

class LocalGiftModel {
  final String id; // Primary key
  final String name;
  final String description;
  final String category;
  final double price;
  final String status;
  final String eventId; // Foreign key reference to LocalEventModel
  final bool isPledged;
  final String? pledgedBy;

  LocalGiftModel({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.price,
    required this.status,
    required this.eventId,
    required this.isPledged,
    this.pledgedBy,
  });

  // Convert LocalGiftModel to Map for SQLite insertion
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'category': category,
      'price': price,
      'status': status,
      'eventId': eventId,
      'isPledged': isPledged ? 1 : 0, // Store boolean as integer
      'pledgedBy': pledgedBy,
    };
  }

  // Create LocalGiftModel from SQLite row
  factory LocalGiftModel.fromMap(Map<String, dynamic> map) {
    return LocalGiftModel(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      category: map['category'],
      price: map['price'],
      status: map['status'],
      eventId: map['eventId'],
      isPledged: map['isPledged'] == 1, // Convert integer back to boolean
      pledgedBy: map['pledgedBy'],
    );
  }

  // Convert GiftLocalModel back to Gift
  Gift toDomain() {
    return Gift(
      id: id,
      name: name,
      description: description,
      category: category,
      price: price,
      status: status,
      eventId: eventId,
      isPledged: isPledged,
      pledgedBy: pledgedBy,
    );
  }
}
