import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/bus_stop.dart';

class BusRepository {
  final CollectionReference _busCollection = FirebaseFirestore.instance
      .collection('busStops');

  Stream<List<BusStop>> getBusStops() {
    return _busCollection
        .orderBy('order')
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map(
                (doc) =>
                    BusStop.fromMap(doc.id, doc.data() as Map<String, dynamic>),
              )
              .toList(),
        );
  }

  Future<void> addBusStop(BusStop busStop) async {
    await _busCollection.add(busStop.toMap());
  }

  Future<void> updateBusStop(String id, BusStop busStop) async {
    await _busCollection.doc(id).update(busStop.toMap());
  }

  Future<void> deleteBusStop(String id) async {
    await _busCollection.doc(id).delete();
  }
}
