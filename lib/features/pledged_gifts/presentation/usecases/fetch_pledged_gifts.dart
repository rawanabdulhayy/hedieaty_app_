// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
//
// Stream<List<Map<String, dynamic>>> fetchPledgedGifts() async* {
//   // Get the current user's ID
//   final currentUserId = FirebaseAuth.instance.currentUser?.uid;
//
//   if (currentUserId == null) {
//     throw Exception("User not logged in.");
//   }
//
//   // Listen to changes in the user's pledgedGifts field
//   final userDoc = FirebaseFirestore.instance.collection('users').doc(currentUserId);
//
//   await for (final userSnapshot in userDoc.snapshots()) {
//     if (!userSnapshot.exists || userSnapshot.data() == null) {
//       yield [];
//     } else {
//       final pledgedGifts = List<String>.from(userSnapshot.data()!['pledgedGifts'] ?? []);
//
//       // Query the gifts collection to fetch detailed info about pledged gifts
//       if (pledgedGifts.isEmpty) {
//         yield [];
//       } else {
//         final giftSnapshots = await Future.wait(
//           pledgedGifts.map((giftId) =>
//               FirebaseFirestore.instance.collection('gifts').doc(giftId).get()),
//         );
//
//         yield giftSnapshots
//             .where((snap) => snap.exists)
//             .map((snap) => snap.data() as Map<String, dynamic>)
//             .toList();
//       }
//     }
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Stream<List<Map<String, dynamic>>> fetchPledgedGifts() async* {
  final currentUserId = FirebaseAuth.instance.currentUser?.uid;

  if (currentUserId == null) {
    throw Exception("User not logged in.");
  }

  final userDoc = FirebaseFirestore.instance.collection('users').doc(currentUserId);

  await for (final userSnapshot in userDoc.snapshots()) {
    if (!userSnapshot.exists || userSnapshot.data() == null) {
      yield [];
    } else {
      final userData = userSnapshot.data() as Map<String, dynamic>;
      final pledgedGifts = List<String>.from(userData['pledgedGifts'] ?? []);

      if (pledgedGifts.isEmpty) {
        yield [];
      } else {
        final giftSnapshots = await Future.wait(
          pledgedGifts.map((giftId) =>
              FirebaseFirestore.instance.collection('gifts').doc(giftId).get()),
        );

        final giftsWithDetails = await Future.wait(
          giftSnapshots.where((snap) => snap.exists).map((giftSnap) async {
            final giftData = giftSnap.data() as Map<String, dynamic>;

            // Fetch event details
            final eventId = giftData['eventId'];
            DocumentSnapshot? eventSnapshot;
            if (eventId != null) {
              eventSnapshot = await FirebaseFirestore.instance.collection('events').doc(eventId).get();
            }

            // Fetch user details for the gift
            final associatedUserId = eventSnapshot?.data() != null
                ? (eventSnapshot!.data() as Map<String, dynamic>)['userId']
                : null;

            DocumentSnapshot? userSnapshot;
            if (associatedUserId != null) {
              userSnapshot = await FirebaseFirestore.instance.collection('users').doc(associatedUserId).get();
            }

            final friendName = userSnapshot?.data() != null
                ? (userSnapshot!.data() as Map<String, dynamic>)['name']
                : 'Unknown';

            final eventDate = eventSnapshot?.data() != null
                ? (eventSnapshot!.data() as Map<String, dynamic>)['date']
                : 'Unknown';

            return {
              ...giftData,
              'eventDate': eventDate,
              'friendName': friendName,
            };
          }),
        );

        yield giftsWithDetails;
      }
    }
  }
}
