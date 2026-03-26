import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../bus_data.dart';

class StatusCard extends StatelessWidget {
  final BusRouteData data;
  final bool isRunning;

  const StatusCard({super.key, required this.data, required this.isRunning});

  @override
  Widget build(BuildContext context) {
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
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(Icons.directions_bus, size: 28),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(data.busTitle, style: AppTextStyles.headerSmall),
                  const SizedBox(height: 4),
                  Text(
                    '${data.routeDirection}, ${data.destination}',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.ash,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      size: 14,
                      color: isRunning ? AppColors.black : AppColors.ash,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      isRunning ? 'Running' : 'Stopped',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: isRunning ? AppColors.black : AppColors.ash,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
