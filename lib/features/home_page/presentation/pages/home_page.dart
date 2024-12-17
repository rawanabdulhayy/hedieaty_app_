import 'package:flutter/material.dart';
import 'package:hedieaty_app_mvc/core/config/theme/gradient_background.dart';
import '../../../../core/app_colors.dart';
import '../../../../core/presentation/widgets/search_bar/search_bar.dart';
import '../../domain/usecases/fetch_User_Friends_and_Their_Events.dart';
import '../widgets/friend_card.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController searchController = TextEditingController();
  List<Map<String, dynamic>> friendsData = []; // Full list of friends and events
  List<Map<String, dynamic>> filteredFriendsData = []; // Filtered list for search

  @override
  void initState() {
    super.initState();
    fetchFriendsAndEvents();
  }
  // Function to fetch friends and their events
  void fetchFriendsAndEvents() async {
    try {
      final data = await fetchAllFriendsAndEvents(); // Use the updated fetch function
      setState(() {
        friendsData = data;
        filteredFriendsData = data;
      });
    } catch (e) {
      print('Error fetching friends and events: $e');
    }
  }

  // Function to filter friends based on search query
  void filterFriends(String query) {
    setState(() {
      filteredFriendsData = friendsData
          .where((friend) =>
          friend['name'].toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Column(
        children: [
          // Search Bar
          Padding(
            padding: EdgeInsets.all(16.0),
            child: CustomSearchBar(
                controller: searchController,
                onChanged: filterFriends,
                hintText: "Search Friends...",
            ),
          ),
          SizedBox(height: 16),

          // Friends and Events List
          Expanded(
            child: filteredFriendsData.isEmpty
                ? Center(
              child: Text(
                'No friends found',
                style: TextStyle(
                  color: AppColors.navyBlue,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
                : ListView.builder(
              itemCount: filteredFriendsData.length,
              itemBuilder: (context, index) {
                final friend = filteredFriendsData[index];
                final events = friend['events'] as List<dynamic>;
                final eventCount = events.length;

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: FriendCard(
                    friendName: friend['name'] as String,
                    events: (friend['events'] as List<dynamic>?)
                        ?.map((event) => event['name'] as String)
                        .toList() ??
                        [],
                    eventCount: eventCount,
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/friend_event_list',
                        arguments: friend,
                      );
                    },
                  ),
                );
              },
            ),
          ),

          // Floating Action Buttons
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                FloatingActionButton(
                  heroTag: 'uniqueTag1',
                  backgroundColor: AppColors.gold,
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor: Colors.amber,
                          title: Text(
                            'Create a new event list',
                            style: TextStyle(
                              color: AppColors.navyBlue,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          content: Text(
                            'Would you like to create an event list?',
                            style: TextStyle(
                              color: AppColors.navyBlue,
                              fontSize: 15,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context); // Close dialog
                                Navigator.pushNamed(
                                    context, '/create_event_list');
                              },
                              child: Text(
                                'Yes, take me there!',
                                style: TextStyle(
                                  color: AppColors.navyBlue,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context); // Close dialog
                              },
                              child: Text(
                                'Nevermind',
                                style: TextStyle(
                                  color: AppColors.navyBlue,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Icon(
                    Icons.add,
                    color: AppColors.navyBlue,
                  ),
                ),
                FloatingActionButton(
                  heroTag: 'uniqueTag2',
                  backgroundColor: AppColors.gold,
                  onPressed: () {
                    Navigator.pushNamed(context, '/add_friend');
                  },
                  child: Icon(
                    Icons.person,
                    color: AppColors.navyBlue,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
