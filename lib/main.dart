import 'package:flutter/material.dart';
import 'package:hedieaty_app_mvc/core/config/routes/app_routes.dart';
import 'package:hedieaty_app_mvc/core/config/theme/app_theme.dart';
import 'package:provider/provider.dart';
import 'core/presentation/providers/User_Provider.dart';
import 'core/presentation/providers/navigation_provider.dart'; // Adjust path as needed

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()), // No arguments here
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
      theme: appTheme ,// Use your separate theme file
      initialRoute: '/',
      routes: appRoutes, // Use your separate routes file
    );
  }
}
