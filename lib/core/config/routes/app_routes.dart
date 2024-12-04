import 'package:flutter/material.dart';
import 'package:hedieaty_app_mvc/features/add_friend/presentation/add_friend.dart';
import 'package:hedieaty_app_mvc/features/navigation_bar/presentation/providers/Navigation_Provider.dart';
import 'package:provider/provider.dart';
import '../../../features/authentication/wrapper/presentation/page/sign_in_tabs_wrapper.dart';
import '../../../features/screenwrapper/presentation/pages/screenwrapper.dart';
import '../../domain/repositories/domain_user_repo.dart';

final Map<String, WidgetBuilder> appRoutes = {
  // '/': (context) => ChangeNotifierProvider(create: (context) => NavigationController(),
  // child: ScreenWrapper()),
  '/': (context) {
    final domainUserRepository = Provider.of<DomainUserRepository>(context);
    return SignInTabsWrapper();
  },
  //'/': (context) => AddFriendPage(),
  // '/profile': (context) => ProfilePage(),
  // '/friend_event_list': (context) => FriendEventListPage(),
  // '/friend_gift_list': (context) => FriendGiftListPage(),
  // Add other routes here
};
