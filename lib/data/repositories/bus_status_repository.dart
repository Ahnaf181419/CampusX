import 'package:cloud_firestore/cloud_firestore.dart';

class BusStatusRepository {
  final CollectionReference _busStatusCollection =
      FirebaseFirestore.instance.collection('busStatus');

  Stream<Map<String, dynamic>?> getBusStatus(String busTitle) {
    return _busStatusCollection.doc(busTitle).snapshots().map((doc) {
      if (!doc.exists) return null;
      return doc.data() as Map<String, dynamic>;
    });
  }

  Future<void> updateBusStatus({
    required String busTitle,
    required bool isRunning,
    required int currentStopIndex,
  }) async {
    await _busStatusCollection.doc(busTitle).set({
      'isRunning': isRunning,
      'currentStopIndex': currentStopIndex,
      'lastUpdated': FieldValue.serverTimestamp(),
    });
  }
}
