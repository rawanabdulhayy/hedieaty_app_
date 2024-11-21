import 'package:flutter/material.dart';
import '../../../core/app_colors.dart';

class FriendCard extends StatelessWidget {
  final String friendName;
  final List<String> events;
  final int eventCount;
  final VoidCallback onTap;

  const FriendCard({
    Key? key,
    required this.friendName,
    required this.events,
    required this.eventCount,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.navyBlue.withOpacity(0.1),
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        title: Text(
          friendName,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.gold,
          ),
        ),
        onTap: onTap,
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$eventCount Upcoming Events:',
              style: TextStyle(
                fontSize: 20,
                color: AppColors.lightAmber,
                fontStyle: FontStyle.italic,
              ),
            ),
            SizedBox(height: 4),
            for (var event in events)
              Text(
                '- $event',
                style: TextStyle(
                  fontSize: 18,
                  color: AppColors.gold,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
