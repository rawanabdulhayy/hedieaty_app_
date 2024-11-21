import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Import this for ChangeNotifierProvider
import 'package:hedieaty_app_mvc/domain/navigation_controller.dart'; // Import your NavigationController
//import 'package:hedieaty_app_mvc/presentation/my_app.dart'; // Replace with the actual location of your MyApp class

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => NavigationController(),
      child: const Placeholder(), // The child in your ChangeNotifierProvider should be the root widget of your app. This is typically a MaterialApp or a custom widget that initializes your app's structure. In your case, MyApp appears to be the root widget, so it is correct to use it as the child.
    ),
  );
}
