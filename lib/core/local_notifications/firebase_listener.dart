import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_auth/firebase_auth.dart';

void listenForGiftStatusChanges() async {
  // Get the current user's ID
  String currentUserId = FirebaseAuth.instance.currentUser?.uid ?? '';

  // Query the events collection to get the associated event IDs for the current user
  QuerySnapshot userEventsSnapshot = await FirebaseFirestore.instance
      .collection('events')
      .where('userId', isEqualTo: currentUserId)
      .get();

  // Extract the list of event IDs
  List<String> userEventIds = userEventsSnapshot.docs
      .map((doc) => doc.id)
      .toList();

  // Listen to changes in the gifts collection
  FirebaseFirestore.instance.collection('gifts').snapshots().listen((snapshot) {
    for (var docChange in snapshot.docChanges) {
      if (docChange.type == DocumentChangeType.modified) {

        print("Document changed: ${docChange.doc.data()}"); // Debug log
        var giftData = docChange.doc.data() as Map<String, dynamic>;

        // Check if the eventId matches one of the user's event IDs
        if (userEventIds.contains(giftData['eventId'])) {
          if (giftData['status'] == 'Pledged') {
            // Show the notification
            AwesomeNotifications().createNotification(
              content: NotificationContent(
                id: DateTime.now().millisecondsSinceEpoch.remainder(100000),
                channelKey: "basic_channel",
                title: "Gift Pledged",
                body: "A gift has been pledged for one of your events!",
              ),
            );
          }
        }
      }
    }
  });
}
