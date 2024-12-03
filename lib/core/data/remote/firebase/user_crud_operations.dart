//Crud operations to be used in repo
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore;

  FirestoreService({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  /// Create or update a document
  Future<void> upsertDocument({
    required String collectionPath,
    required String docId,
    required Map<String, dynamic> data,
  }) async {
    try {
      await _firestore
          .collection(collectionPath)
          .doc(docId)
          .set(data, SetOptions(merge: true));
    } catch (e) {
      throw Exception('Error creating or updating document: $e');
    }
  }

  /// Read a document by ID
  Future<Map<String, dynamic>?> getDocument({
    required String collectionPath,
    required String docId,
  }) async {
    try {
      final docSnapshot = await _firestore.collection(collectionPath).doc(docId).get();
      if (docSnapshot.exists) {
        return docSnapshot.data();
      }
      return null; // Document not found
    } catch (e) {
      throw Exception('Error fetching document: $e');
    }
  }

  /// Read all documents in a collection
  Future<List<Map<String, dynamic>>> getAllDocuments(String collectionPath) async {
    try {
      final querySnapshot = await _firestore.collection(collectionPath).get();
      return querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    } catch (e) {
      throw Exception('Error fetching documents: $e');
    }
  }

  /// Delete a document by ID
  Future<void> deleteDocument({
    required String collectionPath,
    required String docId,
  }) async {
    try {
      await _firestore.collection(collectionPath).doc(docId).delete();
    } catch (e) {
      throw Exception('Error deleting document: $e');
    }
  }

  /// Fetch all documents from a collection
  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getCollection(
      String collectionPath) async {
    final querySnapshot = await _firestore.collection(collectionPath).get();
    return querySnapshot.docs;
  }
}
