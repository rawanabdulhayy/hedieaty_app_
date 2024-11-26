import 'package:firebase_database/firebase_database.dart';

class GiftRemoteDataSource {
  final DatabaseReference database;

  GiftRemoteDataSource(this.database);

  // Add a new gift
  Future<void> addGift(String userId, String eventId, Map<String, dynamic> gift) async {
    final newGiftRef = database.child('gifts/$userId/$eventId').push();
    await newGiftRef.set(gift);
  }

  // Fetch gifts once
  Future<List<Map<String, dynamic>>> fetchGifts(String userId, String eventId) async {
    final snapshot = await database.child('gifts/$userId/$eventId').get();
    if (snapshot.value != null) {
      final gifts = (snapshot.value as Map<dynamic, dynamic>).values;
      return gifts.cast<Map<String, dynamic>>().toList();
    }
    return [];
  }

  // Stream gifts for real-time updates
  Stream<List<Map<String, dynamic>>> streamGifts(String userId, String eventId) {
    return database.child('gifts/$userId/$eventId').onValue.map((event) {
      final gifts = event.snapshot.value as Map<dynamic, dynamic>? ?? {};
      return gifts.values.cast<Map<String, dynamic>>().toList();
    });
  }

  // Update the status of a gift
  Future<void> updateGiftStatus(String userId, String eventId, String giftId, String status) async {
    await database.child('gifts/$userId/$eventId/$giftId').update({'status': status});
  }

  // Delete a gift
  Future<void> deleteGift(String userId, String eventId, String giftId) async {
    await database.child('gifts/$userId/$eventId/$giftId').remove();
  }
}
