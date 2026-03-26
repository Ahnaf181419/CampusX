import 'bus_data.dart';

/// All available bus routes.
/// To add a new bus, just append another BusRouteData entry to this list.
const List<BusRouteData> allBusRoutes = [
  // ── Padma Bus ────────────────────────────────────────────────────
  BusRouteData(
    busTitle: 'Padma Bus',
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
  ),

  // ── Meghna Bus ───────────────────────────────────────────────────
  BusRouteData(
    busTitle: 'Meghna Bus',
    routeDirection: 'To University',
    destination: 'towards Uttara',
    routeStops: [
      BusStop(name: 'Proshika Bhaban', estimatedMinutes: 0, isActive: true),
      BusStop(name: 'Sheyalbari More', estimatedMinutes: 5, isActive: false),
      BusStop(name: 'Rynkhola', estimatedMinutes: 10, isActive: false),
      BusStop(name: 'Sony Cinema hall', estimatedMinutes: 15, isActive: false),
      BusStop(name: 'Mirpur 1', estimatedMinutes: 22, isActive: false),
      BusStop(name: 'Ansarcamp', estimatedMinutes: 26, isActive: false),
      BusStop(name: 'Tolarbag', estimatedMinutes: 28, isActive: false),
      BusStop(name: 'Technical More', estimatedMinutes: 32, isActive: false),
      BusStop(name: 'Kallyanpur', estimatedMinutes: 36, isActive: false),
      BusStop(name: 'Shyamoli', estimatedMinutes: 40, isActive: false),
      BusStop(name: 'Asadgate', estimatedMinutes: 46, isActive: false),
      BusStop(name: 'Manik Mia Avenue', estimatedMinutes: 48, isActive: false),
      BusStop(name: 'Rangs Bhaban', estimatedMinutes: 52, isActive: false),
      BusStop(name: 'University', estimatedMinutes: 56, isActive: false),
    ],
    upcomingStops: [
      BusStop(name: 'Proshika Bhaban', estimatedMinutes: 0, isActive: true),
      BusStop(name: 'Sheyalbari More', estimatedMinutes: 5, isActive: false),
      BusStop(name: 'Rynkhola', estimatedMinutes: 10, isActive: false),
      BusStop(name: 'Sony Cinema hall', estimatedMinutes: 15, isActive: false),
      BusStop(name: 'Mirpur 1', estimatedMinutes: 22, isActive: false),
      BusStop(name: 'Ansarcamp', estimatedMinutes: 26, isActive: false),
      BusStop(name: 'Tolarbag', estimatedMinutes: 28, isActive: false),
      BusStop(name: 'Technical More', estimatedMinutes: 32, isActive: false),
      BusStop(name: 'Kallyanpur', estimatedMinutes: 36, isActive: false),
      BusStop(name: 'Shyamoli', estimatedMinutes: 40, isActive: false),
      BusStop(name: 'Asadgate', estimatedMinutes: 46, isActive: false),
      BusStop(name: 'Manik Mia Avenue', estimatedMinutes: 48, isActive: false),
      BusStop(name: 'Rangs Bhaban', estimatedMinutes: 52, isActive: false),
      BusStop(name: 'University', estimatedMinutes: 56, isActive: false),
    ],
  ),

  // ── Karnaphuli Bus ───────────────────────────────────────────────
  BusRouteData(
    busTitle: 'Karnaphuli Bus',
    routeDirection: 'To University',
    destination: 'towards Dhanmondi',
    routeStops: [
      BusStop(name: 'Chashara', estimatedMinutes: 0, isActive: true),
      BusStop(name: 'Signboad', estimatedMinutes: 4, isActive: false),
      BusStop(name: 'Jatrabari', estimatedMinutes: 9, isActive: false),
      BusStop(name: 'Khilgaon', estimatedMinutes: 14, isActive: false),
      BusStop(name: 'Malibagh', estimatedMinutes: 19, isActive: false),
      BusStop(name: 'Mogbazar', estimatedMinutes: 25, isActive: false),
      BusStop(name: 'University', estimatedMinutes: 44, isActive: false),
    ],
    upcomingStops: [
      BusStop(name: 'Chashara', estimatedMinutes: 0, isActive: true),
      BusStop(name: 'Signboad', estimatedMinutes: 4, isActive: false),
      BusStop(name: 'Jatrabari', estimatedMinutes: 9, isActive: false),
      BusStop(name: 'Khilgaon', estimatedMinutes: 14, isActive: false),
      BusStop(name: 'Malibagh', estimatedMinutes: 19, isActive: false),
      BusStop(name: 'Mogbazar', estimatedMinutes: 25, isActive: false),
      BusStop(name: 'University', estimatedMinutes: 44, isActive: false),
    ],
  ),
];
