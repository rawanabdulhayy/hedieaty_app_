import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/app_colors.dart';
import '../../../../core/config/theme/gradient_background.dart';
import '../../../../core/presentation/widgets/dropdown_list/custom_dropdown_button.dart';
import '../../../../core/presentation/widgets/search_bar/search_bar.dart';
import '../../domain/entity/Gift.dart';
import '../../domain/repositories/domain_gift_repo.dart';
import '../../domain/usecases/sync_local_gifts_to_remote.dart';
import '../widgets/gift_card.dart';
class GiftListPage extends StatefulWidget {
  final String eventName;
  final String eventId;

  const GiftListPage({required this.eventName, Key? key, required this.eventId})
      : super(key: key);

  @override
  State<GiftListPage> createState() => _GiftListPageState();
}

class _GiftListPageState extends State<GiftListPage> {
  final TextEditingController _searchController = TextEditingController();
  String? _selectedFilter;
  List<Gift> _gifts = [];
  List<Gift> _filteredGifts = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadGifts();
  }

  Future<void> _loadGifts() async {
    try {
      final giftRepository = Provider.of<GiftDomainRepository>(context, listen: false);
      final gifts = await giftRepository.getGiftsByEventId(widget.eventId);

      setState(() {
        _gifts = gifts;
        _filteredGifts = gifts;
        _isLoading = false;
      });
    } catch (e) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load gifts: $e')),
        );
      });
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _filterGifts(String query) {
    setState(() {
      _filteredGifts = _gifts.where((gift) {
        return gift.name.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  void _sortGifts(String? filter) {
    setState(() {
      _selectedFilter = filter;
      if (filter == 'Status') {
        _filteredGifts.sort((a, b) => a.status.compareTo(b.status));
      } else if (filter == 'Category') {
        _filteredGifts.sort((a, b) => a.category.compareTo(b.category));
      } else if (filter == 'Name') {
        _filteredGifts.sort((a, b) => a.name.compareTo(b.name));
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gifts for: ${widget.eventName}'),
      ),
      body: GradientBackground(
        child: Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: CustomSearchBar(
                    onChanged: _filterGifts,
                    controller: _searchController,
                    hintText: "Search Gifts...",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 150.0, vertical: 8.0),
                  child: CustomDropdownButton(
                    items: ['Status', 'Category', 'Name'],
                    value: _selectedFilter,
                    onChanged: _sortGifts,
                    hint: const Text(
                      'Sort by',
                      style: TextStyle(color: AppColors.lightAmber),
                    ),
                    iconColor: AppColors.lightAmber,
                    dropdownColor: Colors.white,
                    selectedTextStyle: const TextStyle(color: AppColors.gold),
                  ),
                ),
                Expanded(
                  child: _isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : _filteredGifts.isEmpty
                      ? const Center(child: Text('No gifts found for this event.'))
                      : ListView.builder(
                    itemCount: _filteredGifts.length,
                    itemBuilder: (context, index) {
                      final gift = _filteredGifts[index];
                      return GiftCard(
                        giftData: gift.toMap(),
                        eventName: widget.eventName,
                        eventId: widget.eventId,
                        onDelete: _loadGifts,
                      );
                    },
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 20.0,
              right: 20.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FloatingActionButton(
                    heroTag: 'addGift',
                    onPressed: () async {
                      final result = await Navigator.pushNamed(
                        context,
                        '/gift_details',
                        arguments: {
                          'eventName': widget.eventName,
                          'eventId': widget.eventId,
                          'giftId': '',
                          'giftName': '',
                          'giftDescription': '',
                          'giftCategory': '',
                          'giftPrice': 0.0,
                          'giftStatus': 'Available',
                        },
                      );

                      if (result == true) {
                        _loadGifts();
                      }
                    },
                    backgroundColor: AppColors.gold,
                    child: Icon(Icons.add, color: AppColors.navyBlue),
                  ),
                  const SizedBox(width: 270.0),
                  FloatingActionButton(
                    heroTag: 'refreshGifts',
                    onPressed: () async {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Data synchronizing...')),
                      );
                      try {
                        await syncLocalGiftsToRemote(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Data synchronized successfully!')),
                        );
                        _loadGifts();
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Failed to synchronize data: $e')),
                        );
                      }
                    },
                    backgroundColor: AppColors.gold,
                    child: Icon(Icons.refresh, color: AppColors.navyBlue),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
