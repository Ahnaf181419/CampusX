// status_badge.dart
// A small pill-shaped badge that reads "Completed" for past events.

import 'package:flutter/material.dart';
import 'package:campus_x/core/theme/app_colors.dart';
import 'package:campus_x/core/theme/app_text_styles.dart';

/// Renders the "Completed" status badge used on past event list cards.
///
/// Design: light gray background, rounded pill shape, bold dark text.
class StatusBadge extends StatelessWidget {
  const StatusBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // Pill shape via a high border-radius value.
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.statusBadgeBg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        'Completed',
        style: AppTextStyles.bodySmall.copyWith(
          fontWeight: FontWeight.bold,
          color: AppColors.ash,
        ),
      ),
    );
  }
}
