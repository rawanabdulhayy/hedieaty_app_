import 'package:sqflite/sqflite.dart';
import '../models/event_model.dart';

class EventRepository {
  final Database database;

  EventRepository(this.database);

  Future<int> addEvent(EventModel event) async {
    return await database.insert('events', event.toMap());
  }

  Future<int> updateEvent(EventModel event) async {
    return await database.update(
      'events',
      event.toMap(),
      where: 'id = ?',
      whereArgs: [event.id],
    );
  }

  Future<int> deleteEvent(int id) async {
    return await database.delete('events', where: 'id = ?', whereArgs: [id]);
  }

  Future<EventModel?> getEventById(int id) async {
    final result = await database.query(
      'events',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (result.isNotEmpty) {
      return EventModel.fromMap(result.first);
    }
    return null;
  }

  Future<List<EventModel>> getAllEventsForUser(int userId) async {
    final result = await database.query(
      'events',
      where: 'userId = ?',
      whereArgs: [userId],
    );
    return result.map((map) => EventModel.fromMap(map)).toList();
  }
}
