import 'package:flutter/material.dart';

class GiftProvider extends ChangeNotifier {
  List<String> filterCriteria = ['Status', 'Category', 'Name'];
  String? selectedCriteria;

  void updateCriteria(String? criteria) {
    selectedCriteria = criteria;
    notifyListeners();
  }

  void filterGifts(String query) {
    // Implement filtering logic here
    notifyListeners();
  }
}

//leih hena 3mlna provider class bas f events didn't?