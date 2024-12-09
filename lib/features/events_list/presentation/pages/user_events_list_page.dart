import 'package:flutter/material.dart';
import '../../../../core/app_colors.dart';
import '../widgets/event_card.dart';

class EventListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Container(
        width: double.infinity, // Ensures the container takes full width
        height: double.infinity, // Ensures the container takes full height
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.navyBlue,AppColors.brightBlue], // Use defined colors
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(10.0),
              child: TextField(
                //this needs to be functional
                decoration: InputDecoration(
                  filled: true, // Optional: if you want to fill the background
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.brightBlue, width: 2.0), // Change enabled border color
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.gold, width: 2.0), // Change focused border color
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 2.0), // Change error border color
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.redAccent, width: 2.0), // Change focused error border color
                  ),
                  hintText: 'Search events...',
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
                items: <String>['Status', 'Category', 'Name']
                //ToDo same status, different attrs to gifts'
                    .map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (_) {}, //this needs to filter the data accordingly
                hint: Text('Sort by'),
                dropdownColor: Colors.white, //ToDo not working???

              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  EventCard(eventName: 'Birthday Party', status: 'Upcoming', category: 'Birthday'),
                  EventCard(eventName: 'Wedding', status: 'Past', category: 'Wedding'),
                  // More EventCards...
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}