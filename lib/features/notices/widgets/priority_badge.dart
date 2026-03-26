// priority_badge.dart
// A small reusable widget that renders a priority label in the
// correct visual style (High = red pill, Medium = plain text, Low = outlined pill).

import 'package:flutter/material.dart';
import 'package:campus_x/core/theme/app_colors.dart';
import 'package:campus_x/core/theme/app_text_styles.dart';
import 'package:campus_x/features/notices/models/notice_model.dart';

/// Displays a priority badge that adapts its style to the supplied [priority].
///
/// - [NoticePriority.high]   → red pill with bold white "High" text.
/// - [NoticePriority.medium] → priorityMid pill with bold white "Medium" text.
/// - [NoticePriority.low]    → outlined white pill with gray "Low" text.
class PriorityBadge extends StatelessWidget {
  const PriorityBadge({super.key, required this.priority});

  final NoticePriority priority;

  @override
  Widget build(BuildContext context) {
    switch (priority) {
      // ── High priority badge ─────────────────────────────────
      case NoticePriority.high:
        return _PillBadge(
          label: 'High',
          backgroundColor: AppColors.priorityHigh,
          borderColor: Colors.transparent,
          textStyle: AppTextStyles.bodySmall.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.white,
          ),
        );

      // ── Medium priority – priorityMid pill badge ──────────────────
      case NoticePriority.medium:
        return _PillBadge(
          label: 'Medium',
          backgroundColor: AppColors.priorityMid,
          borderColor: Colors.transparent,
          textStyle: AppTextStyles.bodySmall.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.white,
          ),
        );

      // ── Low priority badge ──────────────────────────────────
      case NoticePriority.low:
        return _PillBadge(
          label: 'Low',
          backgroundColor: AppColors.priorityLowBg,
          borderColor: AppColors.ashLight,
          textStyle: AppTextStyles.bodySmall.copyWith(
            fontWeight: FontWeight.w500,
            color: AppColors.ash,
          ),
        );
    }
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Private helper: pill-shaped container with a centered text label.
// ─────────────────────────────────────────────────────────────────────────────

class _PillBadge extends StatelessWidget {
  const _PillBadge({
    required this.label,
    required this.backgroundColor,
    required this.borderColor,
    required this.textStyle,
  });

  final String label;
  final Color backgroundColor;
  final Color borderColor;
  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      // Pill shape is achieved via a large border radius (stadium-like).
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: borderColor, width: 1),
      ),
      child: Text(label, style: textStyle),
    );
  }
}
