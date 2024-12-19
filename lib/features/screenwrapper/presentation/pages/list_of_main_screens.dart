import 'package:flutter/cupertino.dart';
import 'package:hedieaty_app_mvc/features/events_list/presentation/pages/user_events_list_page.dart';
import 'package:hedieaty_app_mvc/features/home_page/presentation/pages/home_page.dart';
import 'package:hedieaty_app_mvc/features/profile/presentation/pages/profile_page.dart';


List<Widget> listOfMainScreens = [
  HomePage(),
  ProfilePage(),
  EventListPage(),
];