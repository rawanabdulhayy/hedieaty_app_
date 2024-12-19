import '../../data/local/models/local_gift_model.dart';

class Gift {
  final String id;
  final String name;
  final String description;
  final String category;
  final double price;
  final String status;
  final String eventId;
  final bool isPledged;
  final String? pledgedBy; // Nullable as it may not be pledged yet

  // Constructor
  Gift({
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

  // Named constructor for creating a new gift with default ID
  Gift.create({
    this.id = '', // Default empty ID for new gifts
    required this.name,
    required this.description,
    required this.category,
    required this.price,
    required this.status,
    required this.eventId,
    this.isPledged = false,
    this.pledgedBy,
  });

  // Convert Gift to Map for local storage or Firebase
  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'description': description,
    'category': category,
    'price': price,
    'status': status,
    'eventId': eventId,
    'isPledged': isPledged,
    'pledgedBy': pledgedBy,
  };

  // Convert from Map to Gift instance
  static Gift fromMap(Map<String, dynamic> map) {
    return Gift(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      category: map['category'],
      price: (map['price'] as num).toDouble(),
      status: map['status'],
      eventId: map['eventId'],
      isPledged: map['isPledged'] ?? false,
      pledgedBy: map['pledgedBy'],
    );
  }

  // Convert Gift to JSON for remote operations
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'description': description,
    'category': category,
    'price': price,
    'status': status,
    'eventId': eventId,
    'isPledged': isPledged,
    'pledgedBy': pledgedBy,
  };

  // Convert from JSON to Gift instance
  factory Gift.fromJson(Map<String, dynamic> json) {
    return Gift(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      category: json['category'],
      price: (json['price'] as num).toDouble(),
      status: json['status'],
      eventId: json['eventId'],
      isPledged: json['isPledged'] ?? false,
      pledgedBy: json['pledgedBy'],
    );
  }

  // CopyWith method for creating a new instance with updated values
  Gift copyWith({
    String? id,
    String? name,
    String? description,
    String? category,
    double? price,
    String? status,
    String? eventId,
    bool? isPledged,
    String? pledgedBy,
  }) {
    return Gift(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      category: category ?? this.category,
      price: price ?? this.price,
      status: status ?? this.status,
      eventId: eventId ?? this.eventId,
      isPledged: isPledged ?? this.isPledged,
      pledgedBy: pledgedBy ?? this.pledgedBy,
    );
  }

  LocalGiftModel toLocalModel() {
    return LocalGiftModel(
      id: id,
      name: name,
      description: description,
      category: category,
      price: price as String,
      status: status,
      eventId: eventId,
      isPledged: isPledged as String,
      pledgedBy: pledgedBy,
    );
  }

}
