import 'package:flutter/material.dart';
import '../../../../core/app_colors.dart';
import '../../../friend_gift_list/presentation/widgets/friend_gift_card.dart';
import '../usecases/fetch_gifts_for_events.dart';

class FriendGiftListPage extends StatefulWidget {
  @override
  _FriendGiftListPageState createState() => _FriendGiftListPageState();
}

class _FriendGiftListPageState extends State<FriendGiftListPage> {
  TextEditingController searchController = TextEditingController();
  String dropdownValue = 'Status'; // Default value
  List<GiftCard> allGifts = [];
  List<GiftCard> displayedGifts = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadGifts(); // Load gifts when the dependencies are available
  }

  Future<void> _loadGifts() async {
    final Map<String, dynamic> args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final String eventId = args['eventId']; // Retrieve the eventId passed from FriendEventListPage

    try {
      final giftsData = await fetchGiftsForEvent(eventId); // Use eventId to fetch gifts
      setState(() {
        displayedGifts = giftsData.map((gift) {
          return GiftCard(
            giftName: gift['name'],
            status: gift['status'],
            category: gift['category'],
          );
        }).toList();
      });
    } catch (e) {
      print('Error loading gifts: $e');
    }
  }

  void filterGifts(String query) {
    setState(() {
      displayedGifts = allGifts.where((gift) {
        return gift.giftName.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  void sortGifts(String? newValue) {
    setState(() {
      if (newValue != null) {
        dropdownValue = newValue;
        // Sorting logic here
        if (dropdownValue == 'Name') {
          displayedGifts.sort((a, b) => a.giftName.compareTo(b.giftName));
        } else if (dropdownValue == 'Category') {
          displayedGifts.sort((a, b) => a.category.compareTo(b.category));
        } else if (dropdownValue == 'Status') {
          displayedGifts.sort((a, b) => a.status.compareTo(b.status));
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final String friendName = args['friendName'];
    final String eventName = args['eventName'];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.navyBlue,
        title: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '$friendName\'s Gifts',
                style: TextStyle(
                  color: AppColors.gold,
                  fontFamily: "Pacifico",
                  fontSize: 18,
                ),
              ),
              Text(
                'for $eventName',
                style: TextStyle(
                  color: AppColors.gold,
                  fontFamily: "Pacifico",
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
        iconTheme: IconThemeData(color: AppColors.gold),
        actions: [
          IconButton(
            icon: Icon(Icons.card_giftcard),
            onPressed: () {
              // Action for the button goes here
            },
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.navyBlue, AppColors.brightBlue],
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(10.0),
              child: TextField(
                controller: searchController,
                onChanged: filterGifts,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.brightBlue, width: 2.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.gold, width: 2.0),
                  ),
                  hintText: 'Search gifts...',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(3.0),
              child: DropdownButton<String>(
                value: dropdownValue,
                items: <String>['Status', 'Category', 'Name']
                    .map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: sortGifts,
                hint: Text('Sort by'),
              ),
            ),
            Expanded(
              child: ListView(
                children: displayedGifts,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
