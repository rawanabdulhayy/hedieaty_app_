import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> pledgeGift(String giftId, String pledgedBy) async {
  try {
    // Reference the specific gift document by its unique ID
    final giftDoc = FirebaseFirestore.instance.collection('gifts').doc(giftId);

    // Update the necessary fields in the gift document
    await giftDoc.update({
      'status': 'Pledged',
      'isPledged': true,
      'pledgedBy': pledgedBy,
    });

    print('Gift successfully pledged!');
  } catch (e) {
    print('Error pledging gift: $e');
    throw e; // Re-throw error for error handling in the UI
  }
}
