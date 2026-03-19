import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/screens/login_choice_screen.dart';
import 'services/auth_service.dart';
import 'shared/home_shell.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const CampusXApp());
}

class CampusXApp extends StatelessWidget {
  const CampusXApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CampusX',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const AuthWrapper(),
    );
  }
}

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: AuthService().isFirstLaunch(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        final isFirstLaunch = snapshot.data ?? true;

        if (isFirstLaunch) {
          return const LoginChoiceScreen();
        }

        return const HomeShell();
      },
    );
  }
}
