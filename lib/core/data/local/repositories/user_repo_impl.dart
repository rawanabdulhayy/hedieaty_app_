import 'package:sqflite/sqflite.dart';
import '../models/user_model.dart';

class UserRepository {
  final Database database;

  UserRepository(this.database);

  Future<int> addUser(UserModel user) async {
    return await database.insert('users', user.toMap());
  }

  Future<int> updateUser(UserModel user) async {
    return await database.update(
      'users',
      user.toMap(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }

  Future<int> deleteUser(int id) async {
    return await database.delete('users', where: 'id = ?', whereArgs: [id]);
  }

  Future<UserModel?> getUserById(int id) async {
    final result = await database.query(
      'users',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (result.isNotEmpty) {
      return UserModel.fromMap(result.first);
    }
    return null;
  }

  Future<List<UserModel>> getAllUsers() async {
    final result = await database.query('users');
    return result.map((map) => UserModel.fromMap(map)).toList();
  }
}
