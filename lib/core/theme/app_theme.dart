import 'package:flutter/material.dart';
import 'package:project_pulse/core/constants/app_colors.dart';

import 'text_theme.dart';

class AppTheme {
  AppTheme._();

  static ThemeData light = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,

    colorScheme: ColorScheme.light(
      primary:          AppColors.primary,         // 0xFF4F6BFF
      onPrimary:        AppColors.white,
      primaryContainer: AppColors.primaryLight,    // 0xFFE8ECFF  ← lighter blue
      inversePrimary:   AppColors.primaryDark,     // 0xFF3D57F5
      secondary:        AppColors.secondary,       // 0xFF57E6A7
      onSecondary:      AppColors.black,
      surface:          AppColors.surface,
      onSurface:        AppColors.black,
      error:            AppColors.error,
    ),

    scaffoldBackgroundColor: AppColors.background,

    primaryColor: AppColors.primary,

    textTheme: AppTextTheme.textTheme,

    appBarTheme: const AppBarTheme(
      centerTitle: false,
      elevation: 0,
      backgroundColor: Colors.white,
      foregroundColor: AppColors.black,
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.grey50,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 52),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    ),
  );

  static ThemeData dark = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,

    colorScheme: ColorScheme.dark(
      primary:          AppColors.primary,
      onPrimary:        AppColors.white,
      primaryContainer: AppColors.primaryContainer,  
      inversePrimary:   AppColors.inversePrimary,         
      secondary:        AppColors.secondary,
      surface:          AppColors.surfaceDark,     
      onSurface:        AppColors.white,
      error:            AppColors.error,
    ),
    scaffoldBackgroundColor: AppColors.backgroundDark,

    textTheme: AppTextTheme.textTheme,

    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: AppColors.backgroundDark,
    ),
  );
}