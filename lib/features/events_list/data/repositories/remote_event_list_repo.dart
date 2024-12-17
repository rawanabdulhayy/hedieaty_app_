import 'package:firebase_auth/firebase_auth.dart';
import '../../../../core/data/remote/firebase/crud_operations.dart';
import '../models/event_list_remote_model.dart';

class EventRemoteRepository {
  final FirestoreService _firestoreService;
  final String _eventCollectionPath = 'events';

  EventRemoteRepository({FirestoreService? firestoreService})
      : _firestoreService = firestoreService ?? FirestoreService();

  /// Add or update an event
  Future<void> upsertEvent(EventRemoteModel event) async {
    if (FirebaseAuth.instance.currentUser == null) {
      throw Exception('No authenticated user found. Ensure the user is logged in before performing this operation.');
    }

    await _firestoreService.upsertDocument(
      collectionPath: _eventCollectionPath,
      docId: event.id, // Use the event ID as the document ID
      data: event.toMap(),
    );
  }

  /// Fetch an event by ID
  Future<EventRemoteModel?> getEventById(String eventId) async {
    final data = await _firestoreService.getDocument(
      collectionPath: _eventCollectionPath,
      docId: eventId,
    );
    if (data == null) return null;

    final event = EventRemoteModel.fromMap(data);
    return event;
  }

  /// Fetch all events
  Future<List<EventRemoteModel>> getAllEvents() async {
    final documents = await _firestoreService.getCollection(_eventCollectionPath);
    return documents.map((doc) {
      final event = EventRemoteModel.fromMap(doc.data()); // Assuming Firestore document data is in map form
      return event;
    }).toList();
  }

  /// Fetch events by user ID
  Future<List<EventRemoteModel>> getEventsByUserId(String userId) async {
    final documents = await _firestoreService.queryCollection(
      collectionPath: _eventCollectionPath,
      field: 'userId',
      value: userId,
    );
    return documents.map((doc) {
      final event = EventRemoteModel.fromMap(doc.data());
      return event;
    }).toList();
  }

  /// Delete an event by ID
  Future<void> deleteEvent(String eventId) async {
    await _firestoreService.deleteDocument(
      collectionPath: _eventCollectionPath,
      docId: eventId,
    );
  }
}
