import 'package:cloud_firestore/cloud_firestore.dart';

enum EventStatus { ongoing, upcoming, completed }

class EventModel {
  const EventModel({
    required this.id,
    required this.title,
    required this.date,
    required this.status,
    this.time,
    this.description,
  });

  final String id;
  final String title;
  final String date;
  final String? time;
  final String? description;
  final EventStatus status;

  factory EventModel.fromMap(String id, Map<String, dynamic> data) {
    return EventModel(
      id: id,
      title: data['title'] ?? '',
      date: data['date'] ?? '',
      time: data['time'],
      description: data['description'],
      status: _parseStatus(data['status'] ?? 'upcoming'),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'date': date,
      'time': time,
      'description': description,
      'status': status.name,
      'timestamp': FieldValue.serverTimestamp(),
    };
  }

  static EventStatus _parseStatus(String status) {
    switch (status) {
      case 'ongoing':
        return EventStatus.ongoing;
      case 'completed':
        return EventStatus.completed;
      default:
        return EventStatus.upcoming;
    }
  }
}
