import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import 'bus_data.dart';
import 'widgets/status_card.dart';
import 'widgets/route_timeline.dart';
import 'widgets/stop_list_item.dart';

class BusPage extends StatelessWidget {
  const BusPage({super.key});

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
              StatusCard(data: BusData.currentRoute),
              const SizedBox(height: 16),
              RouteTimeline(stoppages: BusData.currentRoute.routeStops),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.only(left: 4, bottom: 8),
                child: Text(
                  'Bus Stoppage List',
                  style: AppTextStyles.headerSmall,
                ),
              ),
              _UpcomingStopsCard(stops: BusData.currentRoute.upcomingStops),
            ],
          ),
        ),
      ),
    );
  }
}

class _UpcomingStopsCard extends StatelessWidget {
  final List<BusStop> stops;

  const _UpcomingStopsCard({required this.stops});

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
            // Spread Operator -> allows to insert multiple elements from a List into another List seamlessly.
            StopListItem(stop: stops[i], isNotifyActive: i.isEven),
            if (i < stops.length - 1)
              Divider(height: 1, color: AppColors.ashLight),
          ],
        ],
      ),
    );
  }
}
