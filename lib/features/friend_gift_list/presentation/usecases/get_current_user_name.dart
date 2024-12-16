import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<String> getCurrentUserName() async {
  final user = FirebaseAuth.instance.currentUser;

  if (user == null) {
    throw Exception('User not logged in');
  }

  try {
    // Fetch user data from Firestore using UID
    final userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid) // Match document ID with user UID
        .get();

    // Check if the document exists and return the name
    if (userDoc.exists) {
      final userData = userDoc.data();
      return userData?['name'] ?? 'Anonymous'; // Ensure fallback if name is null
    } else {
      throw Exception('User document not found in Firestore');
    }
  } catch (e) {
    throw Exception('Error fetching user data: $e');
  }
}
