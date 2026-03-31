import 'package:cloud_firestore/cloud_firestore.dart';
import '../../features/events/models/event_model.dart';

class EventRepository {
  final CollectionReference _eventCollection =
      FirebaseFirestore.instance.collection('events');

  Stream<List<EventModel>> getEvents() {
    return _eventCollection
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map(
                (doc) => EventModel.fromMap(
                  doc.id,
                  doc.data() as Map<String, dynamic>,
                ),
              )
              .toList(),
        );
  }

  Future<void> addEvent(EventModel event) async {
    await _eventCollection.add(event.toMap());
  }

  Future<void> deleteEvent(String id) async {
    await _eventCollection.doc(id).delete();
  }
}
