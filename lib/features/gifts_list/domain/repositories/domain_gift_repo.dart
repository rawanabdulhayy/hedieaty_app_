// // gift_domain_repo.dart
// import 'package:uuid/uuid.dart';
// import '../../data/remote/models/gift_remote_model.dart';
// import '../../data/remote/repositories/gift_remote_repo.dart';
// import '../entity/Gift.dart';
//
// class GiftDomainRepository {
//   final GiftRemoteRepository _giftRemoteRepository;
//
//   GiftDomainRepository(this._giftRemoteRepository);
//
//   Future<void> upsertGift(Gift gift) async {
//     final giftId = gift.id.isEmpty ? const Uuid().v4() : gift.id;
//     final remoteGiftModel = GiftRemoteModel.fromDomain(gift).copyWith(id: giftId);
//     await _giftRemoteRepository.upsertGift(remoteGiftModel);
//   }
//
//   Future<Gift?> getGiftById(String giftId) async {
//     final remoteGiftModel = await _giftRemoteRepository.getGiftById(giftId);
//     if (remoteGiftModel == null) return null;
//     return remoteGiftModel.toDomain();
//   }
//
//   Future<List<Gift>> getGiftsByEventId(String eventId) async {
//     final remoteGifts = await _giftRemoteRepository.getGiftsByEventId(eventId);
//     return remoteGifts.map((remoteGift) => remoteGift.toDomain()).toList();
//   }
//
//   Future<void> deleteGift(String giftId) async {
//     await _giftRemoteRepository.deleteGift(giftId);
//   }
// }
// Similarly, update GiftDomainRepository

import 'package:uuid/uuid.dart';
import '../../data/local/repositories/local_gift_repo.dart';
import '../../data/remote/models/gift_remote_model.dart';
import '../../data/remote/repositories/gift_remote_repo.dart';
import '../entity/Gift.dart';
//TODO: Revise differences in functions between this and the previous version that only used remote repo
class GiftDomainRepository {
  final GiftRemoteRepository _giftRemoteRepository;
  final GiftLocalRepository _giftLocalRepository;

  GiftDomainRepository({
    required GiftRemoteRepository remoteRepo,
    required GiftLocalRepository localRepo,
  })  : _giftRemoteRepository = remoteRepo,
        _giftLocalRepository = localRepo;

  Future<List<Gift>> getUnsyncedGifts() async {
    final localGifts = await _giftLocalRepository.getUnsyncedGifts();
    return localGifts.map((e) => e.toDomain()).toList();
  }

  Future<void> markGiftAsSynced(String giftId) async {
    await _giftLocalRepository.markGiftAsSynced(giftId);
  }


  Future<void> upsertGift(Gift gift) async {
    // Generate the gift ID if it doesn't already exist
    final giftId = gift.id.isEmpty ? const Uuid().v4() : gift.id;

    // Create a domain model with the updated ID
    final updatedGift = gift.copyWith(id: giftId);

    if (_shouldUseLocal()) {
      await _giftLocalRepository.upsertGift(updatedGift.toLocalModel());
    } else {
      await _giftRemoteRepository.upsertGift(
          GiftRemoteModel.fromDomain(updatedGift));
    }
  }

  Future<void> upsertRemoteGift(Gift gift) async {
    // Generate the gift ID if it doesn't already exist
    final giftId = gift.id.isEmpty ? const Uuid().v4() : gift.id;

    // Create a domain model with the updated ID
    final updatedGift = gift.copyWith(id: giftId);

      await _giftRemoteRepository.upsertGift(
          GiftRemoteModel.fromDomain(updatedGift));

  }



  Future<Gift?> getGiftById(String giftId) async {
    if (_shouldUseLocal()) {
      final localGift = await _giftLocalRepository.getGiftById(giftId);
      return localGift?.toDomain();
    } else {
      final remoteGiftModel = await _giftRemoteRepository.getGiftById(giftId);
      return remoteGiftModel?.toDomain();
    }
  }

  Future<List<Gift>> getGiftsByEventId(String eventId) async {
    if (_shouldUseLocal()) {
      final localGifts = await _giftLocalRepository.getGiftsByEventId(eventId);
      return localGifts.map((e) => e.toDomain()).toList();
    } else {
      final remoteGifts =
          await _giftRemoteRepository.getGiftsByEventId(eventId);
      return remoteGifts.map((remoteGift) => remoteGift.toDomain()).toList();
    }
  }

  Future<void> deleteGift(String giftId) async {
    if (_shouldUseLocal()) {
      await _giftLocalRepository.deleteGift(giftId);
    } else {
      await _giftRemoteRepository.deleteGift(giftId);
    }
  }

  bool _shouldUseLocal() {
// Example logic to determine if local should be used
// Replace with your actual condition
    return true;
  }
}
