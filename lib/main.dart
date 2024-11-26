import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hedieaty_app_mvc/core/config/routes/app_routes.dart';
import 'package:hedieaty_app_mvc/core/config/theme/app_theme.dart';
import 'package:provider/provider.dart';
import 'core/presentation/providers/User_Provider.dart';
import 'features/navigation_bar/presentation/providers/Navigation_Provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(  options: DefaultFirebaseOptions.currentPlatform,);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => NavigationController()),
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
      routes: appRoutes,
    );
  }
}
