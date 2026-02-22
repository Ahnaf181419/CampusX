import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  static const String _mono = 'ShareTechMono';
  static const String _font = 'Roboto';

  static const TextStyle headerLarge = TextStyle(
    fontFamily: _mono,
    fontSize: 48,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle headerMedium = TextStyle(
    fontFamily: _mono,
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle headerSmall = TextStyle(
    fontFamily: _font,
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle bodyLarge = TextStyle(
    fontFamily: _font,
    fontSize: 16,
    fontWeight: FontWeight.normal,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontFamily: _font,
    fontSize: 14,
    fontWeight: FontWeight.normal,
  );

  static const TextStyle bodySmall = TextStyle(
    fontFamily: _font,
    fontSize: 12,
    fontWeight: FontWeight.normal,
  );

  static const TextStyle button = TextStyle(
    fontFamily: _font,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
  );
}
