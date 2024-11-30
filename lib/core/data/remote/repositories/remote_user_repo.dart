import 'package:firebase_database/firebase_database.dart';
import '../models/remote_user_model.dart';

class RemoteUserRepository {
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref('users');

  Future<List<RemoteUserModel>> getAllUsers() async {
    final snapshot = await _dbRef.get();
    if (snapshot.exists) {
      final Map<String, dynamic> data =
      Map<String, dynamic>.from(snapshot.value as Map);
      return data.entries
          .map((e) => RemoteUserModel.fromMap({'id': e.key, ...Map<String, dynamic>.from(e.value)}))
          .toList();
    }
    return [];
  }

  Future<void> saveUser(RemoteUserModel user) async {
    await _dbRef.child(user.id).set(user.toMap());
  }

  Future<void> deleteUser(String userId) async {
    await _dbRef.child(userId).remove();
  }

  Future<RemoteUserModel?> getUserById(String userId) async {
    final snapshot = await _dbRef.child(userId).get();
    if (snapshot.exists) {
      final data = Map<String, dynamic>.from(snapshot.value as Map);
      return RemoteUserModel.fromMap({'id': userId, ...data});
    }
    return null;
  }
}

// import 'package:firebase_database/firebase_database.dart';
//
// class RemoteUserRepository {
//   final DatabaseReference _dbRef = FirebaseDatabase.instance.reference().child('users');
//
//   // Save user to Firebase
//   Future<void> saveUser(RemoteUserModel user) async {
//     await _dbRef.child(user.id).set(user.toMap());
//   }
//
//   // Get all users from Firebase
//   Future<List<RemoteUserModel>> getAllUsers() async {
//     final DataSnapshot snapshot = await _dbRef.once();
//     Map<dynamic, dynamic> data = snapshot.value;
//     List<RemoteUserModel> users = [];
//     data.forEach((key, value) {
//       users.add(RemoteUserModel.fromMap(value));
//     });
//     return users;
//   }
// }
