import 'package:cloud_firestore/cloud_firestore.dart';

Future<List<Map<String, dynamic>>> fetchGiftsForEvent(String eventId) async {
  try {
    // Reference to Firestore collection for gifts
    final giftsCollection = FirebaseFirestore.instance.collection('gifts');

    // Query gifts where the eventId matches the passed eventId
    final querySnapshot = await giftsCollection
        .where('eventId', isEqualTo: eventId) // Assuming 'eventId' is a field in your gifts document
        .get();

    // Extract and return the gift data as a list of maps
    final List<Map<String, dynamic>> giftsList = querySnapshot.docs.map((doc) {
      return {
        'name': doc['name'],
        'status': doc['status'],
        'category': doc['category'],
      };
    }).toList();

    return giftsList;
  } catch (e) {
    print('Error fetching gifts: $e');
    return []; // Return an empty list in case of an error
  }
}
