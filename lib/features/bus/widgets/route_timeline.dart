import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../bus_data.dart';

class RouteTimeline extends StatelessWidget {
  final List<BusStop> stoppages;

  const RouteTimeline({super.key, required this.stoppages});

  @override
  Widget build(BuildContext context) {
    final List<Widget> rowChildren = [];
    for (int i = 0; i < stoppages.length; i++) {
      final stop = stoppages[i];
      rowChildren.add(
        stop.isActive
            ? _ActiveStopNode(name: stop.name)
            : _UpcomingStopNode(name: stop.name),
      );
      if (i < stoppages.length - 1) {
        rowChildren.add(const _ConnectorLine());
      }
    }

    return Container(
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
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Current Route', style: AppTextStyles.headerSmall),
            const SizedBox(height: 16),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: rowChildren,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActiveStopNode extends StatelessWidget {
  final String name;

  const _ActiveStopNode({required this.name});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: const BoxDecoration(
            color: AppColors.black,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.directions_bus,
            color: AppColors.white,
            size: 20,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          name,
          style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

class _UpcomingStopNode extends StatelessWidget {
  final String name;

  const _UpcomingStopNode({required this.name});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: AppColors.ash,
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.hourglass_top, color: AppColors.ashLight, size: 15),
        ),
        const SizedBox(height: 8),
        Text(
          name,
          style: AppTextStyles.bodySmall.copyWith(color: AppColors.ash),
        ),
      ],
    );
  }
}

class _ConnectorLine extends StatelessWidget {
  const _ConnectorLine();

  @override
  Widget build(BuildContext context) {
    return Container(width: 40, height: 1.5, color: AppColors.ash);
  }
}
