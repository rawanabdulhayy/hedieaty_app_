import 'package:flutter/material.dart';
import 'package:hedieaty_app_mvc/core/config/theme/gradient_background.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../core/app_colors.dart';
import '../../../../core/presentation/widgets/dropdown_list/custom_dropdown_button.dart' as customWidget;
import '../../../../core/presentation/widgets/search_bar/search_bar.dart';
import '../providers/gift_provider.dart';
import '../widgets/gift_card.dart';
import 'gift_details.dart';

class GiftListPage extends StatelessWidget {
  final String eventName;
  final String eventId;

  const GiftListPage({required this.eventName, Key? key, required this.eventId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //so supposedly the dynamic ongenerate routes handle the args passing between pages?
    //and supposedly provider has nth to do with such data passing, it only ever updates and filters gifts?
    final provider = Provider.of<GiftProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('Gifts for: $eventName'),
      ),
      body: GradientBackground(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: CustomSearchBar(
                onChanged: provider.filterGifts,
                controller: TextEditingController(), //searchcontroller should be added
                hintText: "Search Gifts...",
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 150.0, vertical: 8.0),
              child: customWidget.CustomDropdownButton(
                items: provider.filterCriteria,
                onChanged: provider.updateCriteria,
                hint: const Text('Sort by', style: TextStyle(color: AppColors.lightAmber)),
                iconColor: AppColors.lightAmber,
                dropdownColor: Colors.white,
                selectedTextStyle: TextStyle(color: AppColors.gold),
              ),
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('gifts')
                    .where('eventId', isEqualTo: eventId)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
        
                  if (snapshot.hasError) {
                    return const Center(child: Text('Error loading gifts.'));
                  }
        
                  final gifts = snapshot.data?.docs ?? [];
        
                  if (gifts.isEmpty) {
                    return const Center(child: Text('No gifts found for this event.'));
                  }
        
                  return ListView.builder(
                    itemCount: gifts.length,
                    itemBuilder: (context, index) {
                      final giftData = gifts[index].data() as Map<String, dynamic>?;
        
                      if (giftData == null) {
                        return const SizedBox();
                      }
        
                      return GiftCard(
                        giftData: giftData,
                        onEdit: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => GiftDetailsPage(
                                // giftData: giftData,
                                eventId: eventId, eventName: eventName,
                              ),
                            ),
                          );
                        },
                        onDelete: () async {
                          await FirebaseFirestore.instance
                              .collection('gifts')
                              .doc(gifts[index].id)
                              .delete();
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(
            context,
            '/gift_details',
            arguments: {
              'eventName': eventName,
              'eventId': eventId,
            },
          );
        },
      ),
    );
  }
}
