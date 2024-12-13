import 'package:flutter/material.dart';
import '../../../../core/app_colors.dart';

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
    final isPledged = giftData['isPledged'] ?? false;
    final statusColor = isPledged ? Colors.red : Colors.green;

    return Card(
      color: AppColors.navyBlue.withOpacity(0.1),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      child: ListTile(
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: Icon(Icons.card_giftcard, color: AppColors.gold)),
            const SizedBox(height: 30),
            Expanded(
              child: CircleAvatar(
                radius: 7,
                backgroundColor: statusColor,
              ),
            ),
          ],
        ),
        title: Text(
          giftData['name'] ?? 'Unknown',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.gold,
          ),
        ),
        subtitle: Text(
          'Category: ${giftData['category'] ?? 'Unknown'}\nStatus: ${giftData['status'] ?? 'Unknown'}',
          style: TextStyle(
            fontSize: 15,
            color: AppColors.lightAmber,
            fontStyle: FontStyle.italic,
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: IconButton(
                    icon: Icon(Icons.edit, color: AppColors.gold),
                    onPressed: onEdit,
                  ),
                ),
                SizedBox(height: 25),
                Expanded(
                  child: Text(
                    'Edit',
                    style: TextStyle(
                      fontSize: 15,
                      color: AppColors.gold,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 8),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: IconButton(
                    icon: Icon(Icons.delete, color: AppColors.gold),
                    onPressed: onDelete,
                  ),
                ),
                SizedBox(height: 25),
                Expanded(
                  child: Text(
                    'Delete',
                    style: TextStyle(
                      fontSize: 15,
                      color: AppColors.gold,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
