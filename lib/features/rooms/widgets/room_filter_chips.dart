import 'package:flutter/material.dart';
import 'package:campus_x/core/theme/app_colors.dart';
import 'package:campus_x/core/theme/app_text_styles.dart';

enum RoomFilter { all, lab, classRoom }

class RoomFilterChips extends StatelessWidget {
  const RoomFilterChips({
    super.key,
    required this.selectedFilter,
    required this.onFilterChanged,
  });

  final RoomFilter selectedFilter;
  final ValueChanged<RoomFilter> onFilterChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _FilterChip(
          label: 'All',
          isSelected: selectedFilter == RoomFilter.all,
          onTap: () => onFilterChanged(RoomFilter.all),
        ),

        const SizedBox(width: 8),

        _FilterChip(
          label: 'Lab',
          isSelected: selectedFilter == RoomFilter.lab,
          onTap: () => onFilterChanged(RoomFilter.lab),
        ),

        const SizedBox(width: 8),

        _FilterChip(
          label: 'Classroom',
          isSelected: selectedFilter == RoomFilter.classRoom,
          onTap: () => onFilterChanged(RoomFilter.classRoom),
        ),
      ],
    );
  }
}

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
