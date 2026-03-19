import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../services/auth_service.dart';
import '../../../shared/home_shell.dart';

class AdminLoginScreen extends StatefulWidget {
  const AdminLoginScreen({super.key});

  @override
  State<AdminLoginScreen> createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_onFieldChanged);
    _passwordController.addListener(_onFieldChanged);
  }

  void _onFieldChanged() => setState(() {});

  bool get _isFormFilled =>
      _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              _buildBackButton(),
              const Spacer(flex: 1),
              _buildLogo(),
              const SizedBox(height: 4),
              Text(
                'Admin login',
                style: AppTextStyles.bodyLarge.copyWith(color: AppColors.ash),
              ),
              const Spacer(flex: 2),
              _buildEmailField(),
              const SizedBox(height: 24),
              _buildPasswordField(),
              const SizedBox(height: 32),
              _buildSignInButton(),
              const Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBackButton() {
    return IconButton(
      onPressed: () => Navigator.pop(context),
      icon: const Icon(Icons.arrow_back),
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(),
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

  Widget _buildEmailField() {
    return TextFormField(
      controller: _emailController,
      decoration: const InputDecoration(hintText: 'Email Address'),
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      controller: _passwordController,
      obscureText: _obscurePassword,
      decoration: InputDecoration(
        hintText: 'Password',
        suffixIcon: IconButton(
          icon: Icon(
            _obscurePassword
                ? Icons.visibility_off_outlined
                : Icons.visibility_outlined,
            color: AppColors.ash,
          ),
          onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
        ),
      ),
      textInputAction: TextInputAction.done,
    );
  }

  Widget _buildSignInButton() {
    return ElevatedButton(
      onPressed: _isFormFilled ? _handleLogin : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: _isFormFilled ? AppColors.black : AppColors.ashLight,
      ),
      child: const Text('Sign In'),
    );
  }

  void _handleLogin() async {
    final authService = AuthService();
    await authService.setFirstLaunchComplete();
    
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeShell()),
      );
    }
  }
}
