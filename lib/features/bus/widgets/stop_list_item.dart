import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../bus_data.dart';

class StopListItem extends StatefulWidget {
  final BusStop stop;
  final bool isNotifyActive;
  final void Function(bool) onNotifyToggled;

  const StopListItem({
    super.key,
    required this.stop,
    required this.isNotifyActive,
    required this.onNotifyToggled,
  });

  @override
  State<StopListItem> createState() => _StopListItemState();
}

class _StopListItemState extends State<StopListItem> {
  late bool _isActive;

  @override
  void initState() {
    super.initState();
    _isActive = widget.isNotifyActive;
  }

  void _toggle() {
    setState(() => _isActive = !_isActive);
    widget.onNotifyToggled(_isActive);
  }

  @override
  Widget build(BuildContext context) {
    final bool isPassed = widget.stop.isActive;
    return Container(
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(
            color: isPassed ? AppColors.black : Colors.transparent,
            width: 4,
          ),
        ),
      ),
      child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.stop.name,
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.bold,
                    color: isPassed ? AppColors.ash : AppColors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Estimated: ${widget.stop.estimatedMinutes} mins',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.ash,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Icon(
                _isActive ? Icons.notifications_active : Icons.notifications_none,
                color: _isActive ? AppColors.black : AppColors.ash,
                size: 20,
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: _toggle,
                child: _NotifyButton(isActive: _isActive),
              ),
            ],
          ),
        ],
      ),
      ),
    );
  }
}

class _NotifyButton extends StatelessWidget {
  final bool isActive;

  const _NotifyButton({required this.isActive});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isActive ? AppColors.black : AppColors.buttonInactive,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        isActive ? 'Notifying' : 'Notify Me',
        style: AppTextStyles.bodySmall.copyWith(
          fontWeight: FontWeight.w600,
          color: isActive ? AppColors.white : AppColors.black,
        ),
      ),
    );
  }
}
