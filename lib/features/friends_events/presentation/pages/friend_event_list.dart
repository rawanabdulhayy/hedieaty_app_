import 'package:flutter/material.dart';

import '../../../../core/app_colors.dart';

class FriendEventListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Retrieve arguments from `HomePage`
    final Map<String, dynamic> friend = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final String friendName = friend['name'];
    // Extracting event names from the list of maps
    final List<String> events = (friend['events'] as List<dynamic>?)
        ?.map((event) => event['name'] as String)
        .toList() ?? [];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.navyBlue,
        title: Center(
          child: Text(
            '$friendName\'s Events',
            style: TextStyle(
              color: AppColors.gold,
              fontFamily: "Pacifico",
            ),
          ),
        ),
        iconTheme: IconThemeData(
          color: AppColors.gold,
        ),
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
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: events.map((event) {
              return Card(
                color: AppColors.navyBlue.withOpacity(0.1),
                margin: EdgeInsets.symmetric(vertical: 8),
                child: ListTile(
                  title: Text(event,
                    style: TextStyle(
                        color: AppColors.gold,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        fontSize: 20
                    ),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.search, color: AppColors.gold),
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        '/friend_gift_list',
                        arguments: {'friendName': friendName, 'event': event},
                      );
                    },
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
