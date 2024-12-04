import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hedieaty_app_mvc/core/config/routes/app_routes.dart';
import 'package:hedieaty_app_mvc/core/config/theme/app_theme.dart';
import 'package:hedieaty_app_mvc/core/data/local/repositories/local_user_repo.dart';
import 'package:hedieaty_app_mvc/core/data/remote/repositories/remote_user_repo.dart';
import 'package:provider/provider.dart';
import 'core/domain/repositories/domain_user_repo.dart';
import 'core/presentation/providers/User_Provider.dart';
import 'features/navigation_bar/presentation/providers/Navigation_Provider.dart';
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
      initialRoute: '/',
      routes: appRoutes,
    );
  }
}
//TODO: Authentication Feature built and working
//TODO: DB Tables built and manipulating
//TODO: Milestone one added and resorted

