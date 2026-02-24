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
}

const EventModel kOngoingEvent = EventModel(
  id: 'ongoing_1',
  title: 'Annual Campus Tech Fest 2024',
  date: 'November 15, 2024',
  time: '09:00 AM - 05:00 PM',
  description:
      'Join us for the biggest technology event of the year! Explore '
      'workshops on AI, web development, cybersecurity, and participate in '
      'exciting coding competitions. Network with industry experts and '
      'discover career opportunities.',
  status: EventStatus.ongoing,
);

const List<EventModel> kPastEvents = [
  EventModel(
    id: 'past_1',
    title: "Freshers' Orientation Day",
    date: 'August 28, 2024',
    status: EventStatus.completed,
  ),
  EventModel(
    id: 'past_2',
    title: 'University Blood Drive',
    date: 'September 10, 2024',
    status: EventStatus.completed,
  ),
  EventModel(
    id: 'past_3',
    title: 'Campus Cleanup Drive',
    date: 'September 25, 2024',
    status: EventStatus.completed,
  ),
  EventModel(
    id: 'past_4',
    title: 'Inter-Department Sports Meet',
    date: 'October 05, 2024',
    status: EventStatus.completed,
  ),
  EventModel(
    id: 'past_5',
    title: 'Guest Lecture: Future of AI',
    date: 'October 18, 2024',
    status: EventStatus.completed,
  ),
];
