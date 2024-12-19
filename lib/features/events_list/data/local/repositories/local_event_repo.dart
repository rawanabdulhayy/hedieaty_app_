import '../../../../../core/data/local/helpers/database_helper.dart';
import '../models/local_event_model.dart';

class EventLocalRepository {
  final DBHelper _dbHelper;
  final String _tableName = 'events';

  EventLocalRepository({DBHelper? dbHelper}) : _dbHelper = dbHelper ?? DBHelper() {
    _initialize();
  }

  void _initialize() {
    print('Initializing EventLocalRepository...');
    _dbHelper.registerTableCreation((db) async {
      const query = '''
        CREATE TABLE IF NOT EXISTS events (
          id TEXT PRIMARY KEY,
          name TEXT,
          userId TEXT,
          date TEXT,
          location TEXT,
          type TEXT,
          description TEXT
        );
      ''';
      await db.execute(query);
    });

  }
  void updateTables() {
    _dbHelper.registerUpgrade(2, (db) async {
      print('Updating name EventLocalRepository...');
      await db.execute('ALTER TABLE events ADD COLUMN name TEXT;');
    });
  }

  Future<void> upsertEvent(LocalEventModel event) async {
    print('Upserting event: ${event.toMap()}');

    await _dbHelper.upsert(
      tableName: _tableName,
      data: event.toMap(),
    );
    print('Event upserted successfully');
  }

  Future<LocalEventModel?> getEventById(String eventId) async {
    final result = await _dbHelper.query(
      tableName: _tableName,
      column: 'id',
      value: eventId,
    );

    if (result.isNotEmpty) {
      return LocalEventModel.fromMap(result.first);
    }
    return null;
  }

  Future<List<LocalEventModel>> getAllEvents() async {
    final result = await _dbHelper.getAll(
      tableName: _tableName,
    );
    return result.map((map) => LocalEventModel.fromMap(map)).toList();
  }


  Future<List<LocalEventModel>> getEventsByUserId(String userId) async {
    final result = await _dbHelper.query(
      tableName: _tableName,
      column: 'userId',
      value: userId,
    );
    print('Local events fetched for userId=$userId: $result');
    return result.map((map) => LocalEventModel.fromMap(map)).toList();
  }


  Future<void> deleteEvent(String eventId) async {
    await _dbHelper.deleteById(
      tableName: _tableName,
      primaryKey: 'id',
      id: eventId,
    );
  }
}
