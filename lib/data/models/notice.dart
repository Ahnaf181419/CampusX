class Notice {
  final String id;
  final String title;
  final String body;
  final DateTime timestamp;
  final String author;

  Notice({
    required this.id,
    required this.title,
    required this.body,
    required this.timestamp,
    required this.author,
  });

  factory Notice.fromMap(String id, Map<String, dynamic> data) {
    return Notice(
      id: id,
      title: data['title'] ?? '',
      body: data['body'] ?? '',
      timestamp: data['timestamp']?.toDate() ?? DateTime.now(),
      author: data['author'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'body': body,
      'timestamp': timestamp,
      'author': author,
    };
  }
}
