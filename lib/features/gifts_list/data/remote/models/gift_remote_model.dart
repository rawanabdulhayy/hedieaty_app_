// gift_remote_model.dart

import '../../../domain/entity/Gift.dart';

class GiftRemoteModel {
  final String id;
  final String name;
  final String description;
  final String category;
  final double price;
  final String status;
  final String eventId;
  final bool isPledged;
  final String? pledgedBy;

  GiftRemoteModel({
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

  factory GiftRemoteModel.fromDomain(Gift gift) {
    return GiftRemoteModel(
      id: gift.id,
      name: gift.name,
      description: gift.description,
      category: gift.category,
      price: gift.price,
      status: gift.status,
      eventId: gift.eventId,
      isPledged: gift.isPledged,
      pledgedBy: gift.pledgedBy,
    );
  }

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

  Map<String, dynamic> toMap() {
    return {
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
  }

  factory GiftRemoteModel.fromMap(Map<String, dynamic> map) {
    return GiftRemoteModel(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      category: map['category'],
      price: map['price'],
      status: map['status'],
      eventId: map['eventId'],
      isPledged: map['isPledged'],
      pledgedBy: map['pledgedBy'],
    );
  }

  GiftRemoteModel copyWith({
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
    return GiftRemoteModel(
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
}