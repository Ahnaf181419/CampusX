import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../services/auth_service.dart';
import '../../../shared/home_shell.dart';
import '../widgets/user_type_card.dart';
import 'admin_login_screen.dart';

class LoginChoiceScreen extends StatelessWidget {
  const LoginChoiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            children: [
              const Spacer(flex: 2),
              _buildLogo(),
              const Spacer(flex: 1),
              _buildWelcomeText(),
              const Spacer(flex: 1),
              _buildStudentCard(context),
              const SizedBox(height: 16),
              _buildAdminCard(context),
              const Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: 'Campus',
            style: AppTextStyles.headerLarge.copyWith(
              color: AppColors.black,
            ),
          ),
          TextSpan(
            text: 'X',
            style: AppTextStyles.headerLarge.copyWith(
              color: AppColors.ash,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWelcomeText() {
    return Text(
      'Select your role to continue',
      style: AppTextStyles.bodyLarge.copyWith(color: AppColors.ash),
    );
  }

  Widget _buildStudentCard(BuildContext context) {
    return UserTypeCard(
      icon: Icons.school_outlined,
      title: 'Student',
      subtitle: "I'm a student",
      onTap: () => _handleStudentLogin(context),
    );
  }

  Widget _buildAdminCard(BuildContext context) {
    return UserTypeCard(
      icon: Icons.admin_panel_settings_outlined,
      title: 'Admin',
      subtitle: 'Admin login',
      onTap: () => _handleAdminTap(context),
    );
  }

  void _handleStudentLogin(BuildContext context) async {
    final authService = AuthService();
    await authService.setFirstLaunchComplete();
    await authService.setUserType('student');
    
    if (context.mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeShell()),
      );
    }
  }

  void _handleAdminTap(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const AdminLoginScreen()),
    );
  }
}
