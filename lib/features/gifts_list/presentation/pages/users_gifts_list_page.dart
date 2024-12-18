// // import 'package:flutter/material.dart';
// // import 'package:hedieaty_app_mvc/core/config/theme/gradient_background.dart';
// // import 'package:provider/provider.dart';
// // import '../../../../core/app_colors.dart';
// // import '../../../../core/presentation/widgets/dropdown_list/custom_dropdown_button.dart'
// // as customWidget;
// // import '../../../../core/presentation/widgets/search_bar/search_bar.dart';
// // import '../providers/gift_provider.dart';
// // import '../widgets/gift_card.dart';
// // import '../../domain/entity/Gift.dart';
// // import '../../domain/repositories/domain_gift_repo.dart';
// // import 'gift_details.dart';
// //
// // class GiftListPage extends StatelessWidget {
// //   final String eventName;
// //   final String eventId;
// //
// //   const GiftListPage({required this.eventName, Key? key, required this.eventId})
// //       : super(key: key);
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     final provider = Provider.of<GiftProvider>(context, listen: false);
// //     final giftRepository = Provider.of<GiftDomainRepository>(context);
// //
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Gifts for: $eventName'),
// //       ),
// //       body: GradientBackground(
// //         child: Column(
// //           children: [
// //             Padding(
// //               padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
// //               child: CustomSearchBar(
// //                 onChanged: provider.filterGifts,
// //                 controller: TextEditingController(),
// //                 hintText: "Search Gifts...",
// //               ),
// //             ),
// //             Padding(
// //               padding: const EdgeInsets.symmetric(horizontal: 150.0, vertical: 8.0),
// //               child: customWidget.CustomDropdownButton(
// //                 items: provider.filterCriteria,
// //                 onChanged: provider.updateCriteria,
// //                 hint: const Text('Sort by',
// //                     style: TextStyle(color: AppColors.lightAmber)),
// //                 iconColor: AppColors.lightAmber,
// //                 dropdownColor: Colors.white,
// //                 selectedTextStyle: TextStyle(color: AppColors.gold),
// //               ),
// //             ),
// //             Expanded(
// //               child: FutureBuilder<List<Gift>>(
// //                 future: giftRepository.getGiftsByEventId(eventId) as Future<List<Gift>>?,
// //                 builder: (context, snapshot) {
// //                   if (snapshot.connectionState == ConnectionState.waiting) {
// //                     return const Center(child: CircularProgressIndicator());
// //                   }
// //
// //                   if (snapshot.hasError) {
// //                     return const Center(child: Text('Error loading gifts.'));
// //                   }
// //
// //                   final gifts = snapshot.data ?? [];
// //
// //                   if (gifts.isEmpty) {
// //                     return const Center(
// //                         child: Text('No gifts found for this event.'));
// //                   }
// //
// //                   return ListView.builder(
// //                     itemCount: gifts.length,
// //                     itemBuilder: (context, index) {
// //                       final gift = gifts[index];
// //
// //                       return GiftCard(
// //                         giftData: gift.toMap(),
// //                         onEdit: () {
// //                           Navigator.push(
// //                             context,
// //                             MaterialPageRoute(
// //                               builder: (context) => GiftDetailsPage(
// //                                 gift: gift,
// //                                 eventId: eventId,
// //                                 eventName: eventName,
// //                               ),
// //                             ),
// //                           );
// //                         },
// //                         onDelete: () async {
// //                           await giftRepository.deleteGift(gift.id);
// //                         },
// //                       );
// //                     },
// //                   );
// //                 },
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //       floatingActionButton: FloatingActionButton(
// //         child: const Icon(Icons.add),
// //         onPressed: () {
// //           Navigator.pushNamed(
// //             context,
// //             '/gift_details',
// //             arguments: {
// //               'eventName': eventName,
// //               'eventId': eventId,
// //             },
// //           );
// //         },
// //       ),
// //     );
// //   }
// // }
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import '../../../../core/app_colors.dart';
// import '../../../../core/config/theme/gradient_background.dart';
// import '../../../../core/presentation/widgets/dropdown_list/custom_dropdown_button.dart';
// import '../../../../core/presentation/widgets/search_bar/search_bar.dart';
// import '../../domain/entity/Gift.dart';
// import '../../domain/repositories/domain_gift_repo.dart';
// import '../providers/gift_provider.dart';
// import '../widgets/gift_card.dart';
// import 'gift_details.dart';
//
// class GiftListPage extends StatefulWidget {
//   final String eventName;
//   final String eventId;
//
//   const GiftListPage({required this.eventName, Key? key, required this.eventId})
//       : super(key: key);
//
//   @override
//   State<GiftListPage> createState() => _GiftListPageState();
// }
//
// class _GiftListPageState extends State<GiftListPage> {
//   late Future<List<Gift>> _giftsFuture;
//
//   @override
//   void initState() {
//     super.initState();
//     _reloadGifts();
//   }
//   void _reloadGifts() async {
//     try {
//       final giftRepository =
//       Provider.of<GiftDomainRepository>(context, listen: false);
//
//       // Show loading indicator
//       setState(() {
//         _giftsFuture = Future.value([]); // Temporary empty list while loading
//       });
//
//       // Fetch gifts from the repository
//       final gifts = await giftRepository.getGiftsByEventId(widget.eventId);
//
//       // Update the future with fetched gifts
//       setState(() {
//         _giftsFuture = Future.value(gifts);
//       });
//     } catch (e) {
//       // Handle errors gracefully
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Failed to load gifts: $e')),
//       );
//
//       // Stop loading and preserve the previous state
//       setState(() {
//         _giftsFuture = Future.value([]);
//       });
//     }
//   }
//
//   // void _reloadGifts() {
//   //   final giftRepository = Provider.of<GiftDomainRepository>(context, listen: false);
//   //   _giftsFuture = giftRepository.getGiftsByEventId(widget.eventId);
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<GiftProvider>(context, listen: false);
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Gifts for: ${widget.eventName}'),
//       ),
//       body: GradientBackground(
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//               child: CustomSearchBar(
//                 onChanged: provider.filterGifts,
//                 controller: TextEditingController(),
//                 hintText: "Search Gifts...",
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 150.0, vertical: 8.0),
//               child: CustomDropdownButton(
//                 items: provider.filterCriteria,
//                 onChanged: provider.updateCriteria,
//                 hint: const Text('Sort by',
//                     style: TextStyle(color: AppColors.lightAmber)),
//                 iconColor: AppColors.lightAmber,
//                 dropdownColor: Colors.white,
//                 selectedTextStyle: TextStyle(color: AppColors.gold),
//               ),
//             ),
//             Expanded(
//               child: FutureBuilder<List<Gift>>(
//                 future: _giftsFuture,
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return const Center(child: CircularProgressIndicator());
//                   }
//
//                   if (snapshot.hasError) {
//                     return const Center(child: Text('Error loading gifts.'));
//                   }
//
//                   final gifts = snapshot.data ?? [];
//
//                   if (gifts.isEmpty) {
//                     return const Center(
//                         child: Text('No gifts found for this event.'));
//                   }
//
//                   return ListView.builder(
//                     itemCount: gifts.length,
//                     itemBuilder: (context, index) {
//                       final gift = gifts[index];
//
//                       return GiftCard(
//                         giftData: gift.toMap(),
//                         eventName: widget.eventName,
//                         eventId: widget.eventId,
//                         onEdit:_reloadGifts,
//                         onDelete: _reloadGifts,
//                       );
//                     },
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         child: const Icon(Icons.add),
//         onPressed: () async {
//           await Navigator.pushNamed(
//             context,
//             '/gift_details',
//             arguments: {
//               'eventName': widget.eventName,
//               'eventId': widget.eventId,
//               'giftId' : '',
//               'giftName': '',
//               'giftDescription': '',
//               'giftCategory': '',
//               'giftPrice': '',
//               'giftStatus': '',
//             },
//           );
//           _reloadGifts();
//           setState(() {});
//         },
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/app_colors.dart';
import '../../../../core/config/theme/gradient_background.dart';
import '../../../../core/presentation/widgets/dropdown_list/custom_dropdown_button.dart';
import '../../../../core/presentation/widgets/search_bar/search_bar.dart';
import '../../domain/entity/Gift.dart';
import '../../domain/repositories/domain_gift_repo.dart';
import '../providers/gift_provider.dart';
import '../widgets/gift_card.dart';

