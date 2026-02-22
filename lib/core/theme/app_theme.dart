import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get light => ThemeData(
    fontFamily: 'Roboto',
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.white,
    colorScheme: const ColorScheme.light(
      primary: AppColors.black,
      onPrimary: AppColors.white,
      surface: AppColors.white,
      onSurface: AppColors.black,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.white,
      foregroundColor: AppColors.black,
      shape: Border(
        bottom: BorderSide(
          color: AppColors.ash, // Or any color you prefer
          width: 0.5, // Set to a low value for a "thin" line
        ),
      ),
      elevation: 0,
      centerTitle: true,
      titleTextStyle: AppTextStyles.headerMedium.copyWith(
        color: AppColors.black,
      ),
      iconTheme: const IconThemeData(color: AppColors.black),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      border: UnderlineInputBorder(),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: AppColors.ash),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: AppColors.black, width: 2),
      ),
      iconColor: AppColors.ash,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: AppColors.white,
        textStyle: AppTextStyles.button,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        minimumSize: Size(double.infinity, 48),
      ),
    ),
    textTheme: const TextTheme(
      bodyMedium: AppTextStyles.bodyMedium,
      bodyLarge: AppTextStyles.bodyLarge,
      bodySmall: AppTextStyles.bodySmall,
    ),
  );
}
