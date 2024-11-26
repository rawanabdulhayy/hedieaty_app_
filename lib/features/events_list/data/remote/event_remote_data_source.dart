import 'package:firebase_database/firebase_database.dart';

class EventRemoteDataSource {
  final DatabaseReference database;

  EventRemoteDataSource(this.database);

  // Add a new event
  Future<void> addEvent(String userId, Map<String, dynamic> event) async {
    final newEventRef = database.child('events/$userId').push();
    await newEventRef.set(event);
  }

  // Fetch all events for a user
  Future<List<Map<String, dynamic>>> fetchEvents(String userId) async {
    final snapshot = await database.child('events/$userId').get();
    if (snapshot.value != null) {
      final events = (snapshot.value as Map<dynamic, dynamic>).values;
      return events.cast<Map<String, dynamic>>().toList();
    }
    return [];
  }

  // Stream events for real-time updates
  Stream<List<Map<String, dynamic>>> streamEvents(String userId) {
    return database.child('events/$userId').onValue.map((event) {
      final events = event.snapshot.value as Map<dynamic, dynamic>? ?? {};
      return events.values.cast<Map<String, dynamic>>().toList();
    });
  }

  // Update event details
  Future<void> updateEvent(String userId, String eventId, Map<String, dynamic> updatedData) async {
    await database.child('events/$userId/$eventId').update(updatedData);
  }

  // Delete an event
  Future<void> deleteEvent(String userId, String eventId) async {
    await database.child('events/$userId/$eventId').remove();
  }
}

// Sync published gift lists across devices	✅	Handled via Firebase Realtime Database with the GiftRemoteDataSource.
// User authentication with Firebase	✅	Handled via UserRemoteDataSource.
// Real-time status updates for gifts	✅	updateGiftStatus combined with streamGifts ensures real-time updates.
// Color-code gifts based on their status	✅	Color-coding logic can be implemented in the UI layer using StreamBuilder.