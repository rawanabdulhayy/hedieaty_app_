// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:uuid/uuid.dart';
//
// import '../../data/models/event_list_remote_model.dart';
// import '../../data/repositories/remote_event_list_repo.dart';
// import '../entities/Event.dart';
//
//
// class DomainEventRepository {
//   final EventRemoteRepository _eventRemoteRepository;
//
//   DomainEventRepository(this._eventRemoteRepository);
//
//   Future<void> upsertEvent(Event event) async {
//     final uid = FirebaseAuth.instance.currentUser?.uid;
//     if (uid == null) {
//       throw Exception('No authenticated user found. Ensure the user is logged in.');
//     }
//
//     final eventId = event.id.isEmpty ? const Uuid().v4() : event.id;
//     final remoteEventModel = EventRemoteModel.fromDomain(event).copyWith(
//       id: eventId,
//       userId: uid,
//     );
//
//     await _eventRemoteRepository.upsertEvent(remoteEventModel);
//   }
//
//
//   Future<Event?> getEventById(String eventId) async {
//     final remoteEventModel = await _eventRemoteRepository.getEventById(eventId);
//     if (remoteEventModel == null) return null;
//     return remoteEventModel.toDomain();
//   }
//
//   Future<List<Event>> getAllEvents() async {
//     final remoteEvents = await _eventRemoteRepository.getAllEvents();
//     return remoteEvents.map((remoteEvent) => remoteEvent.toDomain()).toList();
//   }
//
//   Future<List<Event>> getEventsByUserId(String userId) async {
//     final remoteEvents = await _eventRemoteRepository.getEventsByUserId(userId);
//     return remoteEvents.map((remoteEvent) => remoteEvent.toDomain()).toList();
//   }
//
//   Future<void> deleteEvent(String eventId) async {
//     await _eventRemoteRepository.deleteEvent(eventId);
//   }
// }
// Updated DomainEventRepository
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';
import '../../data/local/repositories/local_event_repo.dart';
import '../../data/models/event_list_remote_model.dart';
import '../../data/repositories/remote_event_list_repo.dart';
import '../entities/Event.dart';
//TODO: Revise differences in functions between this and the previous version that only used remote repo
//TODO: Implement the syncing from local to remote methods.
//TODO: Implement the syncing from remote to local methods (bas 34an an2l ldata l already mwguda bas mlhash lazma tany0
//TODO: Implement the logic for when to use the local repo (most likely h5lei l condition true bas hseb brdu lremote repo option m32nha gifts w events for future changes of reqs)
class DomainEventRepository {
  final EventRemoteRepository _eventRemoteRepository;
  final EventLocalRepository _eventLocalRepository;

  DomainEventRepository({
    required EventRemoteRepository remoteRepo,
    required EventLocalRepository localRepo,
  })  : _eventRemoteRepository = remoteRepo,
        _eventLocalRepository = localRepo;

  Future<void> upsertEvent(Event event) async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) {
      throw Exception('No authenticated user found. Ensure the user is logged in.');
    }

    // Ensure the event has an ID; if not, generate a new one
    final eventId = event.id.isEmpty ? const Uuid().v4() : event.id;

    // Assign the userId to the event (to ensure consistency across local and remote)
    final eventWithUser = event.copyWith(
      id: eventId,
      userId: uid,
    );

    if (_shouldUseLocal()) {
      // Convert to LocalEventModel with the correct userId and eventId
      await _eventLocalRepository.upsertEvent(eventWithUser.toLocalModel());
    } else {
      // Convert to RemoteEventModel with the correct userId and eventId
      final remoteEventModel = EventRemoteModel.fromDomain(eventWithUser);
      await _eventRemoteRepository.upsertEvent(remoteEventModel);
    }
  }

  Future<Event?> getEventById(String eventId) async {
    if (_shouldUseLocal()) {
      final localEvent = await _eventLocalRepository.getEventById(eventId);
      return localEvent?.toDomain();
    } else {
      final remoteEventModel = await _eventRemoteRepository.getEventById(eventId);
      return remoteEventModel?.toDomain();
    }
  }
  //
  // Future<List<Event>> getEventsByUserId(String userId) async {
  //   if (_shouldUseLocal()) {
  //     // Fetch events from the local repository (SQLite database)
  //     final localEvents = await _eventLocalRepository.getEventsByUserId(userId);
  //
  //     // Map the local events to domain models and return them
  //     return localEvents.map((localEvent) => localEvent.toDomain()).toList();
  //   }
  //
  //   // Fetch events from the remote repository
  //   final remoteEvents = await _eventRemoteRepository.getEventsByUserId(userId);
  //
  //   // Map the remote events to domain models and return them
  //   return remoteEvents.map((remoteEvent) => remoteEvent.toDomain()).toList();
  // }
  Future<List<Event>> getEventsByUserId(String userId) async {
    if (_shouldUseLocal()) {
      final localEvents = await _eventLocalRepository.getEventsByUserId(userId);
      print('Fetched local events: $localEvents');
      final mappedEvents = localEvents.map((localEvent) => localEvent.toDomain()).toList();
      print('Mapped domain events: $mappedEvents');
      return mappedEvents;
    }

    final remoteEvents = await _eventRemoteRepository.getEventsByUserId(userId);
    print('Fetched remote events: $remoteEvents');
    return remoteEvents.map((remoteEvent) => remoteEvent.toDomain()).toList();
  }



  Future<List<Event>> getAllEvents() async {
    if (_shouldUseLocal()) {
      final localEvents = await _eventLocalRepository.getAllEvents();
      return localEvents.map((e) => e.toDomain()).toList();
    } else {
      final remoteEvents = await _eventRemoteRepository.getAllEvents();
      return remoteEvents.map((remoteEvent) => remoteEvent.toDomain()).toList();
    }
  }

  Future<void> deleteEvent(String eventId) async {
    if (_shouldUseLocal()) {
      await _eventLocalRepository.deleteEvent(eventId);
    } else {
      await _eventRemoteRepository.deleteEvent(eventId);
    }
  }

  bool _shouldUseLocal() {
    // Example logic to determine if local should be used
    // Replace with your actual condition
    return true;
  }
}
