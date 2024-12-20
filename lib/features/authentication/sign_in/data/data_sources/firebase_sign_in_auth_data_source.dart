import 'package:firebase_auth/firebase_auth.dart';

class Firebase_Auth_Data_Service {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // Sign-in method
  Future<UserCredential> signIn({
    required String email,
    required String password,
  }) async {
    try {
      // Sign the user in with Firebase Authentication
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Optionally, log the signed-in user's information
      final user = _firebaseAuth.currentUser;
      if (user != null) {
        print('User signed in with UID: ${user.uid}');
      } else {
        print('No authenticated user found.');
      }

      return userCredential;
    } catch (e) {
      throw Exception('Error during sign-in: $e');
    }
  }

  // // Other methods (optional): like signOut
  // Future<void> signOut() async {
  //   await _firebaseAuth.signOut();
  //   print('User signed out');
  // }
}
