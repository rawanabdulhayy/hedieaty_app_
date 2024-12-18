import 'package:flutter/material.dart';
import '../../domain/entity/Gift.dart';
import '../../domain/repositories/domain_gift_repo.dart';

class GiftProvider with ChangeNotifier {
  final GiftDomainRepository giftRepository;

  List<Gift> _allGifts = []; // Full list of gifts
  List<Gift> _filteredGifts = []; // Filtered list of gifts
  String _searchQuery = ''; // Current search query
  String? _selectedFilter; // Currently selected filter criteria

  GiftProvider(this.giftRepository);

  List<Gift> get filteredGifts => _filteredGifts;

  // List of available filter criteria
  final List<String> filterCriteria = [
    'Name: A-Z',
    'Name: Z-A',
    'Status: Available',
    'Status: Pledged',
    'Category: A-Z',
    'Category: Z-A',
  ];

  // Fetch gifts and initialize the list
  Future<void> fetchGifts(String eventId) async {
    try {
      _allGifts = await giftRepository.getGiftsByEventId(eventId);
      _applyFilters(); // Apply filters after fetching
    } catch (e) {
      print("Error fetching gifts: $e");
    }
  }

  // Search Logic
  void filterGifts(String query) {
    _searchQuery = query.toLowerCase();
    _applyFilters(); // Reapply filters
  }

  // Update filter criteria
  void updateCriteria(String? selectedCriteria) {
    _selectedFilter = selectedCriteria;
    _applyFilters(); // Reapply filters
  }

  // Apply search, filter, and sorting
  void _applyFilters() {
    List<Gift> tempGifts = _allGifts;

    // Step 1: Apply Search Filter
    if (_searchQuery.isNotEmpty) {
      tempGifts = tempGifts.where((gift) {
        return gift.name.toLowerCase().contains(_searchQuery) ||
            gift.category.toLowerCase().contains(_searchQuery) ||
            gift.status.toLowerCase().contains(_searchQuery);
      }).toList();
    }

    // Step 2: Apply Sorting/Filter Criteria
    if (_selectedFilter != null) {
      switch (_selectedFilter) {
        case 'Name: A-Z':
          tempGifts.sort((a, b) => a.name.compareTo(b.name));
          break;
        case 'Name: Z-A':
          tempGifts.sort((a, b) => b.name.compareTo(a.name));
          break;
        case 'Status: Available':
          tempGifts = tempGifts.where((gift) => gift.status == 'Available').toList();
          break;
        case 'Status: Pledged':
          tempGifts = tempGifts.where((gift) => gift.status == 'Pledged').toList();
          break;
        case 'Category: A-Z':
          tempGifts.sort((a, b) => a.category.compareTo(b.category));
          break;
        case 'Category: Z-A':
          tempGifts.sort((a, b) => b.category.compareTo(a.category));
          break;
      }
    }

    // Step 3: Update Filtered List
    _filteredGifts = tempGifts;

    // Notify listeners to rebuild UI
    notifyListeners();
  }
}
