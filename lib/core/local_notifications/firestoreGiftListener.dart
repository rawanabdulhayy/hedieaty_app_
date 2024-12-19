import 'firebase_listener.dart';

class FirestoreGiftListener {
  static final FirestoreGiftListener _instance = FirestoreGiftListener._internal();
  factory FirestoreGiftListener() => _instance;
  FirestoreGiftListener._internal();

  void startListening() {
    listenForGiftStatusChanges(); // Call your function here
  }
}
