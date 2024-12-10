import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hedieaty_app_mvc/core/config/routes/app_routes.dart';
import 'package:hedieaty_app_mvc/core/config/theme/app_theme.dart';
import 'package:hedieaty_app_mvc/core/data/local/repositories/local_user_repo.dart';
import 'package:hedieaty_app_mvc/core/data/remote/repositories/remote_user_repo.dart';
import 'package:hedieaty_app_mvc/features/authentication/wrapper/presentation/page/sign_in_tabs_wrapper.dart';
import 'package:hedieaty_app_mvc/features/navigation_bar/domain/list_of_nav_bar_items.dart';
import 'package:provider/provider.dart';
import 'core/domain/repositories/domain_user_repo.dart';
import 'core/presentation/providers/User_Provider.dart';
import 'features/events_list/data/repositories/remote_event_list_repo.dart';
import 'features/events_list/domain/repositories/domain_event_repo.dart';
import 'features/home_page/presentation/pages/home_page.dart';
import 'features/navigation_bar/presentation/providers/Navigation_Provider.dart';
import 'features/screenwrapper/presentation/pages/screenwrapper.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    print("Firebase initialization failed: $e");
  }

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
      ],
      child: HedieatyApp(),
    ),
  );
}


// Decide when to trigger the sync process. Recommended triggers:
//
// On App Launch: Perform a full sync.
// On Network Status Change: Sync when the device comes online.
// On Explicit User Action: Add a "Sync Now" button in the UI.
// Example for triggering on app start (e.g., in a main.dart or initialization class):
//
// void main() async {
// WidgetsFlutterBinding.ensureInitialized();
// final userRepository = UserRepository(localRepository, remoteRepository);
//
// // Perform sync on app launch
// await userRepository.syncData();
//
// runApp(MyApp());
//}

class HedieatyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hedieaty',
      theme: appTheme,
      // initialRoute: '/',
      routes: appRoutes,
    );
  }
}
//TODO: Authentication Feature built and working
//TODO: DB Tables built and manipulating
//TODO: Milestone one added and resorted

