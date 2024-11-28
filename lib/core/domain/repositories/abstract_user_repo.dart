import '../../data/local/models/local_user_model.dart';
import '../../data/local/repositories/local_user_repo.dart';
import '../../data/remote/models/remote_user_model.dart';
import '../../data/remote/repositories/remote_user_repo.dart';
import '../models/User.dart';

class UserRepository {
  final LocalUserRepository localRepository;
  final RemoteUserRepository remoteRepository;

  UserRepository(this.localRepository, this.remoteRepository);

  Future<User?> fetchUser(String userId) async {
    // Try fetching from local first
    final localUser = await localRepository.fetchUser(userId);
    if (localUser != null) return localUser;

    // Fallback to remote if not found locally
    final remoteUser = await remoteRepository.fetchUser(userId);
    if (remoteUser != null) {
      await localRepository.saveUser(LocalUserModel.fromDomain(remoteUser));
    }
    return remoteUser;
  }

  Future<void> saveUser(User user) async {
    final localModel = LocalUserModel.fromDomain(user);
    final remoteModel = RemoteUserModel.fromDomain(user);

    // Save to local and remote
    await localRepository.saveUser(localModel);
    await remoteRepository.saveUser(remoteModel);
  }
}