import 'package:awesome_notifications/awesome_notifications.dart';

class NotificationController {
  @pragma("vm:entry-point")
  static Future<void> onNotificationCreatedMethod(ReceivedNotification receivedNotification) async {
    // Add your logic here
    print("Notification created: ${receivedNotification.title}");
  }

  @pragma("vm:entry-point")
  static Future<void> onNotificationDisplayedMethod(ReceivedNotification receivedNotification) async {
    // Add your logic here
    print("Notification displayed: ${receivedNotification.title}");
  }

  @pragma("vm:entry-point")
  static Future<void> onDismissActionReceivedMethod(ReceivedNotification receivedNotification) async {
    // Add your logic here
    print("Notification dismissed: ${receivedNotification.title}");
  }

  @pragma("vm:entry-point")
  static Future<void> onActionReceivedMethod(ReceivedNotification receivedNotification) async {
    // Add your logic here
    print("Notification action clicked and this happens : ${receivedNotification.title}");
  }
}
