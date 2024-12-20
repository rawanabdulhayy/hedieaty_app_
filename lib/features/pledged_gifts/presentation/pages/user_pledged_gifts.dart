import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hedieaty_app_mvc/core/config/theme/gradient_background.dart';
import 'package:intl/intl.dart';
import '../../../../core/app_colors.dart';
import '../usecases/depledge_gift.dart';
import '../usecases/fetch_pledged_gifts.dart';

class PledgedGiftsPage extends StatelessWidget {
  const PledgedGiftsPage({Key? key}) : super(key: key);

    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.navyBlue,
          title: Center(
            child: Text(
              'Your Pledged Gifts',
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
        body: GradientBackground(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: StreamBuilder<List<Map<String, dynamic>>>(
              stream: fetchPledgedGifts(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No pledged gifts found'));
                }

                final gifts = snapshot.data!;

                return CustomScrollView(
                  slivers: [
                    SliverPadding(
                      padding: const EdgeInsets.only(top: 16),
                      sliver: SliverGrid(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          childAspectRatio: 1.25,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                        ),
                        delegate: SliverChildBuilderDelegate(
                              (context, index) {
                            final gift = gifts[index];
                            return Card(
                              color: AppColors.brightBlue.withOpacity(0.1),                              margin: const EdgeInsets.all(8),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Gift's Name: ${gift['name'] ?? 'Unknown'}",
                                    style: const TextStyle(
                                      fontSize: 20,
                                      color: AppColors.gold,
                                    ),
                                  ),
                                  Text(
                                    "Friend's Name: ${gift['friendName'] ??
                                        'Unknown'}",
                                    style: const TextStyle(
                                      fontSize: 20,
                                      color: AppColors.gold,
                                    ),
                                  ),
                                  Text(
                                    "Event Date: ${gift['eventDate'] != null
                                        ? gift['eventDate']
                                        : 'Unknown'}",
                                    style: const TextStyle(
                                      fontSize: 20,
                                      color: AppColors.gold,
                                    ),
                                  ),
                                  Text(
                                    "Category: ${gift['category'] ??
                                        'Unknown'}",
                                    style: const TextStyle(
                                      fontSize: 20,
                                      color: AppColors.gold,
                                    ),
                                  ),
                                  Text(
                                    "Price: ${gift['price'] ??
                                        'Unknown'}",
                                    style: const TextStyle(
                                      fontSize: 20,
                                      color: AppColors.gold,
                                    ),
                                  ),
                                  const SizedBox(height: 15),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.gold,
                                    ),
                                    onPressed: () async {
                                      try {
                                        await dePledgeGift(gift['id']);
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(content: Text('Gift successfully de-pledged!')),
                                        );
                                      } catch (e) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(content: Text('Failed to de-pledge gift: $e')),
                                        );
                                      }
                                    },
                                    child: const Text(
                                      'De-Pledge',
                                      style: TextStyle(
                                        fontFamily: "Pacifico",
                                        fontSize: 20,
                                        color: AppColors.navyBlue,
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                            );
                          },
                          childCount: gifts.length,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      );
    }
  }