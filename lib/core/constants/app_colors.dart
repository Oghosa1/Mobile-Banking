import 'package:flutter/material.dart';

/// Defines the application's color palette.
class AppColors {
  static const Color background = Color(0xFF1C1C1D);
  static const Color surface = Color(0xFF232325);
  static const Color surfaceLight = Color(0xFF272729);
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFE9E9EA);
  static const Color primary = Color(0xFF0065FF);
  static const Color primaryDark = Color(0xFF0047B3);
  static const Color error = Color(0xFF5A0000);
  static const Color errorBackground = Color(0xFFFFD5D5);
  static const Color divider = Color(0xFF232325);
  static const Color mastercardRed = Color(0xFFFF0015);
  static const Color mastercardOrange = Color(0xFFFF9900);
  static const Color debitRed = Color(0xFFFF3B30);
}

/// Defines standard spacing values used throughout the application.
class AppSpacing {
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;
  static const double xxl = 48.0;
}

/// Defines standard animation durations used throughout the application.
class AppDurations {
  static const Duration fast = Duration(milliseconds: 150);
  static const Duration standard = Duration(milliseconds: 300);
  static const Duration slow = Duration(milliseconds: 500);
  static const Duration countUp = Duration(milliseconds: 800);
}