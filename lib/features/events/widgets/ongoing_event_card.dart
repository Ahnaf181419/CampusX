// ongoing_event_card.dart
// The large hero card that displays the single active/ongoing event.
// Contains: title, date & time, description paragraph, and action button.

import 'package:flutter/material.dart';
import 'package:campus_x/core/theme/app_colors.dart';
import 'package:campus_x/core/theme/app_text_styles.dart';
import 'package:campus_x/features/events/models/event_model.dart';

/// Large card widget for an ongoing event.
///
/// Displays all available details: [event.title], a combined date & time line,
/// [event.description], and a "Participate Now" action button.
class OngoingEventCard extends StatelessWidget {
  const OngoingEventCard({super.key, required this.event, this.onParticipate});

  /// The event data to render.
  final EventModel event;

  /// Optional callback triggered when the user taps "Participate Now".
  final VoidCallback? onParticipate;

  @override
  Widget build(BuildContext context) {
    return Container(
      // ── Card shell ─────────────────────────────────────────────────────
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.buttonInactive, width: 1),
        boxShadow: const [
          BoxShadow(
            color: AppColors.blackShadow,
            blurRadius: 8,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Event title ──────────────────────────────────────────────
            Text(
              event.title,
              style: AppTextStyles.bodyLarge.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            // ── Date • Time line ─────────────────────────────────────────
            // Combines date and time with a bullet separator when available.
            Text(
              event.time != null ? '${event.date} • ${event.time}' : event.date,
              style: AppTextStyles.bodySmall.copyWith(color: AppColors.ash),
            ),

            const SizedBox(height: 12),

            // ── Description paragraph ────────────────────────────────────
            if (event.description != null)
              Text(
                event.description!,
                style: AppTextStyles.bodySmall.copyWith(color: AppColors.ash),
              ),

            const SizedBox(height: 16),

            // ── "Participate Now" full-width action button ────────────────
            _ParticipateButton(onTap: onParticipate),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Private helper: the dark full-width "Participate Now" button.
// ─────────────────────────────────────────────────────────────────────────────

class _ParticipateButton extends StatelessWidget {
  const _ParticipateButton({this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Material(
        // Dark almost-black background for contrast.
        color: AppColors.black,
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 14),
            child: Text(
              'Participate Now',
              textAlign: TextAlign.center,
              style: AppTextStyles.button,
            ),
          ),
        ),
      ),
    );
  }
}
