import 'package:flutter/material.dart';
import 'package:campus_x/core/theme/app_colors.dart';
import 'package:campus_x/core/theme/app_text_styles.dart';
import 'package:campus_x/features/rooms/models/room_model.dart';
import 'package:campus_x/features/rooms/widgets/room_status_indicator.dart';

class RoomCard extends StatelessWidget {
  const RoomCard({super.key, required this.room, this.onBookNow});

  final RoomModel room;
  final VoidCallback? onBookNow;

  @override
  Widget build(BuildContext context) {
    return Container(
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
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header row: name + status
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    room.name,
                    style: AppTextStyles.bodyLarge.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                RoomStatusIndicator(status: room.status),
              ],
            ),

            const Divider(height: 20, thickness: 1, color: AppColors.ashLight),

            // Detail rows
            _DetailRow(
              icon: Icons.people_outline,
              text: '${room.capacity} Seats',
            ),
            const SizedBox(height: 8),
            _DetailRow(icon: Icons.school_outlined, text: room.department),
            const SizedBox(height: 8),
            _DetailRow(icon: Icons.build_circle_outlined, text: room.equipment),

            const SizedBox(height: 12),

            // Book Now button — right-aligned
            Align(
              alignment: Alignment.centerRight,
              child: _BookNowButton(roomStatus: room.status, onTap: onBookNow),
            ),
          ],
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: AppColors.ash),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: AppTextStyles.bodySmall.copyWith(color: AppColors.ash),
          ),
        ),
      ],
    );
  }
}

class _BookNowButton extends StatefulWidget {
  const _BookNowButton({this.onTap, required this.roomStatus});

  final VoidCallback? onTap;
  final RoomStatus roomStatus;

  @override
  State<_BookNowButton> createState() => _BookNowButtonState();
}

class _BookNowButtonState extends State<_BookNowButton> {
  late bool _booked;

  @override
  void initState() {
    super.initState();
    // If room is occupied, button starts as booked
    _booked = widget.roomStatus == RoomStatus.occupied;
  }

  @override
  Widget build(BuildContext context) {
    final isRoomOccupied = widget.roomStatus == RoomStatus.occupied;
    final isButtonDisabled = isRoomOccupied;

    return GestureDetector(
      onTap: isButtonDisabled
          ? null
          : () {
              setState(() => _booked = !_booked);
              widget.onTap?.call();
            },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: _booked ? AppColors.black : AppColors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.black, width: 1),
        ),
        child: Text(
          _booked ? 'Booked' : 'Book',
          style: AppTextStyles.bodyMedium.copyWith(
            fontWeight: FontWeight.w600,
            color: _booked ? AppColors.white : AppColors.black,
          ),
        ),
      ),
    );
  }
}
