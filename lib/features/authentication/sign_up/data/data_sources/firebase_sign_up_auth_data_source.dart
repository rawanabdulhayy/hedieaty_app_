import 'package:firebase_auth/firebase_auth.dart';
import 'package:hedieaty_app_mvc/core/domain/models/User.dart' as domain_user;

class FirebaseSignUpAuthDataSource {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // Sign-up method
  Future<UserCredential> signUp({
    required String name,
    required String email,
    required String password,
    required String username,
    required String phoneNumber,
    required DateTime birthDate,
  }) async {
    try {
      // Create the user in Firebase Authentication
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Optionally print the user info after signup
      final user = _firebaseAuth.currentUser;
      if (user != null) {
        print('User is authenticated with UID: ${user.uid}');
      } else {
        print('No authenticated user found');
      }

      return userCredential;

      // Return the userCredential (useful for further Firebase Authentication operations)
      return userCredential;
    } catch (e) {
      throw Exception('Error during sign-up: $e');
    }
  }
}
