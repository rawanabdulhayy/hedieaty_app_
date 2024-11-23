import 'package:flutter/material.dart';
import 'package:hedieaty_app_mvc/presentation/pages/home_page.dart';
import 'package:hedieaty_app_mvc/presentation/pages/screenwrapper.dart';
import 'package:hedieaty_app_mvc/presentation/pages/sign_in_tabs_wrapper.dart';
import 'package:hedieaty_app_mvc/presentation/pages/signup.dart';
import 'package:provider/provider.dart'; // Import this for ChangeNotifierProvider
import 'package:hedieaty_app_mvc/domain/navigation_controller.dart';

import 'core/app_colors.dart'; // Import your NavigationController
//import 'package:hedieaty_app_mvc/presentation/my_app.dart'; // Replace with the actual location of your MyApp class

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => NavigationController(),
      child: HedieatyApp(), // The child in your ChangeNotifierProvider should be the root widget of your app. This is typically a MaterialApp or a custom widget that initializes your app's structure. In your case, MyApp appears to be the root widget, so it is correct to use it as the child.
    ),
  );
}
class HedieatyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hedieaty',
      theme: ThemeData(
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          labelStyle: TextStyle(
            color: AppColors.brightBlue,
            fontSize: 16.0,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.brightBlue, width: 2.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.gold, width: 2.0),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 2.0),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.redAccent, width: 2.0),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        // Customize the AppBar theme
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.navyBlue,
          titleTextStyle: TextStyle(
            color: AppColors.gold,
            fontFamily: "Pacifico",
            fontSize: 27,
          ),
          iconTheme: IconThemeData(
            color: AppColors.gold,
          ),
        ),

        // Customize the TabBar theme
        tabBarTheme: TabBarTheme(
          labelColor: AppColors.gold,
          unselectedLabelColor: Colors.grey,
          labelStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          unselectedLabelStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.normal,
          ),
          indicator: UnderlineTabIndicator(
            borderSide: BorderSide(
              color: AppColors.gold,
              width: 3.0,
            ),
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        //'/': (context) => SignInTabsWrapper(),
        '/': (context) => ScreenWrapper(),
        // '/profile': (context) => ProfilePage(),
        // '/friend_event_list': (context) => FriendEventListPage(),
        // '/friend_gift_list': (context) => FriendGiftListPage(),
        // '/user_events_list': (context) => EventListPage(),
        // '/user_gift_list': (context) => GiftListPage(eventName: "Birthday"),
        // '/gift_details': (context) => GiftDetailsPage(), // Add gift ID handling inside the GiftDetailsPage itself
        // '/pledged_gifts': (context) => PledgedGiftsPage(),
        // '/add_friend': (context) => AddFriendPage(),
        // '/create_event_list': (context) => CreateEventPage(),
      },
    );
  }
}
