// notice_filter_chips.dart
// Renders a horizontal row of filter chips: "Unread", "Important", and "All".
// The selected chip has a dark-filled stadium style; others are outlined.

import 'package:flutter/material.dart';
import 'package:campus_x/core/theme/app_colors.dart';
import 'package:campus_x/core/theme/app_text_styles.dart';

/// Labels for each available filter option.
enum NoticeFilter { unread, important, all }

/// Horizontal row of filter chips for the Notices page.
///
/// Accepts the currently [selectedFilter] and a [onFilterChanged] callback
/// so the parent can update state when the user taps a chip.
class NoticeFilterChips extends StatelessWidget {
  const NoticeFilterChips({
    super.key,
    required this.selectedFilter,
    required this.onFilterChanged,
  });

  final NoticeFilter selectedFilter;
  final ValueChanged<NoticeFilter> onFilterChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // ── "Unread" chip ───────────────────────────────────────
        _FilterChip(
          label: 'Unread',
          isSelected: selectedFilter == NoticeFilter.unread,
          onTap: () => onFilterChanged(NoticeFilter.unread),
        ),

        const SizedBox(width: 8),

        // ── "Important" chip ────────────────────────────────────
        _FilterChip(
          label: 'Important',
          isSelected: selectedFilter == NoticeFilter.important,
          onTap: () => onFilterChanged(NoticeFilter.important),
        ),

        const SizedBox(width: 8),

        // ── "All" chip ──────────────────────────────────────────
        _FilterChip(
          label: 'All',
          isSelected: selectedFilter == NoticeFilter.all,
          onTap: () => onFilterChanged(NoticeFilter.all),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Private helper: a single, tappable filter chip.
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
    // Determine colors based on selected state.
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
          // Stadium border: very high radius makes it a perfect pill shape.
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
