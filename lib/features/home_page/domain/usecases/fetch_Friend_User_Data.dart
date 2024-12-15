import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<Map<String, dynamic>> fetchUserDataAndRelatedDetails(String friendName, String friendEmail) async {
  final firestore = FirebaseFirestore.instance;

  try {
    // Step 1: Get the current user's ID
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      throw Exception('No authenticated user found. Ensure the user is logged in.');
    }
    final currentUserId = currentUser.uid;

    // Step 2: Query the users collection for a matching name and email
    final usersSnapshot = await firestore
        .collection('users')
        .where('name', isEqualTo: friendName)
        .where('email', isEqualTo: friendEmail)
        .get();

    if (usersSnapshot.docs.isEmpty) {
      throw Exception('No matching user found for the provided friend name and email.');
    }

    // Assuming the first match is the correct user
    final friendUserDoc = usersSnapshot.docs.first;
    final friendUserId = friendUserDoc.id; // Get user ID
    final friendUserData = friendUserDoc.data(); // Get user details

    // Step 3: Fetch events associated with this user ID
    final eventsSnapshot = await firestore
        .collection('events')
        .where('userId', isEqualTo: friendUserId)
        .get();

    if (eventsSnapshot.docs.isEmpty) {
      throw Exception('No events found for the matched user.');
    }

    final events = eventsSnapshot.docs.map((doc) => {
      'eventId': doc.id,
      ...doc.data(),
    }).toList();

    // Step 4: Fetch gifts for each event ID
    final gifts = <Map<String, dynamic>>[];
    for (final event in events) {
      final eventId = event['eventId'];
      final giftsSnapshot = await firestore
          .collection('gifts')
          .where('eventId', isEqualTo: eventId)
          .get();

      gifts.addAll(giftsSnapshot.docs.map((doc) => {
        'giftId': doc.id,
        ...doc.data(),
      }).toList());
    }

    // Step 5: Consolidate and return results
    return {
      'userId': currentUserId, // Include the current user's ID
      'friendUser': {
        'friendUserId': friendUserId,
        ...friendUserData,
      },
      'events': events,
      'gifts': gifts,
    };
  } catch (e) {
    throw Exception('Error fetching data: ${e.toString()}');
  }
}
