import 'package:firebase_auth/firebase_auth.dart';
import '../repositories/auth_repo.dart';

class FirebaseAuthDataSource implements AuthRepository {
  final FirebaseAuth firebaseAuth;

  FirebaseAuthDataSource({required this.firebaseAuth});

  @override
  Future<void> signUp(User user, String password) async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
          email: user.email, password: password);
      // Handle successful signup (optional)
    } on FirebaseAuthException catch (e) {
      // Handle specific Firebase Auth errors
    } catch (e) {
      // Handle other exceptions
    }
  }
}@override
Future<void> signUp(User user, String password) async {
  try {
    await firebaseAuth.createUserWithEmailAndPassword(
      email: user.email,
      password: password,
    );
    // Handle successful signup (optional)
  } on FirebaseAuthException catch (e) {
    // Handle specific Firebase Auth errors
  } catch (e) {
    // Handle other exceptions
  }
}