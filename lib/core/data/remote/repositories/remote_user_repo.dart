import 'package:firebase_database/firebase_database.dart';
import '../../../domain/models/User.dart';
import '../models/remote_user_model.dart';

class RemoteUserRepository {
  final DatabaseReference _database;

  RemoteUserRepository(this._database);

  Future<User?> fetchUser(String userId) async {
    try {
      final snapshot = await _database.child('users/$userId').get();
      if (!snapshot.exists) return null;

      final data = snapshot.value as Map<String, dynamic>;
      return RemoteUserModel.fromJson(userId, data).toDomain();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> saveUser(RemoteUserModel userModel) async {
    try {
      await _database.child('users/${userModel.id}').set(userModel.toJson());
    } catch (e) {
      rethrow;
    }
  }
}
