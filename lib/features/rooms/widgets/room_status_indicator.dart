import 'package:flutter/material.dart';
import 'package:campus_x/core/theme/app_colors.dart';
import 'package:campus_x/core/theme/app_text_styles.dart';
import 'package:campus_x/features/rooms/models/room_model.dart';

class RoomStatusIndicator extends StatelessWidget {
  const RoomStatusIndicator({super.key, required this.status});

  final RoomStatus status;

  @override
  Widget build(BuildContext context) {
    if (status == RoomStatus.available) {
      return Text(
        'Available',
        style: AppTextStyles.bodySmall.copyWith(
          fontWeight: FontWeight.w600,
          color: AppColors.black,
        ),
      );
    } else {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        decoration: BoxDecoration(
          color: AppColors.black,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          'Not Available',
          style: AppTextStyles.bodySmall.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.white,
          ),
        ),
      );
    }
  }
}
