import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class UserRemoteDataSource {
  final FirebaseAuth auth;
  final DatabaseReference database;

  UserRemoteDataSource(this.auth, this.database);

  // Sign up a new user
  Future<User?> signUp(String email, String password) async {
    final userCredential = await auth.createUserWithEmailAndPassword(email: email, password: password);
    return userCredential.user;
  }

  // Sign in an existing user
  Future<User?> signIn(String email, String password) async {
    final userCredential = await auth.signInWithEmailAndPassword(email: email, password: password);
    return userCredential.user;
  }

  // Sign out the current user
  Future<void> signOut() async {
    await auth.signOut();
  }

  // Get the current user's UID
  String? getCurrentUserId() {
    return auth.currentUser?.uid;
  }

  // Fetch user-specific data
  Future<Map<String, dynamic>> fetchUserData(String userId) async {
    final snapshot = await database.child('users/$userId').get();
    return snapshot.value as Map<String, dynamic>;
  }

  // Update user profile
  Future<void> updateUserData(String userId, Map<String, dynamic> data) async {
    await database.child('users/$userId').update(data);
  }
}
