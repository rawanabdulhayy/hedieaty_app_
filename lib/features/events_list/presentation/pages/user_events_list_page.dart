// import 'package:flutter/material.dart';
// import 'package:hedieaty_app_mvc/core/presentation/widgets/search_bar/search_bar.dart';
// import '../../../../core/app_colors.dart';
// import '../widgets/event_card.dart';
//
// class EventListPage extends StatelessWidget {
//   final TextEditingController searchController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body:
//       Container(
//         width: double.infinity, // Ensures the container takes full width
//         height: double.infinity, // Ensures the container takes full height
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [AppColors.navyBlue,AppColors.brightBlue], // Use defined colors
//           ),
//         ),
//         child: Column(
//           children: [
//             Padding(
//               padding: EdgeInsets.all(10.0),
//               child: CustomSearchBar(controller: controller, onChanged: onChanged, hintText: "Search events...",)
//             ),
//             Padding(
//               padding: EdgeInsets.all(3.0),
//               child: DropdownButton<String>(
//                 items: <String>['Status', 'Category', 'Name']
//                 //ToDo same status, different attrs to gifts'
//                     .map((String value) {
//                   return DropdownMenuItem<String>(
//                     value: value,
//                     child: Text(value),
//                   );
//                 }).toList(),
//                 onChanged: (_) {}, //this needs to filter the data accordingly
//                 hint: Text('Sort by'),
//                 dropdownColor: Colors.white, //ToDo not working???
//
//               ),
//             ),
//             Expanded(
//               child: ListView(
//                 children: [
//                   EventCard(eventName: 'Birthday Party', status: 'Upcoming', category: 'Birthday'),
//                   EventCard(eventName: 'Wedding', status: 'Past', category: 'Wedding'),
//                   // More EventCards...
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// import 'package:flutter/material.dart';
// import 'package:hedieaty_app_mvc/core/config/theme/gradient_background.dart';
// import 'package:hedieaty_app_mvc/core/presentation/widgets/search_bar/search_bar.dart';
// import '../../../../core/app_colors.dart';
// import '../../../../core/presentation/widgets/dropdown_list/custom_dropdown_button.dart';
// import '../widgets/event_card.dart';
//
// class EventListPage extends StatefulWidget {
//   @override
//   _EventListPageState createState() => _EventListPageState();
// }
//
// class _EventListPageState extends State<EventListPage> {
//   final TextEditingController _searchController = TextEditingController();
//   String? _selectedFilter;
//   List<Map<String, String>> _events = [
//     {
//       'eventName': 'Birthday Party',
//       'status': 'Upcoming',
//       'category': 'Birthday'
//     },
//     {'eventName': 'Wedding', 'status': 'Past', 'category': 'Wedding'},
//     // Add more events here...
//   ];
//   List<Map<String, String>> _filteredEvents = [];
//
//   @override
//   void initState() {
//     super.initState();
//     _filteredEvents = _events; // Initialize with all events
//   }
//
//   void _filterEvents(String query) {
//     setState(() {
//       _filteredEvents = _events.where((event) {
//         return event['eventName']!.toLowerCase().contains(query.toLowerCase());
//       }).toList();
//     });
//   }
//
//   void _sortEvents(String? filter) {
//     setState(() {
//       _selectedFilter = filter;
//       if (filter == 'Status') {
//         _filteredEvents.sort((a, b) => a['status']!.compareTo(b['status']!));
//       } else if (filter == 'Category') {
//         _filteredEvents
//             .sort((a, b) => a['category']!.compareTo(b['category']!));
//       } else if (filter == 'Name') {
//         _filteredEvents
//             .sort((a, b) => a['eventName']!.compareTo(b['eventName']!));
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: GradientBackground(
//         child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(10.0),
//                 child: CustomSearchBar(
//                   controller: _searchController,
//                   onChanged: (value) => _filterEvents(value),
//                   hintText: "Search events...",
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 150.0),
//                 child: CustomDropdownButton(
//                   items: ['Status', 'Category', 'Name'],
//                   value: _selectedFilter,
//                   onChanged: _sortEvents,
//                   hint: Text('Sort by', style: TextStyle(color: AppColors.lightAmber)),
//                   iconColor: AppColors.lightAmber,
//                   dropdownColor: Colors.white,
//                   selectedTextStyle: TextStyle(color: AppColors.gold), // Set the selected item color to gold
//                 ),
//
//               ),
//               Expanded(
//                 child: ListView.builder(
//                   padding: const EdgeInsets.all(10.0),
//                   itemCount: _filteredEvents.length,
//                   itemBuilder: (context, index) {
//                     final event = _filteredEvents[index];
//                     return EventCard(
//                       eventName: event['eventName']!,
//                       status: event['status']!,
//                       category: event['category']!,
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//       ),
//       );
//   }
//
//   @override
//   void dispose() {
//     _searchController.dispose();
//     super.dispose();
//   }
// }
import 'package:flutter/material.dart';
import 'package:hedieaty_app_mvc/core/config/theme/gradient_background.dart';
import 'package:hedieaty_app_mvc/core/presentation/widgets/search_bar/search_bar.dart';
import '../../../../core/app_colors.dart';
import '../../../../core/presentation/widgets/dropdown_list/custom_dropdown_button.dart';
import '../../domain/entities/Event.dart';
import '../widgets/event_card.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../domain/repositories/domain_event_repo.dart';

