import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

import '../../data/models/event_list_remote_model.dart';
import '../../data/repositories/remote_event_list_repo.dart';
import '../entities/Event.dart';


class DomainEventRepository {
  final EventRemoteRepository _eventRemoteRepository;

  DomainEventRepository(this._eventRemoteRepository);

  Future<void> upsertEvent(Event event) async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) {
      throw Exception('No authenticated user found. Ensure the user is logged in.');
    }

    final eventId = event.id.isEmpty ? const Uuid().v4() : event.id;
    final remoteEventModel = EventRemoteModel.fromDomain(event).copyWith(
      id: eventId,
      userId: uid,
    );

    await _eventRemoteRepository.upsertEvent(remoteEventModel);
  }


  Future<Event?> getEventById(String eventId) async {
    final remoteEventModel = await _eventRemoteRepository.getEventById(eventId);
    if (remoteEventModel == null) return null;
    return remoteEventModel.toDomain();
  }

  Future<List<Event>> getAllEvents() async {
    final remoteEvents = await _eventRemoteRepository.getAllEvents();
    return remoteEvents.map((remoteEvent) => remoteEvent.toDomain()).toList();
  }

  Future<List<Event>> getEventsByUserId(String userId) async {
    final remoteEvents = await _eventRemoteRepository.getEventsByUserId(userId);
    return remoteEvents.map((remoteEvent) => remoteEvent.toDomain()).toList();
  }

  Future<void> deleteEvent(String eventId) async {
    await _eventRemoteRepository.deleteEvent(eventId);
  }
}
