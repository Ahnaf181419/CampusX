// notice_card.dart
// The card widget that represents a single campus notice in the list.

import 'package:flutter/material.dart';
import 'package:campus_x/core/theme/app_colors.dart';
import 'package:campus_x/core/theme/app_text_styles.dart';
import 'package:campus_x/features/notices/models/notice_model.dart';
import 'package:campus_x/features/notices/widgets/priority_badge.dart';

/// Renders a full notice card for a given [notice].
///
/// Layout (left-to-right):
///   [Checkbox] | [Title + Date column] | [PriorityBadge + mail icon + expand icon]
///
/// The [onCheckedChanged] callback is invoked whenever the user toggles
/// the checkbox so the parent can update state.
class NoticeCard extends StatelessWidget {
  const NoticeCard({
    super.key,
    required this.notice,
    required this.onCheckedChanged,
  });

  final NoticeModel notice;
  final ValueChanged<bool?> onCheckedChanged;

  void _showDetail(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        backgroundColor: AppColors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      notice.title,
                      style: AppTextStyles.headerSmall,
                    ),
                  ),
                  PriorityBadge(priority: notice.priority),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                notice.date,
                style: AppTextStyles.bodySmall.copyWith(color: AppColors.ash),
              ),
              const Divider(height: 24, color: AppColors.ashLight),
              Text(
                notice.body.isNotEmpty
                    ? notice.body
                    : 'No additional details available for this notice.',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.ash,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  style: TextButton.styleFrom(
                    backgroundColor: AppColors.black,
                    foregroundColor: AppColors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('Close'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showDetail(context),
      child: Container(
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
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _NoticeCheckbox(
                isChecked: notice.isChecked,
                onChanged: onCheckedChanged,
              ),

              const SizedBox(width: 8),

              Expanded(
                child: _NoticeTitleColumn(title: notice.title, date: notice.date),
              ),

              const SizedBox(width: 8),

              _NoticeActions(priority: notice.priority),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Private sub-widget: the Material Checkbox on the left side of the card.
// ─────────────────────────────────────────────────────────────────────────────

class _NoticeCheckbox extends StatelessWidget {
  const _NoticeCheckbox({required this.isChecked, required this.onChanged});

  final bool isChecked;
  final ValueChanged<bool?> onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // Constrain so the checkbox doesn't take up excess space.
      width: 24,
      height: 24,
      child: Checkbox(
        value: isChecked,
        onChanged: onChanged,
        // Remove extra padding Material adds by default.
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        visualDensity: VisualDensity.compact,
        // Adopt the theme's accent color for the checked state.
        activeColor: AppColors.black,
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Private sub-widget: the title + date column in the middle of the card.
// ─────────────────────────────────────────────────────────────────────────────

class _NoticeTitleColumn extends StatelessWidget {
  const _NoticeTitleColumn({required this.title, required this.date});

  final String title;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Notice title – bold, allows wrapping onto multiple lines.
        Text(
          title,
          style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w600),
          softWrap: true,
        ),

        const SizedBox(height: 4),

        // Date and time – smaller, light-gray secondary text.
        Text(
          date,
          style: AppTextStyles.bodySmall.copyWith(color: AppColors.ash),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Private sub-widget: the badge + icon row on the far right of the card.
// ─────────────────────────────────────────────────────────────────────────────

class _NoticeActions extends StatelessWidget {
  const _NoticeActions({required this.priority});

  final NoticePriority priority;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Priority badge (High/Medium/Low styled accordingly).
        PriorityBadge(priority: priority),

        const SizedBox(width: 6),

        // Mail icon – indicates the notice can be opened as a message.
        const Icon(Icons.mail_outline, size: 18, color: AppColors.ash),

        const SizedBox(width: 4),

        // Expand icon – indicates the card can be expanded for more detail.
        const Icon(Icons.keyboard_arrow_down, size: 20, color: AppColors.ash),
      ],
    );
  }
}