class EventListPage extends StatefulWidget {
  @override
  _EventListPageState createState() => _EventListPageState();
}

class _EventListPageState extends State<EventListPage> {
  final TextEditingController _searchController = TextEditingController();
  String? _selectedFilter;
  List<Event> _events = [];
  List<Event> _filteredEvents = [];

  @override
  void initState() {
    super.initState();
    _loadEvents();
  }

  Future<void> _loadEvents() async {
    try {
      final user = FirebaseAuth.instance.currentUser; // Get the current user
      if (user != null) {
        final domainEventRepository = Provider.of<DomainEventRepository>(context, listen: false);
        final events = await domainEventRepository.getEventsByUserId(user.uid); // Fetch events directly as Event objects

        setState(() {
          _events = events; // Assign directly if already a List<Event>
          _filteredEvents = _events; // Initialize the filtered events
        });
      }
    } catch (e) {
      // Handle any errors that occur during fetching events
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load events: $e')),
      );
    }
  }


  // Determine the status based on the event date
  String getEventStatus(DateTime eventDate) {
    final currentDate = DateTime.now();

    if (eventDate.isBefore(currentDate)) {
      return 'Past';
    } else if (eventDate.isAtSameMomentAs(currentDate) || eventDate.isAfter(currentDate)) {
      return 'Upcoming';
    }
    return 'Unknown';
  }

  // Filter events by the search query
  void _filterEvents(String query) {
    setState(() {
      _filteredEvents = _events.where((event) {
        return event.name.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  // Sort events by the selected filter
  void _sortEvents(String? filter) {
    setState(() {
      _selectedFilter = filter;
      if (filter == 'Status') {
        _filteredEvents.sort((a, b) => getEventStatus(a.date).compareTo(getEventStatus(b.date)));
      } else if (filter == 'Category') {
        _filteredEvents.sort((a, b) => a.type.compareTo(b.type));
      } else if (filter == 'Name') {
        _filteredEvents.sort((a, b) => a.name.compareTo(b.name));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: CustomSearchBar(
                controller: _searchController,
                onChanged: (value) => _filterEvents(value),
                hintText: "Search events...",
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 150.0),
              child: CustomDropdownButton(
                items: ['Status', 'Category', 'Name'],
                value: _selectedFilter,
                onChanged: _sortEvents,
                hint: Text('Sort by', style: TextStyle(color: AppColors.lightAmber)),
                iconColor: AppColors.lightAmber,
                dropdownColor: Colors.white,
                selectedTextStyle: TextStyle(color: AppColors.gold), // Set the selected item color to gold
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(10.0),
                itemCount: _filteredEvents.length,
                itemBuilder: (context, index) {
                  final event = _filteredEvents[index];
                  final eventStatus = getEventStatus(event.date); // Calculate the event status
                  return EventCard(
                    eventName: event.name,
                    status: eventStatus, // Pass the calculated status
                    category: event.type,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
