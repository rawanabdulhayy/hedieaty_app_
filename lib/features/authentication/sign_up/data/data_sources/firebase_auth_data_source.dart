import 'package:firebase_auth/firebase_auth.dart';
import 'package:hedieaty_app_mvc/core/domain/models/User.dart' as domain_user;
import 'package:hedieaty_app_mvc/core/domain/models/Wishlist.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // Sign-up method
  Future<UserCredential> signUp({
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

      // Return the userCredential (useful for further Firebase Authentication operations)
      return userCredential;
    } catch (e) {
      throw Exception('Error during sign-up: $e');
    }
  }
}
