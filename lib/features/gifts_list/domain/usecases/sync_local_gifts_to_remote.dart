import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../repositories/domain_gift_repo.dart';

Future<void> syncLocalGiftsToRemote(BuildContext context) async {
  try {
    final giftDomainRepository = Provider.of<GiftDomainRepository>(context, listen: false);

    // Fetch unsynced gifts from the local repository
    final unsyncedGifts = await giftDomainRepository.getUnsyncedGifts();

    for (final gift in unsyncedGifts) {
      // Push the gift to the remote repository
      await giftDomainRepository.upsertRemoteGift(gift);

      // Mark the gift as synced in the local database
      await giftDomainRepository.markGiftAsSynced(gift.id);
    }
  } catch (e) {
    throw Exception('Error during gift synchronization: $e');
  }
}
