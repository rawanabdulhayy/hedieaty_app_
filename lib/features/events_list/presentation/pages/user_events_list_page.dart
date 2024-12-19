import 'package:flutter/material.dart';
import 'package:hedieaty_app_mvc/core/config/theme/gradient_background.dart';
import 'package:hedieaty_app_mvc/core/presentation/widgets/search_bar/search_bar.dart';
import 'package:intl/intl.dart';
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
  bool _isLoading = true; // Loading flag

  @override
  void initState() {
    super.initState();
    _loadEvents();
  }

  // Future<void> _loadEvents() async {
  //   try {
  //     final user = FirebaseAuth.instance.currentUser; // Get the current user
  //     if (user != null) {
  //       final domainEventRepository = Provider.of<DomainEventRepository>(context, listen: false);
  //       final events = await domainEventRepository.getEventsByUserId(user.uid); // Fetch events directly as Event objects
  //
  //       setState(() {
  //         _events = events; // Assign directly if already a List<Event>
  //         _filteredEvents = _events; // Initialize the filtered events
  //         _isLoading = false; // Data is loaded
  //       });
  //     }
  //   } catch (e) {
  //     // Defer ScaffoldMessenger usage to the widget tree
  //     WidgetsBinding.instance.addPostFrameCallback((_) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('Failed to load events: $e')),
  //       );
  //     });
  //     setState(() {
  //       _isLoading = false; // Set loading to false even in case of error
  //     });
  //   }
  // }
  Future<void> _loadEvents() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        print('No authenticated user found.');
        return;
      }

      final domainEventRepository = Provider.of<DomainEventRepository>(context, listen: false);
      final events = await domainEventRepository.getEventsByUserId(user.uid);

      print('Events loaded: $events');
      setState(() {
        _events = events;
        _filteredEvents = events;
        _isLoading = false;
      });
    } catch (e) {
      print('Error loading events: $e');
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load events: $e')),
        );
      });
      setState(() {
        _isLoading = false;
      });
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
    return  GradientBackground(
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
            // Show CircularProgressIndicator while loading
            if (_isLoading)
              Expanded(
                child: Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(AppColors.gold), // Customize color
                  ),
                ),
              )
            else
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
                      eventId: event.id,
                      location: event.location,
                      description: event.description,
                      date: DateFormat('dd/MM/yyyy').format(event.date), // Convert DateTime to String
                      onDelete: _loadEvents, // Pass the reload function as a callback
                    );
                  },
                ),
              ),
          ],
        ),
      );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
