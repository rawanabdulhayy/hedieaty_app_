// import 'package:flutter/material.dart';
// import 'package:hedieaty_app_mvc/features/gifts_list/presentation/widgets/status_indicator.dart';
// import '../../../../core/app_colors.dart';
//
// class GiftCard extends StatelessWidget {
//   //TODO: This should follow a similar styling to the event card and I think I can just fetch the required shown data from firestore gifts collection instead of having them hardcoded at usersgift list
//   final String giftName;
//   final String status;
//   final String category;
//
//   GiftCard({required this.giftName, required this.status, required this.category});
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       color: Colors.white,
//       margin: EdgeInsets.all(8.0),
//       child: ListTile(
//         leading: Icon(Icons.card_giftcard, color: AppColors.navyBlue),
//         title: Text(giftName, style: TextStyle(color: AppColors.navyBlue)),
//         subtitle: Row(
//           children: [
//             StatusIndicator(status: status), // Status indicator circle
//             SizedBox(width: 8.0),
//             Text("$status - $category"),
//           ],
//         ),
//         trailing: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             IconButton(
//               icon: Icon(Icons.edit, color: AppColors.gold),
//               onPressed: () {
//                 //TODO: This page should be navigated to holding the current context of the navigated from page and prefilling the gift details page with all the current gift data to edit and save.
//                 Navigator.pushNamed(context, '/gift_details');
//               },
//             ),
//             IconButton(
//               icon: Icon(Icons.delete, color:  AppColors.gold),
//               onPressed: () {
//                 //ToDo function for removing it -- delete gift from our db
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class GiftCard extends StatelessWidget {
  final Map<String, dynamic> giftData;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const GiftCard({
    required this.giftData,
    required this.onEdit,
    required this.onDelete,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(giftData['name'] ?? 'Unknown'),
        subtitle: Text('Category: ${giftData['category']}, Budget: \$${giftData['budget']}'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: onEdit,
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}
