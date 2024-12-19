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
          price TEXT,
          description TEXT,
          category TEXT,
          status TEXT,
          pledgedBy TEXT,
          isPledged TEXT DEFAULT '0',
          isSynced TEXT DEFAULT '0'
          
        );
      ''';
      await db.execute(query);
    });
  }


  void updateTables() {
    _dbHelper.registerUpgrade(2, (db) async {
      print('Updating isSynced EventLocalRepository...');
      await db.execute('ALTER TABLE gifts ADD COLUMN isSynced TEXT;');
      print('Updated isSynced EventLocalRepository.');
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

  Future<LocalGiftModel?> getGiftById(String giftId) async {
    final result = await _dbHelper.query(
      tableName: _tableName,
      column: 'id',
      value: giftId,
    );

    if (result.isNotEmpty) {
      return LocalGiftModel.fromMap(result.first);
    }
    return null; // Return null if no gift is found
  }


  Future<void> deleteGift(String giftId) async {
    await _dbHelper.deleteById(
      tableName: _tableName,
      primaryKey: 'id',
      id: giftId,
    );
  }


  Future<void> dropEventsTable() async {
    try {
      await _dbHelper.dropTable(_tableName);
      print('Table $_tableName dropped successfully.');
    } catch (e) {
      print('Error dropping table $_tableName: $e');
      throw Exception('Error dropping table $_tableName: $e');
    }
  }
}
