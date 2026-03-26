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

