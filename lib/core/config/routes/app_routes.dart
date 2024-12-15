import 'package:flutter/material.dart';
import 'package:hedieaty_app_mvc/features/authentication/sign_in/presentation/pages/signin.dart';
import '../../../features/friend_gift_list/presentation/pages/friend_gift_list.dart';
import '../../../features/friends_events/presentation/pages/friend_event_list.dart';
import '../../../features/home_page/presentation/pages/add_friend.dart';
import '../../../features/authentication/log_out/presentation/log_out.dart';
import '../../../features/authentication/wrapper/presentation/page/sign_in_tabs_wrapper.dart';
import '../../../features/events_list/presentation/pages/create_event_list.dart';
import '../../../features/screenwrapper/presentation/pages/screenwrapper.dart';
final Map<String, WidgetBuilder> appRoutes = {
  // '/': (context) => ChangeNotifierProvider(create: (context) => NavigationController(),
  // child: ScreenWrapper()),
  '/': (context) => SignInTabsWrapper(),
  '/screen_wrapper': (context) => ScreenWrapper(),
  '/sign_in': (context) => SignInPage(),
  '/opening_page': (context) => OpeningPage(),
  '/create_event_list': (context) => CreateEventPage(),
  '/add_friend': (context) => AddFriendPage(),
  '/friend_event_list': (context) => FriendEventListPage(),
  '/friend_gift_list': (context) => FriendGiftListPage(),
  // '/user_events_list': (context) => EventListPage(),
  // In the routes configuration, when defining the navigation for the GiftListPage,
  // you need to ensure that you pass the required eventName dynamically.
  // Since routes is typically a static map, you cannot directly pass dynamic arguments like eventName within the map.
  // '/gift_details': (context) => GiftDetailsPage(),
};

  // '/profile': (context) => ProfilePage(),
  // '/friend_event_list': (context) => FriendEventListPage(),
  // '/friend_gift_list': (context) => FriendGiftListPage(),
  // Add other routes here

// import 'package:flutter/material.dart';
// import 'package:hedieaty_app_mvc/features/home_page/presentation/pages/home_page.dart';
// class Routes {
//   // static const String rootRoute = '/';
//   static const String homePage = "/home";
// }
//
// class AppRouter {
//
//   Route? generateRoute(RouteSettings settings) {
//     switch (settings.name) {
//       case '/':
//       //return MaterialPageRoute(builder: (context) =>  AuthUtilityFunctions.authenticationGateRouter());
//       case Routes.homePage:
//       return MaterialPageRoute(
//           builder: (context) => HomePage());
//
//     }
//     return null;
//   }
// }