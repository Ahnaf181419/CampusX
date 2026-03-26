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

class BusPage extends StatefulWidget {
  const BusPage({super.key});

  @override
  State<BusPage> createState() => _BusPageState();
}

class _BusPageState extends State<BusPage> {
  String _selectedBus = allBusRoutes.first.busTitle;

  bool _isbusRunning = false;
  List<BusStop> _routeStops = allBusRoutes.first.routeStops;
  final List<bool> _notifyPrefs = List.filled(allBusRoutes.first.routeStops.length, false);

  final _player = AudioPlayer();

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  Future<void> _playNotifySound() async {
    await _player.play(AssetSource('sounds/notify.mp3'));
  }

  void _handleNotifyToggled(int index, bool value) {
    setState(() => _notifyPrefs[index] = value);
  }

  void _handleNextStoppage() {
    final nextIndex = _routeStops.indexWhere((s) => !s.isActive);
    if (nextIndex == -1) return;

    setState(() {
      _routeStops = [
        for (int i = 0; i < _routeStops.length; i++)
          BusStop(
            name: _routeStops[i].name,
            estimatedMinutes: _routeStops[i].estimatedMinutes,
            isActive: i <= nextIndex,
          ),
      ];
    });

    if (_notifyPrefs[nextIndex]) {
      _playNotifySound();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(Icons.directions_bus, color: AppColors.white),
              const SizedBox(width: 8),
              Text('Bus reached ${_routeStops[nextIndex].name}'),
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
      _isbusRunning = !_isbusRunning;
    });
  }

  void _handleResetRoute() {
    final route = allBusRoutes.firstWhere((r) => r.busTitle == _selectedBus);
    setState(() {
      _routeStops = [
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
              AdminControl(isbusRunning: _isbusRunning, onToggle: _handleToggle, onNextStoppage: _handleNextStoppage, onResetRoute: _handleResetRoute),
              const SizedBox(height: 16),
              StatusCard(data: allBusRoutes.firstWhere((r) => r.busTitle == _selectedBus), isRunning: _isbusRunning),
              const SizedBox(height: 16),
              RouteTimeline(stoppages: _routeStops),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.only(left: 4, bottom: 8),
                child: Text(
                  'Bus Stoppage List',
                  style: AppTextStyles.headerSmall,
                ),
              ),
              _UpcomingStopsCard(
                stops: _routeStops,
                notifyPrefs: _notifyPrefs,
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
  final List<BusStop> stops;
  final List<bool> notifyPrefs;
  final void Function(int, bool) onNotifyToggled;

  const _UpcomingStopsCard({
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
