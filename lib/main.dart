import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:hedieaty_app_mvc/core/config/routes/app_routes.dart';
import 'package:hedieaty_app_mvc/core/config/theme/app_theme.dart';
import 'package:hedieaty_app_mvc/core/data/remote/repositories/remote_user_repo.dart';
import 'package:hedieaty_app_mvc/features/navigation_bar/domain/list_of_nav_bar_items.dart';
import 'package:provider/provider.dart';
import 'core/config/routes/App_Router.dart';
import 'core/data/remote/repositories/remote_friend_repo.dart';
import 'core/data/services_and_utilities/messaging_service.dart';
import 'core/domain/repositories/domain_friend_repo.dart';
import 'core/domain/repositories/domain_user_repo.dart';
import 'core/presentation/providers/User_Provider.dart';
import 'features/events_list/data/repositories/remote_event_list_repo.dart';
import 'features/events_list/domain/repositories/domain_event_repo.dart';
import 'features/gifts_list/data/remote/repositories/gift_remote_repo.dart';
import 'features/gifts_list/domain/repositories/domain_gift_repo.dart';
import 'features/gifts_list/presentation/providers/gift_provider.dart';
import 'features/navigation_bar/presentation/providers/Navigation_Provider.dart';
import 'firebase_options.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  try {
    print("Handling a background message: \${message.messageId}");
    // Add logic to handle the background message (e.g., saving data or showing a notification).
  } catch (e, stacktrace) {
    print("Error handling background message: \$e");
    print(stacktrace);
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e, stacktrace) {
    print("Firebase initialization failed: \$e");
    print(stacktrace);
  }

  // Initialize Firebase Messaging
  await FirebaseMessagingService.initialize();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  // final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => NavigationController()),
        Provider(
          create: (_) => DomainUserRepository(RemoteUserRepository()),
        ),
        Provider<EventRemoteRepository>(
          create: (_) => EventRemoteRepository(),
        ),
        ProxyProvider<EventRemoteRepository, DomainEventRepository>(
          update: (_, remoteRepo, __) => DomainEventRepository(remoteRepo),
        ),
        Provider<GiftRemoteRepository>(
          create: (_) => GiftRemoteRepository(),
        ),
        ProxyProvider<GiftRemoteRepository, GiftDomainRepository>(
          update: (_, remoteRepo, __) => GiftDomainRepository(remoteRepo),
        ),
        Provider<FriendRemoteRepository>(
          create: (_) => FriendRemoteRepository(),
        ),
        ProxyProvider<FriendRemoteRepository, DomainFriendRepository>(
          update: (_, remoteRepo, __) => DomainFriendRepository(remoteRepo),
        ),
        ChangeNotifierProvider(create: (_) => GiftProvider()),
      ],
      child: HedieatyApp(),
    ),
  );
}

class HedieatyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hedieaty',
      theme: appTheme,
      initialRoute: '/',
      routes: appRoutes, // For static routes
      onGenerateRoute: AppRouter.generateRoute, // For dynamic routes
    );
  }
}
