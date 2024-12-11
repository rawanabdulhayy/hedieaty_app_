// gift_domain_repo.dart
import 'package:uuid/uuid.dart';
import '../../data/remote/models/gift_remote_model.dart';
import '../../data/remote/repositories/gift_remote_repo.dart';
import '../entity/Gift.dart';

class GiftDomainRepository {
  final GiftRemoteRepository _giftRemoteRepository;

  GiftDomainRepository(this._giftRemoteRepository);

  Future<void> upsertGift(Gift gift) async {
    final giftId = gift.id.isEmpty ? const Uuid().v4() : gift.id;
    final remoteGiftModel = GiftRemoteModel.fromDomain(gift).copyWith(id: giftId);
    await _giftRemoteRepository.upsertGift(remoteGiftModel);
  }

  Future<Gift?> getGiftById(String giftId) async {
    final remoteGiftModel = await _giftRemoteRepository.getGiftById(giftId);
    if (remoteGiftModel == null) return null;
    return remoteGiftModel.toDomain();
  }

  Future<List<Gift>> getGiftsByEventId(String eventId) async {
    final remoteGifts = await _giftRemoteRepository.getGiftsByEventId(eventId);
    return remoteGifts.map((remoteGift) => remoteGift.toDomain()).toList();
  }

  Future<void> deleteGift(String giftId) async {
    await _giftRemoteRepository.deleteGift(giftId);
  }
}