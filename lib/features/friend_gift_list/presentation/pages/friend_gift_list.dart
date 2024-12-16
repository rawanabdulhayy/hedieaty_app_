import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hedieaty_app_mvc/core/config/theme/gradient_background.dart';
import '../../../../core/app_colors.dart';
import '../../../../core/presentation/widgets/dropdown_list/custom_dropdown_button.dart';
import '../../../../core/presentation/widgets/search_bar/search_bar.dart';
import '../../../friend_gift_list/presentation/widgets/friend_gift_card.dart';
import '../usecases/fetch_gifts_for_events.dart';
import '../usecases/get_current_user_name.dart';
import '../usecases/pledge_gift.dart';


class FriendGiftListPage extends StatefulWidget {
  @override
  _FriendGiftListPageState createState() => _FriendGiftListPageState();
}

class _FriendGiftListPageState extends State<FriendGiftListPage> {
  TextEditingController searchController = TextEditingController();
  String? dropdownValue; // No default to allow hint to display initially
  List<FriendGiftCard> allGifts = [];
  List<FriendGiftCard> displayedGifts = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadGifts(); // Load gifts when the dependencies are available
  }

  Future<void> _loadGifts() async {
    final Map<String, dynamic> args =
    ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final String eventId = args['eventId'];

    try {
      final giftsData = await fetchGiftsForEvent(eventId);
      setState(() {
        allGifts = giftsData.map((gift) {
          print('onPledge for gift ${gift['name']} is ${gift['status'] == 'Available' ? "set" : "default"}');
          return FriendGiftCard(
            giftName: gift['name'],
            giftId : gift ['id'],
            status: gift['status'],
            category: gift['category'],
            price: gift['price'],
            isPledged: gift['isPledged'] ?? false,
            pledgedBy: gift['pledgedBy'] ?? '',
            onPledge: gift['status'] == 'Available'
                ? () => _pledgeGift(
              gift['id'],
              args['friendName'],
              gift['name'],
              gift['status'],
            )
                : FriendGiftCard.defaultOnPledge, // Use default when not available
          );
        }).toList();
        displayedGifts = allGifts;

      });
    } catch (e) {
      print('Error loading gifts: $e');
    }
  }
  Future<void> _pledgeGift(String giftId, String friendName, String giftName, String status) async {
    if (status != 'Available') return;

    try {
      // Get the current user's authentication ID
      final currentUserId = FirebaseAuth.instance.currentUser?.uid;

      if (currentUserId == null) {
        throw Exception("User not logged in.");
      }

      // Fetch the current user's name (if necessary)
      final currentUserName = await getCurrentUserName();

      // Pledge the gift
      await pledgeGift(giftId, currentUserName);

      // Update the Firestore users collection
      final userRef = FirebaseFirestore.instance.collection('users').doc(currentUserId);

      await userRef.update({
        'pledgedGifts': FieldValue.arrayUnion(["$giftId"])
      });

      // Update local state
      setState(() {
        allGifts = allGifts.map((gift) {
          if (gift.giftName == giftName) {
            return FriendGiftCard(
              giftId: gift.giftId,
              giftName: gift.giftName,
              status: 'Pledged',
              category: gift.category,
              price: gift.price,
              isPledged: true,
              pledgedBy: currentUserName,
              onPledge: gift.onPledge,
            );
          }
          return gift;
        }).toList();

        displayedGifts = allGifts;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gift pledged successfully!'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error pledging gift: $e'),
          backgroundColor: Colors.red,
        ),
      );
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

        // Sorting logic
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
      body: GradientBackground(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: CustomSearchBar(
                controller: searchController,
                onChanged: filterGifts,
                hintText: 'Search gifts...',
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 150.0, vertical: 5.0),
              child: CustomDropdownButton(
                value: dropdownValue,
                items: ['Status', 'Category', 'Name'],
                onChanged: sortGifts,
                hint: Text(
                  'Sort by',
                  style: TextStyle(color: AppColors.gold),
                ),
                iconColor: AppColors.gold,
                dropdownColor: AppColors.brightBlue.withOpacity(0.9),
                selectedTextStyle: TextStyle(color: AppColors.gold),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ListView(
                  children: displayedGifts,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
