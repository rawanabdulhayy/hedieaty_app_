import '../../../../../core/data/local/helpers/database_helper.dart';
import '../models/local_gift_model.dart';

class GiftLocalRepository {
  final DBHelper _dbHelper;
  final String _tableName = 'gifts';

  GiftLocalRepository({DBHelper? dbHelper}) : _dbHelper = dbHelper ?? DBHelper() {
    _initialize();
  }

  void _initialize() {
    _dbHelper.registerTableCreation((db) async {
      const query = '''
        CREATE TABLE IF NOT EXISTS gifts (
          id TEXT PRIMARY KEY,
          eventId TEXT,
          name TEXT,
          price REAL
        );
      ''';
      await db.execute(query);
    });

    // Example upgrade operation for version 2 (add a new column)
    _dbHelper.registerUpgrade(2, (db) async {
      await db.execute('ALTER TABLE gifts ADD COLUMN description TEXT;');
    });
  }

  Future<void> upsertGift(LocalGiftModel gift) async {
    await _dbHelper.upsert(
      tableName: _tableName,
      data: gift.toMap(),
    );
  }

  Future<List<LocalGiftModel>> getGiftsByEventId(String eventId) async {
    final result = await _dbHelper.query(
      tableName: _tableName,
      column: 'eventId',
      value: eventId,
    );
    return result.map((map) => LocalGiftModel.fromMap(map)).toList();
  }

  Future<void> deleteGift(String giftId) async {
    await _dbHelper.deleteById(
      tableName: _tableName,
      primaryKey: 'id',
      id: giftId,
    );
  }
}
