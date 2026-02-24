enum RoomType { lab, classRoom }

enum RoomStatus { available, bookedSoon, occupied }

class RoomModel {
  const RoomModel({
    required this.id,
    required this.name,
    required this.type,
    required this.status,
    required this.capacity,
    required this.department,
    required this.equipment,
  });

  final String id;

  final String name;

  final RoomType type;

  final RoomStatus status;

  final int capacity;

  final String department;

  final String equipment;

  RoomModel copyWith({
    String? id,
    String? name,
    RoomType? type,
    RoomStatus? status,
    int? capacity,
    String? department,
    String? equipment,
  }) {
    return RoomModel(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      status: status ?? this.status,
      capacity: capacity ?? this.capacity,
      department: department ?? this.department,
      equipment: equipment ?? this.equipment,
    );
  }
}

const List<RoomModel> kDummyRooms = [
  RoomModel(
    id: '1',
    name: 'Computer Lab A1',
    type: RoomType.lab,
    status: RoomStatus.available,
    capacity: 40,
    department: 'Computer Science',
    equipment: 'Projector, PCs, Whiteboard',
  ),
  RoomModel(
    id: '2',
    name: 'Room 201',
    type: RoomType.classRoom,
    status: RoomStatus.bookedSoon,
    capacity: 60,
    department: 'Electrical Engineering',
    equipment: 'Projector, Whiteboard',
  ),
  RoomModel(
    id: '3',
    name: 'Physics Lab B2',
    type: RoomType.lab,
    status: RoomStatus.occupied,
    capacity: 30,
    department: 'Physics',
    equipment: 'Lab Equipment, Projector',
  ),
  RoomModel(
    id: '4',
    name: 'Room 305',
    type: RoomType.classRoom,
    status: RoomStatus.available,
    capacity: 50,
    department: 'Business Studies',
    equipment: 'Projector, Sound System',
  ),
  RoomModel(
    id: '5',
    name: 'Network Lab C1',
    type: RoomType.lab,
    status: RoomStatus.bookedSoon,
    capacity: 25,
    department: 'Computer Science',
    equipment: 'Servers, PCs, Switches',
  ),
];
