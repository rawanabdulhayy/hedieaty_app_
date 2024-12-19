//Step 3: Create the type/ basic building unit in the list aka the items that builds the items list
import 'package:flutter/material.dart';
import 'package:hedieaty_app_mvc/features/navigation_bar/domain/nav_bar_item.dart';
import '../../events_list/presentation/pages/user_events_list_page.dart';
import '../../home_page/presentation/pages/home_page.dart';
import '../../profile/presentation/pages/profile_page.dart';
List <NavigationBarItem> listOfNavigationBarItems = [homepage, profilepage, eventspage];

// NavigationBarItem homepage = NavigationBarItem(title: "Home", icon: Icons.home, page: HomePage());
NavigationBarItem homepage = NavigationBarItem(title: "Home", icon: Icons.home, page: HomePage());

//TODO Why is the pages in the initial skeleton left as container?

NavigationBarItem profilepage = NavigationBarItem(title: "Profile", icon: Icons.person, page: ProfilePage());

NavigationBarItem eventspage = NavigationBarItem(title: "Events", icon: Icons.list, page: EventListPage());