import '../../../domain/models/User.dart';
import '../firebase/user_crud_operations.dart';
import '../models/remote_user_model.dart';

class RemoteUserRepository {
  final FirestoreService _firestoreService;
  final String _userCollectionPath = 'users';

  RemoteUserRepository({FirestoreService? firestoreService})
      : _firestoreService = firestoreService ?? FirestoreService();

  /// Create or update a user
  Future<void> upsertUser(User user) async {
    final remoteModel = RemoteUserModel.fromDomain(user);
    await _firestoreService.upsertDocument(
      collectionPath: _userCollectionPath,
      docId: remoteModel.id,
      data: remoteModel.toMap(),
    );
  }

  /// Fetch a user by ID
  Future<User?> getUserById(String userId) async {
    final data = await _firestoreService.getDocument(
      collectionPath: _userCollectionPath,
      docId: userId,
    );
    if (data == null) return null;

    final remoteModel = RemoteUserModel.fromMap(data);
    return remoteModel.toDomain();
  }

  /// Fetch all users
  Future<List<User>> getAllUsers() async {
    final documents = await _firestoreService.getCollection(_userCollectionPath);
    return documents.map((doc) {
      final remoteModel = RemoteUserModel.fromJson(doc.id, doc.data());
      return remoteModel.toDomain();
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
