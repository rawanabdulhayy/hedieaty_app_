// import 'package:flutter/material.dart';
//
// import '../../../../core/app_colors.dart';
//
// class EventCard extends StatelessWidget {
//   final String eventName;
//   final String status;
//   final String category;
//   // final VoidCallback onTap;
//
//   const EventCard({super.key, required this.eventName, required this.status, required this.category});
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       color: AppColors.navyBlue.withOpacity(0.1),
//       margin: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
//       child: ListTile(
//         leading: Icon(Icons.event, color: AppColors.gold),
//         title: Text(eventName,
//         style: TextStyle(
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//             color: AppColors.gold,
//           ),
//         ),
//         subtitle: Text('$status | $category',
//           style: TextStyle(
//             fontSize: 15,
//             color: AppColors.lightAmber,
//             fontStyle: FontStyle.italic,
//           ),),
//         trailing: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             IconButton(
//               icon: Icon(Icons.edit, color: AppColors.gold),
//               onPressed: () {
//                 Navigator.pushNamed(context, '/create_event_list');
//               },
//             ),
//             IconButton(
//               icon: Icon(Icons.delete, color: AppColors.gold),
//               onPressed: () {
//                 // Delete event action
//               },
//             ),
//           ],
//         ),
//         onTap: () {
//           Navigator.pushNamed(context, '/user_gift_list');              },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/app_colors.dart';
import '../../domain/repositories/domain_event_repo.dart';

class EventCard extends StatelessWidget {
  final String eventName;
  final String eventId;
  final String status;
  final String category;
  final String location;
  final String description;
  final String date;
  final VoidCallback onDelete;


  const EventCard({
    super.key,
    required this.eventName,
    required this.status,
    required this.category,
    required this.eventId,
    required this.date,
    required this.description,
    required this.location,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final domainEventRepository = Provider.of<DomainEventRepository>(context, listen: false);

    return Card(
      color: AppColors.navyBlue.withOpacity(0.1),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      child: ListTile(
        leading: Icon(Icons.event, color: AppColors.gold),
        title: Text(
          eventName,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.gold,
          ),
        ),
        subtitle: Text(
          '$status | $category',
          style: TextStyle(
            fontSize: 15,
            color: AppColors.lightAmber,
            fontStyle: FontStyle.italic,
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.edit, color: AppColors.gold),
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/create_event_list',
                  arguments: {
                    'eventId' : eventId,
                    'eventName': eventName,
                    'eventLocation': location,
                    'eventDate': date,
                    'eventDescription': description,
                    'eventType': category,
                  },
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.delete, color: AppColors.gold),
              onPressed: ()  async {
                try {
                  await domainEventRepository.deleteEvent(eventId);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Event deleted successfully!')),
                  );
                  onDelete();
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error deleting event: $e')),
                  );
                }
              },
            ),
          ],
        ),
        onTap: () {
          Navigator.pushNamed(
            context,
            '/user_gift_list',
            arguments:
            {'eventName': eventName,
            'eventId': eventId,
            }, // Pass arguments dynamically
          );
        },
      ),
    );
  }
}

