import 'package:flutter/material.dart';
import '../../../../core/app_colors.dart';

class FriendGiftCard extends StatelessWidget {
  final String giftId;
  final String giftName;
  final String status;
  final String category;
  final num price;
  final bool isPledged;
  final String pledgedBy;
  final VoidCallback onPledge;

  FriendGiftCard({
    required this.giftId,
    required this.giftName,
    required this.status,
    required this.category,
    required this.price,
    required this.pledgedBy,
    required this.isPledged,
    VoidCallback? onPledge, // Allow null here
    Key? key,
  }) : onPledge = onPledge ?? defaultOnPledge, // Assign default when null
        super(key: key);

  static void defaultOnPledge() {}
  // This ensures that if no function is provided for onPledge, a no-op function is used instead, preventing the Null error.
  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.navyBlue.withOpacity(0.1),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        child: Row(
          children: [
            Row(
              children: [
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: status == 'Available' ? Colors.green : Colors.red,
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      giftName,
                      style: TextStyle(
                        color: AppColors.gold,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '$status | $category | $price',
                      style: TextStyle(color: AppColors.gold),
                    ),
                  ],
                ),
              ],
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: status == 'Available' ? onPledge : null,
              style: ElevatedButton.styleFrom(
                backgroundColor:
                status == 'Available' ? AppColors.gold : Colors.grey,
              ),
              child: const Text(
                'Pledge',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
