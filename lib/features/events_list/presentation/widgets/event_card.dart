import 'package:flutter/material.dart';

import '../../../../core/app_colors.dart';

class EventCard extends StatelessWidget {
  final String eventName;
  final String status;
  final String category;
  // final VoidCallback onTap;

  const EventCard({super.key, required this.eventName, required this.status, required this.category});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.navyBlue.withOpacity(0.1),
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      child: ListTile(
        leading: Icon(Icons.event, color: AppColors.gold),
        title: Text(eventName,
        style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.gold,
          ),
        ),
        subtitle: Text('$status | $category',
          style: TextStyle(
            fontSize: 15,
            color: AppColors.lightAmber,
            fontStyle: FontStyle.italic,
          ),),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.edit, color: AppColors.gold),
              onPressed: () {
                Navigator.pushNamed(context, '/create_event_list');
              },
            ),
            IconButton(
              icon: Icon(Icons.delete, color: AppColors.gold),
              onPressed: () {
                // Delete event action
              },
            ),
          ],
        ),
        onTap: () {
          Navigator.pushNamed(context, '/user_gift_list');              },
      ),
    );
  }
}
//
// import 'package:flutter/material.dart';
// import '../../../../core/app_colors.dart';
//
// class FriendCard extends StatelessWidget {
//
//   Widget build(BuildContext context) {
//       child: ListTile(
//         title: Text(
//           friendName,
//           style: TextStyle(
//             fontSize: 24,
//             fontWeight: FontWeight.bold,
//             color: AppColors.gold,
//           ),
//         ),
//         onTap: onTap,
//         subtitle: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               '$eventCount Upcoming Events:',
//               style: TextStyle(
//                 fontSize: 20,
//                 color: AppColors.lightAmber,
//                 fontStyle: FontStyle.italic,
//               ),
//             ),
//             SizedBox(height: 4),
//             for (var event in events)
//               Text(
//                 '- $event',
//                 style: TextStyle(
//                   fontSize: 18,
//                   color: AppColors.gold,
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }
