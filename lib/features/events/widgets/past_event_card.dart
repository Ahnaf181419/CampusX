// past_event_card.dart
// A compact list-item card for a completed/past event.
// Layout: [Title + Date column] on the left, [StatusBadge] on the right.

import 'package:flutter/material.dart';
import 'package:campus_x/core/theme/app_colors.dart';
import 'package:campus_x/core/theme/app_text_styles.dart';
import 'package:campus_x/features/events/models/event_model.dart';
import 'package:campus_x/features/events/widgets/status_badge.dart';

/// Compact card for a past event shown in the scrollable list.
///
/// Displays [event.title] and [event.date] on the left, with a
/// [StatusBadge] pill on the far right.
class PastEventCard extends StatelessWidget {
  const PastEventCard({super.key, required this.event});

  final EventModel event;

  @override
  Widget build(BuildContext context) {
    return Container(
      // ── Card shell ─────────────────────────────────────────────────────
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.buttonInactive, width: 1),
        boxShadow: const [
          BoxShadow(
            color: AppColors.blackShadow,
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        // Inner breathing room for the card content.
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // ── Left side: title + date column ────────────────────────
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Event title – bold, dark.
                  Text(
                    event.title,
                    style: AppTextStyles.bodyMedium.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    softWrap: true,
                  ),

                  const SizedBox(height: 4),

                  // Event date – smaller, gray secondary text.
                  Text(
                    event.date,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.ash,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 12),

            // ── Right side: status badge ───────────────────────────────
            const StatusBadge(),
          ],
        ),
      ),
    );
  }
}
