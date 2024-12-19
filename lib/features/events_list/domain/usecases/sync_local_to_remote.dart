import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../repositories/domain_event_repo.dart';

Future<void> syncLocalToRemote(BuildContext context) async {
  try {
    final domainEventRepository = Provider.of<DomainEventRepository>(context, listen: false);

    // Fetch unSynced events from the local repository
    final unSyncedEvents = await domainEventRepository.getUnsyncedEvents();

    for (final event in unSyncedEvents) {
      await domainEventRepository.upsertRemoteEvent(event);

      // Mark the event as synced in the local database
      await domainEventRepository.markEventAsSynced(event.id);
    }
  } catch (e) {
    throw Exception('Error during synchronization: $e');
  }
}
