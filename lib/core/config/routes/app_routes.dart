import 'package:flutter/material.dart';
import 'package:hedieaty_app_mvc/features/add_friend/presentation/add_friend.dart';
import 'package:hedieaty_app_mvc/features/authentication/sign_in/presentation/pages/signin.dart';
import 'package:hedieaty_app_mvc/features/navigation_bar/presentation/providers/Navigation_Provider.dart';
import 'package:provider/provider.dart';
import '../../../features/authentication/wrapper/presentation/page/sign_in_tabs_wrapper.dart';
import '../../../features/home_page/presentation/pages/home_page.dart';
import '../../../features/screenwrapper/presentation/pages/screenwrapper.dart';
import '../../domain/repositories/domain_user_repo.dart';

final Map<String, WidgetBuilder> appRoutes = {
  // '/': (context) => ChangeNotifierProvider(create: (context) => NavigationController(),
  // child: ScreenWrapper()),
  '/': (context) {
    return SignInTabsWrapper();
  },
  '/screen_wrapper': (context) => ScreenWrapper(),
  '/sign_in': (context) => SignInPage(),
  // '/profile': (context) => ProfilePage(),
  // '/friend_event_list': (context) => FriendEventListPage(),
  // '/friend_gift_list': (context) => FriendGiftListPage(),
  // Add other routes here
};
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