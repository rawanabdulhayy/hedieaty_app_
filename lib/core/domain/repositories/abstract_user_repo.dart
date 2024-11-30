import '../../data/local/repositories/change_logs_repo.dart';
import '../../data/local/repositories/local_user_repo.dart';
import '../../data/remote/models/remote_user_model.dart';
import '../../data/remote/repositories/remote_user_repo.dart';
import '../models/User.dart';

class UserRepository {
  final LocalUserRepository _localRepo = LocalUserRepository();
  final RemoteUserRepository _remoteRepo = RemoteUserRepository();
  final ChangeLogRepository _changeLogRepo = ChangeLogRepository();

  Future<void> syncData() async {
    // Local to Remote Sync
    final localChangeLogs = await _changeLogRepo.getAllChangeLogs();
    for (final log in localChangeLogs) {
      if (log.operation == 'update') {
        final user = await _localRepo.getUserById(log.userId);
        if (user != null) {
          await _remoteRepo.saveUser(
              RemoteUserModel(
            id: user.id,
            name: user.name,
            email: user.email,
            events: user.events,
            wishlist: user.wishlist,
            updatedAt: DateTime.now(),
            username: user.username,
            phoneNumber: user.phoneNumber,
            birthDate: user.birthDate,
          ));
        }
      } else if (log.operation == 'delete') {
        await _remoteRepo.deleteUser(log.userId);
      }
    }
    await _changeLogRepo.clearChangeLogs();

    // Remote to Local Sync
    final remoteUsers = await _remoteRepo.getAllUsers();
    for (final remoteUser in remoteUsers) {
      await _localRepo.saveUser(User(
        id: remoteUser.id,
        name: remoteUser.name,
        email: remoteUser.email,
        events: remoteUser.events,
        wishlist: remoteUser.wishlist,
        updatedAt: remoteUser.updatedAt,
        username: remoteUser.username,
        phoneNumber: remoteUser.phoneNumber,
        birthDate: remoteUser.birthDate,
      ));
    }
  }
}
//
// import 'dart:async';
// import 'package:connectivity/connectivity.dart';
//
// class SyncService {
//   final LocalUserRepository _localRepo = LocalUserRepository();
//   final RemoteUserRepository _remoteRepo = RemoteUserRepository();
//
//   Future<void> checkConnectionAndSync() async {
//     var connectivityResult = await Connectivity().checkConnectivity();
//     if (connectivityResult != ConnectivityResult.none) {
//       // Sync Data from Remote to Local
//       await _syncRemoteToLocal();
//     }
//   }
//
//   Future<void> _syncRemoteToLocal() async {
//     List<RemoteUserModel> remoteUsers = await _remoteRepo.getAllUsers();
//     for (var remoteUser in remoteUsers) {
//       // Convert RemoteUserModel to LocalUserModel and save it to local storage
//       LocalUserModel localUser = LocalUserModel.fromRemoteModel(remoteUser);
//       await _localRepo.createUser(localUser);
//     }
//   }
// }
