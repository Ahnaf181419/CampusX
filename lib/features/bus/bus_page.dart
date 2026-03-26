import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import 'bus_data.dart';
import 'bus_routes.dart';
import 'widgets/status_card.dart';
import 'widgets/route_timeline.dart';
import 'widgets/stop_list_item.dart';
import 'widgets/admin_control.dart';

class _BusState {
  bool isRunning;
  List<BusStop> routeStops;
  List<bool> notifyPrefs;

  _BusState({
    required this.isRunning,
    required this.routeStops,
    required this.notifyPrefs,
  });
}

class BusPage extends StatefulWidget {
  const BusPage({super.key});

  @override
  State<BusPage> createState() => _BusPageState();
}

class _BusPageState extends State<BusPage> {
  late final Map<String, _BusState> _busStates;
  late String _selectedBus;

  _BusState get _current => _busStates[_selectedBus]!;

  BusRouteData get _selectedRouteData =>
      allBusRoutes.firstWhere((r) => r.busTitle == _selectedBus);

  final _player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _busStates = {
      for (final route in allBusRoutes)
        route.busTitle: _BusState(
          isRunning: false,
          routeStops: List.of(route.routeStops),
          notifyPrefs: List.filled(route.routeStops.length, false),
        ),
    };
    _selectedBus = allBusRoutes.first.busTitle;
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  Future<void> _playNotifySound() async {
    await _player.play(AssetSource('sounds/notify.mp3'));
  }

  void _handleNotifyToggled(int index, bool value) {
    setState(() => _current.notifyPrefs[index] = value);
  }

  void _handleNextStoppage() {
    final stops = _current.routeStops;
    final nextIndex = stops.indexWhere((s) => !s.isActive);
    if (nextIndex == -1) return;

    setState(() {
      _current.routeStops = [
        for (int i = 0; i < stops.length; i++)
          BusStop(
            name: stops[i].name,
            estimatedMinutes: stops[i].estimatedMinutes,
            isActive: i <= nextIndex,
          ),
      ];
    });

    if (_current.notifyPrefs[nextIndex]) {
      _playNotifySound();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(Icons.directions_bus, color: AppColors.white),
              const SizedBox(width: 8),
              Text('Bus reached ${_current.routeStops[nextIndex].name}'),
            ],
          ),
          backgroundColor: AppColors.black,
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  void _handleToggle() {
    setState(() {
      _current.isRunning = !_current.isRunning;
    });
  }

  void _handleResetRoute() {
    final route = _selectedRouteData;
    setState(() {
      _current.routeStops = [
        BusStop(
          name: route.routeStops[0].name,
          estimatedMinutes: route.routeStops[0].estimatedMinutes,
          isActive: true,
        ),
        for (int i = 1; i < route.routeStops.length; i++)
          BusStop(
            name: route.routeStops[i].name,
            estimatedMinutes: route.routeStops[i].estimatedMinutes,
            isActive: false,
          ),
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundGrey,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
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
                        .map((route) => DropdownMenuItem(
                              value: route.busTitle,
                              child: Text(route.busTitle),
                            ))
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
              AdminControl(isbusRunning: _current.isRunning, onToggle: _handleToggle, onNextStoppage: _handleNextStoppage, onResetRoute: _handleResetRoute),
              const SizedBox(height: 16),
              StatusCard(data: _selectedRouteData, isRunning: _current.isRunning),
              const SizedBox(height: 16),
              RouteTimeline(stoppages: _current.routeStops),
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
                stops: _current.routeStops,
                notifyPrefs: _current.notifyPrefs,
                onNotifyToggled: _handleNotifyToggled,
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
