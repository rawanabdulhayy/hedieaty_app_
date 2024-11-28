import 'package:sqflite/sqflite.dart';
import '../../../domain/models/User.dart';
import '../models/local_user_model.dart';

class LocalUserRepository {
  final Database database;

  LocalUserRepository(this.database);

  Future<void> saveUser(LocalUserModel userModel) async {
    await database.insert(
      'users',
      userModel.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<User?> fetchUser(String userId) async {
    final maps = await database.query(
      'users',
      where: 'id = ?',
      whereArgs: [userId],
    );

    if (maps.isNotEmpty) {
      return LocalUserModel.fromMap(maps.first).toDomain();
    }
    return null;
  }
}
