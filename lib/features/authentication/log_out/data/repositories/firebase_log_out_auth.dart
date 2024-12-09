import 'package:firebase_auth/firebase_auth.dart';

class FirebaseLogoutAuthDataSource {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // Logout method
  Future<void> logout() async {
    try {
      // Log out the current user
      await _firebaseAuth.signOut();

      // Optionally print confirmation of the logout operation
      print('User successfully logged out.');
    } catch (e) {
      // Handle and rethrow the exception if any issue occurs during logout
      throw Exception('Error during logout: $e');
    }
  }
}
