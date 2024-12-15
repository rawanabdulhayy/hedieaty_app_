import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<List<Map<String, dynamic>>> fetchAllFriendsAndEvents() async {
  final firestore = FirebaseFirestore.instance;

  try {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      print('No authenticated user found.');
      throw Exception('No authenticated user found. Ensure the user is logged in.');
    }
    final currentUserId = currentUser.uid;
    print('Authenticated user ID: $currentUserId');

    final friendsSnapshot = await firestore
        .collection('friends')
        .where('userId', isEqualTo: currentUserId)
        .get();

    print('Number of friends found: ${friendsSnapshot.docs.length}');
    if (friendsSnapshot.docs.isEmpty) {
      return []; // Return empty list if no friends found
    }

    final List<Map<String, dynamic>> allFriendsData = [];
    for (final friendDoc in friendsSnapshot.docs) {
      final friendData = friendDoc.data();
      final friendId = friendData['friendId'];
      print('Processing friend: $friendData');

      // Fetch events for this friend
      final eventsSnapshot = await firestore
          .collection('events')
          .where('userId', isEqualTo: friendId)
          .orderBy('date', descending: false)
          .get();

      print('Number of events for friend ($friendId): ${eventsSnapshot.docs.length}');
      final events = eventsSnapshot.docs.map((eventDoc) {
        return {'eventId': eventDoc.data()['id'], ...eventDoc.data()};
      }).toList();

      allFriendsData.add({
        'friendId': friendId,
        'name': friendData['friendName'],
        'events': events.isEmpty ? [] : events,
      });
    }

    print('Fetched all friends and their events successfully.');
    return allFriendsData;
  } catch (e) {
    print('Error fetching friends and events: $e');
    throw Exception('Error fetching friends and events: ${e.toString()}');
  }
}
