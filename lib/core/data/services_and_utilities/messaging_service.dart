import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseMessagingService {
  static Future<void> initialize() async {
    final notificationSettings =
    await FirebaseMessaging.instance.requestPermission(
      provisional: true,
    );

    if (notificationSettings.authorizationStatus == AuthorizationStatus.authorized ||
        notificationSettings.authorizationStatus == AuthorizationStatus.provisional) {
      print('User granted notification permissions!');
    } else {
      print('User declined or has not granted notification permissions.');
    }

    // For Apple devices, get the APNs token
    final apnsToken = await FirebaseMessaging.instance.getAPNSToken();
    if (apnsToken != null) {
      print('APNs token: $apnsToken');
    }
  }
}
