import '../../../domain/entity/Gift.dart';

class LocalGiftModel {
  final String id; // Primary key
  final String name;
  final String description;
  final String category;
  final String price; // Kept as String
  final String status;
  final String eventId; // Foreign key reference to LocalEventModel
  final String isPledged; // Stored as String ("true" or "false")
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
      'isPledged': isPledged == "true" ? 1 : 0, // Store boolean as integer (1 or 0)
      'pledgedBy': pledgedBy,

    };
  }

  // Create LocalGiftModel from SQLite row
  factory LocalGiftModel.fromMap(Map<String, dynamic> map) {
    return LocalGiftModel(
      id: map['id'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      category: map['category'] as String,
      price: map['price'].toString(), // Ensure price is a String
      status: map['status'] as String,
      eventId: map['eventId'] as String,
      isPledged: (map['isPledged'] == 1 || map['isPledged'].toString().toLowerCase() == "true") ? "true" : "false",
      pledgedBy: map['pledgedBy'] as String?,
    );
  }

  // Convert LocalGiftModel back to Gift
  Gift toDomain() {
    return Gift(
      id: id,
      name: name,
      description: description,
      category: category,
      price: double.tryParse(price) ?? 0.0, // Convert price from String to double
      status: status,
      eventId: eventId,
      isPledged: isPledged.toLowerCase() == "true", // Convert isPledged from String to bool
      pledgedBy: pledgedBy,
    );
  }
}
