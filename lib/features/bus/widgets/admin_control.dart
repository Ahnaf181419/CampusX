import 'package:campus_x/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class AdminControl extends StatelessWidget {
  final bool isbusRunning;
  final VoidCallback onToggle;
  final VoidCallback onNextStoppage;
  final VoidCallback onResetRoute;

  const AdminControl({
    super.key,
    required this.isbusRunning,
    required this.onToggle,
    required this.onNextStoppage,
    required this.onResetRoute,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: AppColors.blackShadow,
            blurRadius: 16,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons
                      .admin_panel_settings, 
                  size: 24,
                  color: isbusRunning ? Colors.green : AppColors.redAccent,
                ),
                const SizedBox(width: 12),
                Text(
                  'Admin Control',
                  style: AppTextStyles.headerMedium.copyWith(
                    color: AppColors.black, 
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const Divider(
              height: 32,
              thickness: 1,
              color: Colors.black12,
            ),
            
            Row(
              children: [
        
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: onToggle,
                    icon: Icon(
                      isbusRunning ? Icons.stop_circle : Icons.play_circle,
                      color: AppColors.white,
                    ),
                    label: Text(
                      isbusRunning ? 'Stop Bus' : 'Start Bus',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isbusRunning
                          ? AppColors.redAccent
                          : Colors.green,
                      foregroundColor:
                          AppColors.white, 
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          12,
                        ), 
                      ),
                      elevation: 0,
                    ),
                  ),
                ),

                const SizedBox(width: 12),

          
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: isbusRunning ? onNextStoppage : null,
                    icon: const Icon(Icons.skip_next),
                    label: const Text('Next Stop'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.black,
                      foregroundColor: AppColors.white,
                      
                      disabledBackgroundColor: Colors.grey.shade300,
                      disabledForegroundColor: Colors.grey.shade600,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

           
            SizedBox(
              width: double.infinity, 
              child: OutlinedButton.icon(
                onPressed: onResetRoute,
                icon: const Icon(Icons.refresh),
                label: const Text('Reset Route'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.redAccent, 
                  side: BorderSide(
                    color: AppColors.redAccent,
                  ), // Soft red border
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
