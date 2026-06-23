import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

class AppTextTheme {
  AppTextTheme._();

  static TextTheme textTheme = TextTheme(
    displayLarge: TextStyle(
      fontSize: 32.sp,
      fontWeight: FontWeight.bold,
    ),

    headlineLarge: TextStyle(
      fontSize: 24.sp,
      fontWeight: FontWeight.w700,
    ),

    titleLarge: TextStyle(
      fontSize: 20.sp,
      fontWeight: FontWeight.w600,
    ),

    titleMedium: TextStyle(
      fontSize: 18.sp,
      fontWeight: FontWeight.w600,
    ),

    bodyLarge: TextStyle(
      fontSize: 16.sp,
    ),

    bodyMedium: TextStyle(
      fontSize: 14.sp,
    ),

    bodySmall: TextStyle(
      fontSize: 12.sp,
    ),

    labelLarge: TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.w600,
    ),
  );
}