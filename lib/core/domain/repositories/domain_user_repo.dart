import 'package:firebase_auth/firebase_auth.dart';

import '../../data/remote/models/remote_user_model.dart';
import '../../data/remote/repositories/remote_user_repo.dart';
import '../models/User.dart' as domain_user;

class DomainUserRepository {
  final RemoteUserRepository _remoteUserRepository;

  DomainUserRepository(this._remoteUserRepository);

  Future<void> upsertUser(domain_user.User user) async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) {
      throw Exception('No authenticated user found. Ensure the user is logged in.');
    }
    // Pass the UID explicitly to the RemoteUserModel
    final remoteUserModel = RemoteUserModel.fromDomain(user).copyWith(id: uid);
    await _remoteUserRepository.upsertUser(remoteUserModel);
  }

  Future<domain_user.User?> getUserById(String userId) async {
    final remoteUserModel = await _remoteUserRepository.getUserById(userId);
    if (remoteUserModel == null) return null;
    return remoteUserModel.toDomain();
  }

  Future<List<domain_user.User>> getAllUsers() async {
    final remoteUsers = await _remoteUserRepository.getAllUsers();
    return remoteUsers.map((remoteUser) => remoteUser.toDomain()).toList();
  }

  Future<void> deleteUser(String userId) async {
    await _remoteUserRepository.deleteUser(userId);
  }
}
