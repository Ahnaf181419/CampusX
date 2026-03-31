class BusStop {
  final String id;
  final String name;
  final String arrivalTime;
  final int order;

  BusStop({
    required this.id,
    required this.name,
    required this.arrivalTime,
    required this.order,
  });

  factory BusStop.fromMap(String id, Map<String, dynamic> data) {
    return BusStop(
      id: id,
      name: data['name'] ?? '',
      arrivalTime: data['arrivalTime'] ?? '',
      order: data['order'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {'name': name, 'arrivalTime': arrivalTime, 'order': order};
  }
}
