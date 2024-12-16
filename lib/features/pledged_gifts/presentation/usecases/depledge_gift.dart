import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> dePledgeGift(String giftId) async {
  final currentUser = FirebaseAuth.instance.currentUser;

  if (currentUser == null) {
    throw Exception("User not logged in.");
  }

  final currentUserId = currentUser.uid;

  // References to the necessary Firestore documents
  final userDocRef = FirebaseFirestore.instance.collection('users').doc(currentUserId);
  final giftDocRef = FirebaseFirestore.instance.collection('gifts').doc(giftId);

  try {
    // Perform Firestore updates in a transaction
    await FirebaseFirestore.instance.runTransaction((transaction) async {
      // Get the current gift document
      final giftSnapshot = await transaction.get(giftDocRef);
      if (!giftSnapshot.exists) {
        throw Exception("Gift not found.");
      }

      // Get the current user document
      final userSnapshot = await transaction.get(userDocRef);
      if (!userSnapshot.exists) {
        throw Exception("User not found.");
      }

      // Update the gift document fields
      transaction.update(giftDocRef, {
        'status': 'Available',
        'isPledged': false,
        'pledgedBy': '',
      });

      // Remove the gift ID from the user's pledgedGifts list
      final userData = userSnapshot.data() as Map<String, dynamic>;
      final pledgedGifts = List<String>.from(userData['pledgedGifts'] ?? []);
      pledgedGifts.remove(giftId);

      transaction.update(userDocRef, {
        'pledgedGifts': pledgedGifts,
      });
    });

    print("Gift successfully de-pledged.");
  } catch (e) {
    print("Error de-pledging gift: $e");
    throw Exception("Failed to de-pledge the gift. Please try again.");
  }
}
