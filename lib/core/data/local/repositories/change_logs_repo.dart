import 'package:sqflite/sqflite.dart';

import '../../helpers/database_helper.dart';
import '../../models/change_log.dart';

class ChangeLogRepository {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  Future<void> addChangeLog(ChangeLog changeLog) async {
    final db = await _dbHelper.database;
    await db.insert(
      DatabaseHelper.changeLogTable,
      changeLog.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<ChangeLog>> getAllChangeLogs() async {
    final db = await _dbHelper.database;
    final results = await db.query(DatabaseHelper.changeLogTable);
    return results.map((row) => ChangeLog.fromMap(row)).toList();
  }

  Future<void> deleteChangeLog(int id) async {
    final db = await _dbHelper.database;
    await db.delete(
      DatabaseHelper.changeLogTable,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> clearChangeLogs() async {
    final db = await _dbHelper.database;
    await db.delete(DatabaseHelper.changeLogTable);
  }
}
