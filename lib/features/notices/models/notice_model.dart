enum NoticePriority { high, medium, low }

class NoticeModel {
  const NoticeModel({
    required this.id,
    required this.title,
    required this.date,
    required this.priority,
    this.isChecked = false,
  });

  final String id;

  final String title;

  final String date;

  final NoticePriority priority;

  final bool isChecked;

  NoticeModel copyWith({
    String? id,
    String? title,
    String? date,
    NoticePriority? priority,
    bool? isChecked,
  }) {
    return NoticeModel(
      id: id ?? this.id,
      title: title ?? this.title,
      date: date ?? this.date,
      priority: priority ?? this.priority,
      isChecked: isChecked ?? this.isChecked,
    );
  }
}

const List<NoticeModel> kDummyNotices = [
  NoticeModel(
    id: '1',
    title: 'Important Exam Schedule Update',
    date: 'Oct 26, 2023 - 10:30 AM',
    priority: NoticePriority.high,
  ),
  NoticeModel(
    id: '2',
    title: 'Library Extended Hours for Finals',
    date: 'Oct 25, 2023 - 09:00 AM',
    priority: NoticePriority.medium,
  ),
  NoticeModel(
    id: '3',
    title: 'Cafeteria Menu Changes & Feedback',
    date: 'Oct 23, 2023 - 11:45 AM',
    priority: NoticePriority.low,
  ),
  NoticeModel(
    id: '4',
    title: 'Career Fair Registration Open',
    date: 'Oct 22, 2023 - 09:30 AM',
    priority: NoticePriority.high,
  ),
];
