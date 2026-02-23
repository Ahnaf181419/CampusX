class BusStop {
  final String name;
  final int estimatedMinutes;
  final bool isActive;

  const BusStop({
    required this.name,
    required this.estimatedMinutes,
    required this.isActive,
  });
}

class BusRouteData {
  final String busTitle;
  final String routeDirection;
  final String destination;
  final List<BusStop> routeStops;
  final List<BusStop> upcomingStops;

  const BusRouteData({
    required this.busTitle,
    required this.routeDirection,
    required this.destination,
    required this.routeStops,
    required this.upcomingStops,
  });
}

class BusData {
  BusData._();

  static const BusRouteData currentRoute = BusRouteData(
    busTitle: 'Padma Bus Started',
    routeDirection: 'To University',
    destination: 'towards Bangla School',

    routeStops: [
      BusStop(name: 'Mirpur 12', estimatedMinutes: 0, isActive: true),
      BusStop(name: 'Mirpur 11.5', estimatedMinutes: 3, isActive: false),
      BusStop(name: 'Purobi', estimatedMinutes: 7, isActive: false),
      BusStop(name: 'Bangla School', estimatedMinutes: 13, isActive: false),
      BusStop(name: 'Mirpur 11', estimatedMinutes: 18, isActive: false),
      BusStop(name: 'Mirpur 10', estimatedMinutes: 23, isActive: false),
      BusStop(name: 'Kazipara', estimatedMinutes: 27, isActive: false),
      BusStop(name: 'Shewrapara', estimatedMinutes: 30, isActive: false),
      BusStop(name: 'Taltola', estimatedMinutes: 35, isActive: false),
      BusStop(name: 'Agargaon', estimatedMinutes: 38, isActive: false),
      BusStop(name: 'University', estimatedMinutes: 46, isActive: false),
    ],
    upcomingStops: [
      BusStop(name: 'Mirpur 12', estimatedMinutes: 0, isActive: true),
      BusStop(name: 'Mirpur 11.5', estimatedMinutes: 3, isActive: false),
      BusStop(name: 'Purobi', estimatedMinutes: 7, isActive: false),
      BusStop(name: 'Bangla School', estimatedMinutes: 13, isActive: false),
      BusStop(name: 'Mirpur 11', estimatedMinutes: 18, isActive: false),
      BusStop(name: 'Mirpur 10', estimatedMinutes: 23, isActive: false),
      BusStop(name: 'Kazipara', estimatedMinutes: 27, isActive: false),
      BusStop(name: 'Shewrapara', estimatedMinutes: 30, isActive: false),
      BusStop(name: 'Taltola', estimatedMinutes: 35, isActive: false),
      BusStop(name: 'Agargaon', estimatedMinutes: 38, isActive: false),
      BusStop(name: 'University', estimatedMinutes: 46, isActive: false),
    ],
  );
}
