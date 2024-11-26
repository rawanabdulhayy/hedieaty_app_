import 'package:flutter/material.dart';
import 'package:hedieaty_app_mvc/screenwrapper/presentation/pages/screenwrapper.dart';

final Map<String, WidgetBuilder> appRoutes = {
  '/': (context) => ScreenWrapper(),
  // '/profile': (context) => ProfilePage(),
  // '/friend_event_list': (context) => FriendEventListPage(),
  // '/friend_gift_list': (context) => FriendGiftListPage(),
  // Add other routes here
};
