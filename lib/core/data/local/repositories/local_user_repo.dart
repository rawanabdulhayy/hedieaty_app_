import 'package:sqflite/sqflite.dart';
import '../../../domain/models/User.dart';
import '../../helpers/database_helper.dart';
import '../../models/change_log.dart';
import 'change_logs_repo.dart';

class LocalUserRepository {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;
  final ChangeLogRepository _changeLogRepo = ChangeLogRepository();

  Future<void> saveUser(User user) async {
    final db = await _dbHelper.database;
    await db.insert(
      DatabaseHelper.userTable,
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    await _changeLogRepo.addChangeLog(ChangeLog(
      id: 0,
      userId: user.id,
      operation: 'update',
      timestamp: DateTime.now(),
    ));
  }

  Future<List<User>> getAllUsers() async {
    final db = await _dbHelper.database;
    final results = await db.query(DatabaseHelper.userTable);
    return results.map((row) => User.fromMap(row)).toList();
  }

    // Retrieve User by ID from local storage
  Future<User?> getUserById(String userId) async {
    final db = await _dbHelper.database;
    final result = await db.query(
      DatabaseHelper.userTable,
      where: 'userId = ?', // Filter by userId
      whereArgs: [userId], // Pass userId as the argument
    );
    // If a user is found, return the mapped User object, otherwise return null
    if (result.isNotEmpty) {
      return User.fromMap(result.first);
    } else {
      return null; // Return null if no user found
    }
  }

  Future<void> deleteUser(String userId) async {
    final db = await _dbHelper.database;
    await db.delete(
      DatabaseHelper.userTable,
      where: 'id = ?',
      whereArgs: [userId],
    );
    await _changeLogRepo.addChangeLog(ChangeLog(
      id: 0,
      userId: userId,
      operation: 'delete',
      timestamp: DateTime.now(),
    ));
  }
}
// import '../../../domain/models/User.dart';
// import 'local_user_model.dart'; // Assuming you have LocalUserModel
// import 'dart:async';
//
// class LocalUserRepository {
//   // CRUD Methods:
//
//   // Retrieve User by ID from local storage
//   Future<LocalUserModel?> getUserById(String userId) async {
//     await Future.delayed(Duration(milliseconds: 100));
//     return _userStorage[userId];
//   }
//
//   // Delete User from local storage
//   Future<void> deleteUser(String userId) async {
//     await Future.delayed(Duration(milliseconds: 100));
//     _userStorage.remove(userId);
//   }
//
//
//   // Sync with Remote (placeholder)
//   Future<void> syncToRemote() async {
//     final users = await getAllUsers();
//     for (var user in users) {
//       // Simulate syncing user data to remote (Firebase)
//       // Call a method in RemoteUserRepository to save this user
//       print("Syncing user to remote: ${user.id}");
//     }
//   }
// }
