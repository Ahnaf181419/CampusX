// event_filter_chips.dart
// Horizontal row of filter chips for the Events page:
// "All Events" (selected by default), "Ongoing", and "Upcoming".

import 'package:flutter/material.dart';
import 'package:campus_x/core/theme/app_colors.dart';
import 'package:campus_x/core/theme/app_text_styles.dart';

/// Labels for each available filter on the Events page.
enum EventFilter { allEvents, ongoing, upcoming }

/// Horizontal strip of three animated filter chips.
///
/// Accepts the currently [selectedFilter] and an [onFilterChanged] callback.
class EventFilterChips extends StatelessWidget {
  const EventFilterChips({
    super.key,
    required this.selectedFilter,
    required this.onFilterChanged,
  });

  final EventFilter selectedFilter;
  final ValueChanged<EventFilter> onFilterChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // ── "All Events" chip ───────────────────────────────────
        _FilterChip(
          label: 'All Events',
          isSelected: selectedFilter == EventFilter.allEvents,
          onTap: () => onFilterChanged(EventFilter.allEvents),
        ),

        const SizedBox(width: 8),

        // ── "Ongoing" chip ──────────────────────────────────────
        _FilterChip(
          label: 'Ongoing',
          isSelected: selectedFilter == EventFilter.ongoing,
          onTap: () => onFilterChanged(EventFilter.ongoing),
        ),

        const SizedBox(width: 8),

        // ── "Upcoming" chip ─────────────────────────────────────
        _FilterChip(
          label: 'Upcoming',
          isSelected: selectedFilter == EventFilter.upcoming,
          onTap: () => onFilterChanged(EventFilter.upcoming),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Private helper: a single tappable filter chip with animated selection state.
// ─────────────────────────────────────────────────────────────────────────────

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final Color background = isSelected
        ? AppColors.chipSelectedBg
        : AppColors.white;

    final TextStyle labelStyle = isSelected
        ? AppTextStyles.bodyMedium.copyWith(
            fontWeight: FontWeight.w600,
            color: AppColors.white,
          )
        : AppTextStyles.bodyMedium.copyWith(color: AppColors.black);

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          // Stadium-style pill shape.
          borderRadius: BorderRadius.circular(50),
          color: background,
          border: isSelected
              ? null
              : Border.all(color: AppColors.ashLight, width: 1),
        ),
        child: Text(label, style: labelStyle),
      ),
    );
  }
}
