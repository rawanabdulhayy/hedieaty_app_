import 'package:flutter/material.dart';

import '../../../../core/app_colors.dart';

class GiftCard extends StatelessWidget {
  final String giftName;
  final String status;
  final String category;

  GiftCard({
    required this.giftName,
    required this.status,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.navyBlue.withOpacity(0.1),
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        child: Row(
          children: [
            // Left side with color-coded circle, gift name, and subtitle
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
                SizedBox(width: 10),
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
                      '$status | $category',
                      style: TextStyle(color: AppColors.gold),
                    ),
                  ],
                ),
              ],
            ),
            Spacer(),
            // Right side with the "Pledge" button
            ElevatedButton(
              onPressed: status == 'Available'
                  ? () {
                // Action to pledge the gift
                // and actually change status to pledged
                //yet only because this very user is the one who pledged
                //he has an option to depledge
              }
                  : null, //disabled button
              style: ElevatedButton.styleFrom(
                backgroundColor: status == 'Available' ? AppColors.gold : Colors.grey,
              ),
              child: Text(
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