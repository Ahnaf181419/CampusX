enum NoticePriority { high, medium, low }

class NoticeModel {
  const NoticeModel({
    required this.id,
    required this.title,
    required this.date,
    required this.priority,
    this.body = '',
    this.isChecked = false,
  });

  final String id;

  final String title;

  final String date;

  final NoticePriority priority;

  final String body;

  final bool isChecked;

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'date': date,
    'priority': priority.index,
    'body': body,
    'isChecked': isChecked,
  };

  factory NoticeModel.fromJson(Map<String, dynamic> json) => NoticeModel(
    id: json['id'] as String,
    title: json['title'] as String,
    date: json['date'] as String,
    priority: NoticePriority.values[json['priority'] as int],
    body: json['body'] as String? ?? '',
    isChecked: json['isChecked'] as bool? ?? false,
  );

  NoticeModel copyWith({
    String? id,
    String? title,
    String? date,
    NoticePriority? priority,
    String? body,
    bool? isChecked,
  }) {
    return NoticeModel(
      id: id ?? this.id,
      title: title ?? this.title,
      date: date ?? this.date,
      priority: priority ?? this.priority,
      body: body ?? this.body,
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
    body: 'The final examination for Fall 2023 has been rescheduled. CSE and EEE departments will now begin on November 15 instead of November 10. Students must collect their updated admit cards from the registrar office by November 12. Contact your department coordinator for any conflicts.',
  ),
  NoticeModel(
    id: '2',
    title: 'Library Extended Hours for Finals',
    date: 'Oct 25, 2023 - 09:00 AM',
    priority: NoticePriority.medium,
    body: 'Starting from November 1, the central library will remain open until 11:00 PM on weekdays and 9:00 PM on weekends to support students during the exam period. The reading room on the 3rd floor will be available 24/7 with valid student ID. Quiet zones will be strictly enforced.',
  ),
  NoticeModel(
    id: '3',
    title: 'Cafeteria Menu Changes & Feedback',
    date: 'Oct 23, 2023 - 11:45 AM',
    priority: NoticePriority.low,
    body: 'The campus cafeteria has introduced a new weekly menu with more vegetarian and healthy options. A feedback form is available at the cafeteria counter and online via the student portal. Students are encouraged to share their preferences to help improve the dining experience.',
  ),
  NoticeModel(
    id: '4',
    title: 'Career Fair Registration Open',
    date: 'Oct 22, 2023 - 09:30 AM',
    priority: NoticePriority.high,
    body: 'The annual AUST Career Fair 2023 will be held on November 20 at the main auditorium. Over 30 companies including Grameenphone, bKash, and Samsung R&D will be participating. Final year students must register through the placement cell portal by November 5. Bring printed copies of your CV.',
  ),
];
