import 'package:flutter/material.dart';

//Steps for provider?
//1- Class with ChangeNotifier >> pv var, get pv var, notifyListeners.
//2- Accessing the notification as instantiating.
//3-The NavigationController must be provided at a higher level in your widget tree. Wrap your app (main) or a higher-level widget with ChangeNotifierProvider
class NavigationController extends ChangeNotifier {
  int _currentIndex = 0;
  late PageController pageController;
  int get currentIndex => _currentIndex;

  NavigationController() {
    pageController = PageController(initialPage: _currentIndex);
  }
  void updateIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  void navigateToPage(int index) {
    _currentIndex = index;
    pageController.animateToPage(index, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    notifyListeners();
  }
}
