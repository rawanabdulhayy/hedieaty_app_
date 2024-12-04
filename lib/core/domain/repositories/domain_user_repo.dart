import '../../data/remote/models/remote_user_model.dart';
import '../../data/remote/repositories/remote_user_repo.dart';
import '../models/User.dart';

class DomainUserRepository {
  final RemoteUserRepository _remoteUserRepository;

  DomainUserRepository(this._remoteUserRepository);

  Future<void> upsertUser(User user) async {
    final remoteUserModel = RemoteUserModel.fromDomain(user);
    await _remoteUserRepository.upsertUser(remoteUserModel);
  }

  Future<User?> getUserById(String userId) async {
    final remoteUserModel = await _remoteUserRepository.getUserById(userId);
    if (remoteUserModel == null) return null;
    return remoteUserModel.toDomain();
  }

  Future<List<User>> getAllUsers() async {
    final remoteUsers = await _remoteUserRepository.getAllUsers();
    return remoteUsers.map((remoteUser) => remoteUser.toDomain()).toList();
  }

  Future<void> deleteUser(String userId) async {
    await _remoteUserRepository.deleteUser(userId);
  }
}
