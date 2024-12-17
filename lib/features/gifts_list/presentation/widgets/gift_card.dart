import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/app_colors.dart';
import '../../domain/repositories/domain_gift_repo.dart';

class GiftCard extends StatelessWidget {
  final Map<String, dynamic> giftData;
  final String eventName;
  final String eventId;
  final VoidCallback onDelete;

  const GiftCard({
    required this.giftData,
    required this.onDelete,
    required this.eventId,
    required this.eventName,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isPledged = giftData['isPledged'] ?? false;
    final statusColor = isPledged ? Colors.red : Colors.green;
    final giftId = giftData['id'];
    final domainGiftRepository = Provider.of<GiftDomainRepository>(context, listen: false);


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
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        '/gift_details',
                        arguments: {
                          'eventName' : eventName,
                          'eventId': eventId,
                          'giftId' : giftId,
                          'giftName': giftData['name'],
                          'giftDescription': giftData['description'],
                          'giftCategory': giftData['category'],
                          'giftPrice': giftData['price'],
                          'giftStatus': giftData['status'],
                        },
                      );
                    },
                  ),
                ),
                SizedBox(height: 25),
              ],
            ),
            const SizedBox(width: 8),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: IconButton(
                    icon: Icon(Icons.delete, color: AppColors.gold),
                    onPressed: () async {
                      try {
                        await domainGiftRepository.deleteGift(giftId);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text('Gift deleted successfully!')),
                        );
                        onDelete();
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Error deleting gift: $e')),
                        );
                      }
                    },
                  ),
                ),
                SizedBox(height: 25),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
