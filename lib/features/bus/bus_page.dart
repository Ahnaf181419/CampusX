import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../data/repositories/bus_status_repository.dart';
import '../../services/auth_service.dart';
import 'bus_data.dart';
import 'bus_routes.dart';
import 'widgets/status_card.dart';
import 'widgets/route_timeline.dart';
import 'widgets/stop_list_item.dart';
import 'widgets/admin_control.dart';

class BusPage extends StatefulWidget {
  const BusPage({super.key});

  @override
  State<BusPage> createState() => _BusPageState();
}

class _BusPageState extends State<BusPage> {
  final BusStatusRepository _repository = BusStatusRepository();
  late String _selectedBus;

  // Notification prefs are per-device, keyed by bus title
  final Map<String, List<bool>> _notifyPrefs = {};

  final _player = AudioPlayer();

  BusRouteData get _selectedRouteData =>
      allBusRoutes.firstWhere((r) => r.busTitle == _selectedBus);

  List<bool> get _currentNotifyPrefs =>
      _notifyPrefs.putIfAbsent(
        _selectedBus,
        () => List.filled(_selectedRouteData.routeStops.length, false),
      );

  @override
  void initState() {
    super.initState();
    _selectedBus = allBusRoutes.first.busTitle;
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  List<BusStop> _buildStops(int currentStopIndex) {
    final route = _selectedRouteData;
    return [
      for (int i = 0; i < route.routeStops.length; i++)
        BusStop(
          name: route.routeStops[i].name,
          estimatedMinutes: route.routeStops[i].estimatedMinutes,
          isActive: i <= currentStopIndex,
        ),
    ];
  }

  Future<void> _playNotifySound() async {
    await _player.play(AssetSource('sounds/notify.mp3'));
  }

  void _handleNotifyToggled(int index, bool value) {
    setState(() => _currentNotifyPrefs[index] = value);
  }

  Future<void> _handleNextStoppage(int currentStopIndex) async {
    final route = _selectedRouteData;
    final nextIndex = currentStopIndex + 1;
    if (nextIndex >= route.routeStops.length) return;

    await _repository.updateBusStatus(
      busTitle: _selectedBus,
      isRunning: true,
      currentStopIndex: nextIndex,
    );

    if (_currentNotifyPrefs[nextIndex]) {
      _playNotifySound();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Icon(Icons.directions_bus, color: AppColors.white),
                const SizedBox(width: 8),
                Text('Bus reached ${route.routeStops[nextIndex].name}'),
              ],
            ),
            backgroundColor: AppColors.black,
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    }
  }

  Future<void> _handleToggle(bool currentlyRunning, int currentStopIndex) async {
    await _repository.updateBusStatus(
      busTitle: _selectedBus,
      isRunning: !currentlyRunning,
      currentStopIndex: currentStopIndex,
    );
  }

  Future<void> _handleResetRoute() async {
    await _repository.updateBusStatus(
      busTitle: _selectedBus,
      isRunning: false,
      currentStopIndex: 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isAdmin = AuthService().isAdmin();

    return Scaffold(
      backgroundColor: AppColors.backgroundGrey,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Bus selector dropdown
              Container(
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(
                      color: AppColors.blackShadow,
                      blurRadius: 16,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 4,
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedBus,
                    isExpanded: true,
                    icon: const Icon(Icons.arrow_drop_down),
                    style: AppTextStyles.headerSmall.copyWith(
                      color: AppColors.black,
                    ),
                    dropdownColor: AppColors.white,
                    items: allBusRoutes
                        .map(
                          (route) => DropdownMenuItem(
                            value: route.busTitle,
                            child: Text(route.busTitle),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() => _selectedBus = value);
                      }
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Stream the live status from Firestore
              StreamBuilder<Map<String, dynamic>?>(
                stream: _repository.getBusStatus(_selectedBus),
                builder: (context, snapshot) {
                  final data = snapshot.data;
                  final isRunning = data?['isRunning'] as bool? ?? false;
                  final currentStopIndex = data?['currentStopIndex'] as int? ?? 0;
                  final stops = _buildStops(currentStopIndex);

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (isAdmin)
                        AdminControl(
                          isbusRunning: isRunning,
                          onToggle: () => _handleToggle(isRunning, currentStopIndex),
                          onNextStoppage: () => _handleNextStoppage(currentStopIndex),
                          onResetRoute: _handleResetRoute,
                        ),
                      if (isAdmin) const SizedBox(height: 16),
                      StatusCard(
                        data: _selectedRouteData,
                        isRunning: isRunning,
                      ),
                      const SizedBox(height: 16),
                      RouteTimeline(stoppages: stops),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.only(left: 4, bottom: 8),
                        child: Text(
                          'Bus Stoppage List',
                          style: AppTextStyles.headerSmall,
                        ),
                      ),
                      _UpcomingStopsCard(
                        busKey: _selectedBus,
                        stops: stops,
                        notifyPrefs: _currentNotifyPrefs,
                        onNotifyToggled: _handleNotifyToggled,
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _UpcomingStopsCard extends StatelessWidget {
  final String busKey;
  final List<BusStop> stops;
  final List<bool> notifyPrefs;
  final void Function(int, bool) onNotifyToggled;

  const _UpcomingStopsCard({
    required this.busKey,
    required this.stops,
    required this.notifyPrefs,
    required this.onNotifyToggled,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: AppColors.blackShadow,
            blurRadius: 16,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          for (int i = 0; i < stops.length; i++) ...[
            StopListItem(
              key: ValueKey('${busKey}_$i'),
              stop: stops[i],
              isNotifyActive: notifyPrefs[i],
              onNotifyToggled: (val) => onNotifyToggled(i, val),
            ),
            if (i < stops.length - 1)
              Divider(height: 1, color: AppColors.ashLight),
          ],
        ],
      ),
    );
  }
}
