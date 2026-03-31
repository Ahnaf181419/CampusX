import 'package:flutter/material.dart';
import 'package:campus_x/core/theme/app_colors.dart';
import 'package:campus_x/core/theme/app_text_styles.dart';

class DaySelector extends StatelessWidget {
  const DaySelector({
    super.key,
    required this.selectedDay,
    required this.onDayChanged,
  });

  final int selectedDay; // 0-6: Monday-Sunday
  final ValueChanged<int> onDayChanged;

  static const List<String> _dayNames = [
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(_dayNames.length, (index) {
          final isSelected = selectedDay == index;
          return Padding(
            padding: EdgeInsets.only(
              left: index == 0 ? 0 : 8,
              right: index == _dayNames.length - 1 ? 0 : 0,
            ),
            child: GestureDetector(
              onTap: () => onDayChanged(index),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.black : AppColors.white,
                  border: isSelected
                      ? null
                      : Border.all(color: AppColors.ashLight, width: 1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  _dayNames[index],
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                    color: isSelected ? AppColors.white : AppColors.black,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
