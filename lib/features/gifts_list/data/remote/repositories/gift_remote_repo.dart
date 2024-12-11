// gift_remote_repo.dart
import '../../../../../core/data/remote/firebase/crud_operations.dart';
import '../models/gift_remote_model.dart';

class GiftRemoteRepository {
  final FirestoreService _firestoreService;
  final String _giftCollectionPath = 'gifts';

  GiftRemoteRepository({FirestoreService? firestoreService})
      : _firestoreService = firestoreService ?? FirestoreService();

  Future<void> upsertGift(GiftRemoteModel gift) async {
    await _firestoreService.upsertDocument(
      collectionPath: _giftCollectionPath,
      docId: gift.id,
      data: gift.toMap(),
    );
  }

  Future<GiftRemoteModel?> getGiftById(String giftId) async {
    final data = await _firestoreService.getDocument(
      collectionPath: _giftCollectionPath,
      docId: giftId,
    );
    if (data == null) return null;
    return GiftRemoteModel.fromMap(data);
  }

  Future<List<GiftRemoteModel>> getGiftsByEventId(String eventId) async {
    final documents = await _firestoreService.queryCollection(
      collectionPath: _giftCollectionPath,
      field: 'eventId',
      value: eventId,
    );
    return documents.map((doc) => GiftRemoteModel.fromMap(doc.data())).toList();
  }

  Future<void> deleteGift(String giftId) async {
    await _firestoreService.deleteDocument(
      collectionPath: _giftCollectionPath,
      docId: giftId,
    );
  }
}
