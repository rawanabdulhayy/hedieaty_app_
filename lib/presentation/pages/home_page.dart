import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../widgets/friend_card.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Updated list of friends with events as a list
  List<Map<String, dynamic>> friends = [
    {"name": "Alice", "events": ["Birthday on Dec 12", "Wedding on Feb 2"]},
    {"name": "Bob", "events": ["Anniversary on Jan 15"]},
    {"name": "Charlie", "events": ["Birthday on Mar 22"]},
    {"name": "Dave"}, // Friend with no events
  ];

  // Controller for the search text field
  TextEditingController searchController = TextEditingController();
  List<Map<String, dynamic>> filteredFriends = [];

  @override
  void initState() {
    super.initState();
    filteredFriends = friends;
  }

  // Function to filter friends based on search query
  void filterFriends(String query) {
    final results = friends.where((friend) {
      final name = friend['name']!.toLowerCase();
      final events = (friend['events'] ?? []).map((event) => event.toLowerCase()).join(" ");
      final searchQuery = query.toLowerCase();

      return name.contains(searchQuery) || events.contains(searchQuery);
    }).toList();

    setState(() {
      filteredFriends = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.navyBlue, AppColors.brightBlue],
        ),
      ),
      child: Column(
        children: [
          // Search text field
          Padding(
            padding: EdgeInsets.all(16.0),
            child: TextField(
              controller: searchController,
              onChanged: filterFriends,
              decoration: InputDecoration(
                hintText: 'Search friends...',
                hintStyle: TextStyle(
                  color: AppColors.gold,
                ),
                prefixIcon: Icon(Icons.search, color: AppColors.gold),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.brightBlue.withOpacity(0.1), width: 2.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.gold, width: 2.0),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                filled: true,
                fillColor: AppColors.brightBlue.withOpacity(0.1),
              ),
            ),
          ),
          SizedBox(height: 16),

          // List of friends
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
              child: ListView.builder(
                itemCount: filteredFriends.length,
                itemBuilder: (context, index) {
                  final friend = filteredFriends[index];
                  final events = friend['events'] as List<String>? ?? []; // Default to empty list
                  final eventCount = events.length;

                  return FriendCard(
                    friendName: friend['name']!,
                    events: events,
                    eventCount: eventCount,
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/friend_event_list',
                        arguments: friend,
                      );
                    },
                  );
                },
              ),
            ),
          ),

          // Floating action button
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                backgroundColor: AppColors.gold,
                onPressed: () {
                  Navigator.pushNamed(context, '/add_friend');
                },
                child: Icon(
                  Icons.add,
                  color: AppColors.navyBlue,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
