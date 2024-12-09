import '../../data/repositories/firebase_log_out_auth.dart';

void performLogout() async {
  final logoutAuthDataSource = FirebaseLogoutAuthDataSource();

  try {
    await logoutAuthDataSource.logout();
    print('Logout successful.');
  } catch (e) {
    print('Logout failed: $e');
  }
}