class GiftListPage extends StatefulWidget {
  final String eventName;
  final String eventId;

  const GiftListPage({required this.eventName, Key? key, required this.eventId})
      : super(key: key);

  @override
  State<GiftListPage> createState() => _GiftListPageState();
}

class _GiftListPageState extends State<GiftListPage> {
  late Future<List<Gift>> _giftsFuture;

  @override
  void initState() {
    super.initState();
    _reloadGifts();
    super.initState();
    final provider = Provider.of<GiftProvider>(context, listen: false);
    provider.fetchGifts(widget.eventId); // Fetch gifts on init
  }

  void _reloadGifts() {
    final giftRepository =
    Provider.of<GiftDomainRepository>(context, listen: false);
    setState(() {
      _giftsFuture = giftRepository.getGiftsByEventId(widget.eventId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GiftProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('Gifts for: ${widget.eventName}'),
      ),
      body: GradientBackground(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: CustomSearchBar(
                onChanged: provider.filterGifts,
                controller: TextEditingController(),
                hintText: "Search Gifts...",
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 150.0, vertical: 8.0),
              child: CustomDropdownButton(
                items: provider.filterCriteria,
                onChanged: provider.updateCriteria,
                hint: const Text('Sort by',
                    style: TextStyle(color: AppColors.lightAmber)),
                iconColor: AppColors.lightAmber,
                dropdownColor: Colors.white,
                selectedTextStyle: const TextStyle(color: AppColors.gold),
              ),
            ),
            Expanded(
              child: FutureBuilder<List<Gift>>(
                future: _giftsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return const Center(child: Text('Error loading gifts.'));
                  }

                  final gifts = snapshot.data ?? [];

                  if (gifts.isEmpty) {
                    return const Center(child: Text('No gifts found for this event.'));
                  }

                  return ListView.builder(
                    itemCount: gifts.length,
                    itemBuilder: (context, index) {
                      final gift = gifts[index];
                      return GiftCard(
                        giftData: gift.toMap(),
                        eventName: widget.eventName,
                        eventId: widget.eventId,
                        onDelete: _reloadGifts,
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
        onPressed: () async {
          final result = await Navigator.pushNamed(
            context,
            '/gift_details',
            arguments: {
              'eventName': widget.eventName,
              'eventId': widget.eventId,
              'giftId': '',
              'giftName': '',
              'giftDescription': '',
              'giftCategory': '',
              'giftPrice': 0.0,
              'giftStatus': 'Available',
            },
          );

          if (result == true) {
            _reloadGifts();
          }
        },
      ),
    );
  }
}
//TODO: Apply the provider functions here
