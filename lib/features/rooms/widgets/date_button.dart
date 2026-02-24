import 'package:flutter/material.dart';
import 'package:campus_x/core/theme/app_colors.dart';
import 'package:campus_x/core/theme/app_text_styles.dart';

class DateButton extends StatelessWidget {
  const DateButton({super.key, required this.dayLabel});

  final String dayLabel;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.black,
        borderRadius: BorderRadius.circular(10),
      ),
      alignment: Alignment.center,
      child: Text(
        dayLabel,
        style: AppTextStyles.bodyLarge.copyWith(
          fontWeight: FontWeight.w600,
          color: AppColors.white,
        ),
      ),
    );
  }
}
