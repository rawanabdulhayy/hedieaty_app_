import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hedieaty_app_mvc/core/config/routes/app_routes.dart';
import 'package:hedieaty_app_mvc/core/config/theme/app_theme.dart';
import 'package:hedieaty_app_mvc/core/data/local/repositories/local_user_repo.dart';
import 'package:hedieaty_app_mvc/core/data/remote/repositories/remote_user_repo.dart';
import 'package:hedieaty_app_mvc/features/authentication/wrapper/presentation/page/sign_in_tabs_wrapper.dart';
import 'package:hedieaty_app_mvc/features/navigation_bar/domain/list_of_nav_bar_items.dart';
import 'package:provider/provider.dart';
import 'core/config/routes/App_Router.dart';
import 'core/domain/repositories/domain_user_repo.dart';
import 'core/presentation/providers/User_Provider.dart';
import 'features/events_list/data/repositories/remote_event_list_repo.dart';
import 'features/events_list/domain/repositories/domain_event_repo.dart';
import 'features/gifts_list/data/remote/repositories/gift_remote_repo.dart';
import 'features/gifts_list/domain/repositories/domain_gift_repo.dart';
import 'features/gifts_list/presentation/providers/gift_provider.dart';
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
        Provider<GiftRemoteRepository>(
          create: (_) => GiftRemoteRepository(),
        ),
        ProxyProvider<GiftRemoteRepository, GiftDomainRepository>(
          update: (_, remoteRepo, __) => GiftDomainRepository(remoteRepo),
        ),
        ChangeNotifierProvider(create: (_) => GiftProvider()),
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
      routes: appRoutes, // For static routes
      onGenerateRoute: AppRouter.generateRoute, // For dynamic routes
    );
  }
}
// Static Routes (appRoutes): You continue using appRoutes for static routes that don't require dynamic parameters.
// Dynamic Routes (onGenerateRoute): Use onGenerateRoute to handle routes that need parameters or custom logic, such as passing eventName to GiftListPage.
// Separation of Concerns: The AppRouter class keeps the route handling logic clean and isolated from the rest of the app.
//TODO: Authentication Feature built and working
//TODO: DB Tables built and manipulating
//TODO: Milestone one added and resorted
//
// 1. Provider for EventRemoteRepository
// This provider creates an instance of EventRemoteRepository, which is responsible for interacting with the remote data source (e.g., Firestore, API). It encapsulates the low-level implementation details of fetching and updating event data remotely.
//
// Why This Provider?
//
// EventRemoteRepository is a dependency for DomainEventRepository.
// By providing EventRemoteRepository, we ensure that DomainEventRepository can be instantiated correctly with its required dependency.
// 2. ProxyProvider for DomainEventRepository
// A ProxyProvider takes the already provided EventRemoteRepository and uses it to instantiate DomainEventRepository. The DomainEventRepository acts as the domain layer's abstraction, implementing application-specific business logic while delegating data access tasks to EventRemoteRepository.
//
// Why This Provider?
//
// DomainEventRepository needs EventRemoteRepository to function, as it uses it to fetch and manipulate remote data.
// The ProxyProvider automatically resolves the dependency between these layers, creating a seamless dependency injection.
// Why Two Providers Are Necessary?
// The separation aligns with dependency injection principles and ensures clean architecture:
//
// Reusability: If other parts of the app need EventRemoteRepository (e.g., another repository or a testing environment), they can directly use it without duplicating its creation logic.
// Scalability: Each provider has a distinct role. You could replace EventRemoteRepository with another implementation (e.g., a local repository) without affecting DomainEventRepository.
// Decoupling: By splitting the responsibilities, DomainEventRepository is decoupled from the instantiation details of EventRemoteRepository.
