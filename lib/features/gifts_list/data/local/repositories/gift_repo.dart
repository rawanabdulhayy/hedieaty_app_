import 'package:sqflite/sqflite.dart';
import '../models/gift_model.dart';

class GiftRepository {
  final Database database;

  GiftRepository(this.database);

  Future<int> addGift(GiftModel gift) async {
    return await database.insert('gifts', gift.toMap());
  }

  Future<int> updateGift(GiftModel gift) async {
    return await database.update(
      'gifts',
      gift.toMap(),
      where: 'id = ?',
      whereArgs: [gift.id],
    );
  }

  Future<int> deleteGift(int id) async {
    return await database.delete('gifts', where: 'id = ?', whereArgs: [id]);
  }

  Future<GiftModel?> getGiftById(int id) async {
    final result = await database.query(
      'gifts',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (result.isNotEmpty) {
      return GiftModel.fromMap(result.first);
    }
    return null;
  }

  Future<List<GiftModel>> getAllGiftsForEvent(int eventId) async {
    final result = await database.query(
      'gifts',
      where: 'eventId = ?',
      whereArgs: [eventId],
    );
    return result.map((map) => GiftModel.fromMap(map)).toList();
  }
}
