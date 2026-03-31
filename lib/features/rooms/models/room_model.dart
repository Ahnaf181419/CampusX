enum RoomType { classRoom, lab }

enum RoomStatus { available, occupied }

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
  // 7A Wing - Classrooms
  RoomModel(
    id: '1',
    name: '7A01',
    type: RoomType.classRoom,
    status: RoomStatus.available,
    capacity: 50,
    department: 'Computer Science and Engineering',
    equipment: 'Projector and PCs',
  ),
  RoomModel(
    id: '2',
    name: '7A02',
    type: RoomType.classRoom,
    status: RoomStatus.available,
    capacity: 50,
    department: 'Computer Science and Engineering',
    equipment: 'Projector and PCs',
  ),
  RoomModel(
    id: '3',
    name: '7A03',
    type: RoomType.classRoom,
    status: RoomStatus.occupied,
    capacity: 50,
    department: 'Computer Science and Engineering',
    equipment: 'Projector and PCs',
  ),
  RoomModel(
    id: '4',
    name: '7A04',
    type: RoomType.classRoom,
    status: RoomStatus.available,
    capacity: 50,
    department: 'Computer Science and Engineering',
    equipment: 'Projector and PCs',
  ),
  RoomModel(
    id: '5',
    name: '7A05',
    type: RoomType.classRoom,
    status: RoomStatus.occupied,
    capacity: 50,
    department: 'Computer Science and Engineering',
    equipment: 'Projector and PCs',
  ),
  RoomModel(
    id: '6',
    name: '7A06',
    type: RoomType.classRoom,
    status: RoomStatus.available,
    capacity: 50,
    department: 'Computer Science and Engineering',
    equipment: 'Projector and PCs',
  ),
  // 7B Wing - Labs
  RoomModel(
    id: '7',
    name: '7B01',
    type: RoomType.lab,
    status: RoomStatus.available,
    capacity: 25,
    department: 'Computer Science and Engineering',
    equipment: 'Projector and PCs',
  ),
  RoomModel(
    id: '8',
    name: '7B02',
    type: RoomType.lab,
    status: RoomStatus.occupied,
    capacity: 25,
    department: 'Computer Science and Engineering',
    equipment: 'Projector and PCs',
  ),
  RoomModel(
    id: '9',
    name: '7B03',
    type: RoomType.lab,
    status: RoomStatus.occupied,
    capacity: 25,
    department: 'Computer Science and Engineering',
    equipment: 'Projector and PCs',
  ),
  RoomModel(
    id: '10',
    name: '7B04',
    type: RoomType.lab,
    status: RoomStatus.available,
    capacity: 25,
    department: 'Computer Science and Engineering',
    equipment: 'Projector and PCs',
  ),
  RoomModel(
    id: '11',
    name: '7B05',
    type: RoomType.lab,
    status: RoomStatus.available,
    capacity: 25,
    department: 'Computer Science and Engineering',
    equipment: 'Projector and PCs',
  ),
  RoomModel(
    id: '12',
    name: '7B06',
    type: RoomType.lab,
    status: RoomStatus.occupied,
    capacity: 25,
    department: 'Computer Science and Engineering',
    equipment: 'Projector and PCs',
  ),
  RoomModel(
    id: '13',
    name: '7B07',
    type: RoomType.lab,
    status: RoomStatus.occupied,
    capacity: 25,
    department: 'Computer Science and Engineering',
    equipment: 'Projector and PCs',
  ),
  RoomModel(
    id: '14',
    name: '7B08',
    type: RoomType.lab,
    status: RoomStatus.available,
    capacity: 25,
    department: 'Computer Science and Engineering',
    equipment: 'Projector and PCs',
  ),
  // 7C Wing - Classrooms
  RoomModel(
    id: '15',
    name: '7C01',
    type: RoomType.classRoom,
    status: RoomStatus.available,
    capacity: 50,
    department: 'Computer Science and Engineering',
    equipment: 'Projector and PCs',
  ),
  RoomModel(
    id: '16',
    name: '7C02',
    type: RoomType.classRoom,
    status: RoomStatus.occupied,
    capacity: 50,
    department: 'Computer Science and Engineering',
    equipment: 'Projector and PCs',
  ),
  RoomModel(
    id: '17',
    name: '7C03',
    type: RoomType.classRoom,
    status: RoomStatus.occupied,
    capacity: 50,
    department: 'Computer Science and Engineering',
    equipment: 'Projector and PCs',
  ),
  RoomModel(
    id: '18',
    name: '7C04',
    type: RoomType.classRoom,
    status: RoomStatus.available,
    capacity: 50,
    department: 'Computer Science and Engineering',
    equipment: 'Projector and PCs',
  ),
  RoomModel(
    id: '19',
    name: '7C05',
    type: RoomType.classRoom,
    status: RoomStatus.available,
    capacity: 50,
    department: 'Computer Science and Engineering',
    equipment: 'Projector and PCs',
  ),
  RoomModel(
    id: '20',
    name: '7C06',
    type: RoomType.classRoom,
    status: RoomStatus.occupied,
    capacity: 50,
    department: 'Computer Science and Engineering',
    equipment: 'Projector and PCs',
  ),
];
