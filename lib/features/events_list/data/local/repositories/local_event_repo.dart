import '../../../../../core/data/local/helpers/database_helper.dart';
import '../models/local_event_model.dart';

class EventLocalRepository {
  final DBHelper _dbHelper;
  final String _tableName = 'events';

  EventLocalRepository({DBHelper? dbHelper}) : _dbHelper = dbHelper ?? DBHelper();

  /// Initialize the repository by registering table creation
  void initialize() {
    _dbHelper.registerTableCreation((db) async {
      await db.execute('''
        CREATE TABLE IF NOT EXISTS $_tableName (
          id TEXT PRIMARY KEY,
          userId TEXT,
          title TEXT,
          date TEXT
        );
      ''');
    });

    _dbHelper.registerUpgrade(2, (db) async {
      await db.execute('''
        ALTER TABLE $_tableName ADD COLUMN location TEXT;
      ''');
    });
  }

  /// Add or update an event
  Future<void> upsertEvent(LocalEventModel event) async {
    await _dbHelper.upsert(
      tableName: _tableName,
      data: event.toMap(),
    );
  }

  /// Fetch events by user ID
  Future<List<LocalEventModel>> getEventsByUserId(String userId) async {
    final result = await _dbHelper.query(
      tableName: _tableName,
      column: 'userId',
      value: userId,
    );
    return result.map((map) => LocalEventModel.fromMap(map)).toList();
  }

  /// Delete an event
  Future<void> deleteEvent(String eventId) async {
    await _dbHelper.deleteById(
      tableName: _tableName,
      primaryKey: 'id',
      id: eventId,
    );
  }
}
