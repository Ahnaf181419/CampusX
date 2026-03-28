import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/notice.dart';

class NoticeRepository {
  final CollectionReference _noticeCollection = FirebaseFirestore.instance
      .collection('notices');

  Stream<List<Notice>> getNotices() {
    return _noticeCollection
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map(
                (doc) =>
                    Notice.fromMap(doc.id, doc.data() as Map<String, dynamic>),
              )
              .toList(),
        );
  }

  Future<void> addNotice(Notice notice) async {
    await _noticeCollection.add(notice.toMap());
  }

  Future<void> deleteNotice(String id) async {
    await _noticeCollection.doc(id).delete();
  }
}
