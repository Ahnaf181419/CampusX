import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

class UserTypeCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const UserTypeCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  State<UserTypeCard> createState() => _UserTypeCardState();
}

class _UserTypeCardState extends State<UserTypeCard> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: widget.onTap,
      child: AnimatedScale(
        scale: _isPressed ? 0.98 : 1.0,
        duration: const Duration(milliseconds: 100),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: AppColors.blackShadow,
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.backgroundGrey,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  widget.icon,
                  size: 28,
                  color: AppColors.black,
                ),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: AppTextStyles.headerSmall,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.subtitle,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.ash,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Icon(
                Icons.arrow_forward_ios,
                size: 18,
                color: AppColors.ash,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
