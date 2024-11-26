// import 'package:flutter/material.dart';
// import 'package:hedieaty_app_mvc/core/widgets/search_bar.dart';
// import '../../core/app_colors.dart';
// import '../../data/data_repo/sample_friends.dart';
// import '../../data/entity/friend.dart';
// import '../widgets/friend_card.dart';
//
// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//
//   // Controller for the search text field
//   TextEditingController searchController = TextEditingController();
//   List<Friend> filteredFriends = [];
//
//   @override
//   void initState() {
//     super.initState();
//     filteredFriends = sampleFriends; // Initialize filteredFriends with sampleFriends
//   }
//
//   // Function to filter friends based on search query
//   void filterFriends(String query) {
//     final results = sampleFriends.where((friend) {
//       final name = friend.name.toLowerCase();
//       final events = friend.events.map((event) => event.toLowerCase()).join(" ");
//       final searchQuery = query.toLowerCase();
//
//       return name.contains(searchQuery) || events.contains(searchQuery);
//     }).toList();
//
//     setState(() {
//       filteredFriends = results;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       height: double.infinity,
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: [AppColors.navyBlue, AppColors.brightBlue],
//         ),
//       ),
//       child: Column(
//         children: [
//           // Search text field
//           Padding(
//             padding: EdgeInsets.all(16.0),
//             child: CustomSearchBar(controller: searchController, onChanged: (String ) {},),
//           ),
//           SizedBox(height: 16),
//
//           // List of friends
//           Expanded(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
//               child: ListView.builder(
//                 itemCount: filteredFriends.length,
//                 itemBuilder: (context, index) {
//                   final friend = filteredFriends[index];
//                   final events = friend.events; // Get events from the Friend model
//                   final eventCount = events.length;
//
//                   return FriendCard(
//                     friendName: friend.name,
//                     events: events,
//                     eventCount: eventCount,
//                     onTap: () {
//                       Navigator.pushNamed(
//                         context,
//                         '/friend_event_list',
//                         arguments: friend,
//                       );
//                     },
//                   );
//                 },
//               ),
//             ),
//           ),
//
//           // Floating action button
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Align(
//               alignment: Alignment.bottomRight,
//               child: FloatingActionButton(
//                 backgroundColor: AppColors.gold,
//                 onPressed: () {
//                   Navigator.pushNamed(context, '/add_friend');
//                 },
//                 child: Icon(
//                   Icons.add,
//                   color: AppColors.navyBlue,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import '../../../../core/app_colors.dart';
import '../../../../core/domain/models/User.dart';
import '../../../../core/presentation/widgets/search_bar/search_bar.dart';
import '../../data/repository/friend_repository.dart';
import '../../domain/usecases/filter_friends_use_case.dart';
import '../widgets/friend_card.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Controller for the search text field
  TextEditingController searchController = TextEditingController();
  List<User> filteredFriends = [];
  final FilterFriendsUseCase _filterFriendsUseCase = FilterFriendsUseCase();
  final FriendRepository _friendRepository = FriendRepository();

  @override
  void initState() {
    super.initState();
    filteredFriends = _friendRepository.getFriends(); // Initialize with all friends
  }

  // Function to filter friends based on search query
  void filterFriends(String query) {
    setState(() {
      filteredFriends = _filterFriendsUseCase.execute(_friendRepository.getFriends(), query);
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
            child: CustomSearchBar(controller: searchController, onChanged: filterFriends),
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
                  final events = friend.events;
                  final eventCount = events.length;

                  return FriendCard(
                    friendName: friend.name,
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
