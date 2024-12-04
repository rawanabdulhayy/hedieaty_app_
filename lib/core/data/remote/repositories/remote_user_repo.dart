import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../domain/models/User.dart';
import '../firebase/user_crud_operations.dart';
import '../models/remote_user_model.dart';

class RemoteUserRepository {
  final FirestoreService _firestoreService;
  final String _userCollectionPath = 'users';

  RemoteUserRepository({FirestoreService? firestoreService})
      : _firestoreService = firestoreService ?? FirestoreService();

  /// Create or update a user
  Future<void> upsertUser(RemoteUserModel remoteUser) async {
    await _firestoreService.upsertDocument(
      collectionPath: _userCollectionPath,
      //docId: remoteUser.id,
      docId: FirebaseFirestore.instance.collection('users').doc().id,
      data: remoteUser.toMap(),
    );
  }
  /// Fetch a user by ID
  Future<RemoteUserModel?> getUserById(String userId) async {
    final data = await _firestoreService.getDocument(
      collectionPath: _userCollectionPath,
      docId: userId,
    );
    if (data == null) return null;

    final remoteModel = RemoteUserModel.fromMap(data);
    return remoteModel;
  }

  /// Fetch all users
  Future<List<RemoteUserModel>> getAllUsers() async {
    final documents = await _firestoreService.getCollection(_userCollectionPath);
    return documents.map((doc) {
      //TODO: FromJson? aren't documents supposed to be maps?
      final remoteModel = RemoteUserModel.fromJson(doc.id, doc.data());
      return remoteModel;
    }).toList();
  }

  /// Delete a user by ID
  Future<void> deleteUser(String userId) async {
    await _firestoreService.deleteDocument(
      collectionPath: _userCollectionPath,
      docId: userId,
    );
  }
}
