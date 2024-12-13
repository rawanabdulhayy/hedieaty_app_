import 'package:flutter/material.dart';
import '../../../features/gifts_list/presentation/pages/gift_details.dart';
import '../../../features/gifts_list/presentation/pages/users_gifts_list_page.dart';

class AppRouter {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/user_gift_list':
        final args = settings.arguments as Map<String, dynamic>?; // Extract arguments
        if (args == null || args['eventName'] == null || args['eventId'] == null) {
          return MaterialPageRoute(
            builder: (_) => const Scaffold(
              body: Center(
                child: Text('Missing arguments for GiftListPage.'),
              ),
            ),
          );
        }
        return MaterialPageRoute(
          builder: (_) => GiftListPage(eventName: args['eventName'], eventId: args['eventId']),
        );

      case '/gift_details':
        final args = settings.arguments as Map<String, dynamic>?;

        if (args == null || !args.containsKey('eventName') || !args.containsKey('eventId')) {
          // Ensure the eventName is always passed; navigate to an error or default page if missing
          return MaterialPageRoute(
            builder: (_) => Scaffold(
              body: Center(child: Text('Event name and Event Id are required to add or edit a gift.')),
            ),
          );
        }

        return MaterialPageRoute(
          builder: (_) => GiftDetailsPage(
            // giftId: args['giftId'], // Nullable gift ID
            //giftData: args['giftData'], // Nullable gift data
            eventName: args['eventName'],
            eventId: args['eventId']// Required event name
          ),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text('Page not found.'),
            ),
          ),
        );
    }
  }
}
