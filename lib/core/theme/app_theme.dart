import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primary,
        secondary: AppColors.primaryDark,
        surface: AppColors.surface,
        onSurface: AppColors.textPrimary,
        error: AppColors.error,
      ),
      textTheme: _textTheme,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: false,
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.divider,
        thickness: 1,
      ),
    );
  }

  static TextTheme get _textTheme {
    return TextTheme(
      headlineLarge: GoogleFonts.arimo(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.4,
        color: AppColors.textPrimary,
      ),
      headlineMedium: GoogleFonts.arimo(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.4,
        color: AppColors.textPrimary,
      ),
      titleLarge: GoogleFonts.arimo(
        fontSize: 17,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.4,
        color: AppColors.textPrimary,
      ),
      titleMedium: GoogleFonts.arimo(
        fontSize: 15,
        fontWeight: FontWeight.w400,
        letterSpacing: -0.4,
        color: AppColors.textPrimary,
      ),
      bodyLarge: GoogleFonts.arimo(
        fontSize: 17,
        fontWeight: FontWeight.w400,
        letterSpacing: -0.4,
        color: AppColors.textPrimary,
      ),
      bodyMedium: GoogleFonts.arimo(
        fontSize: 11,
        fontWeight: FontWeight.w400,
        letterSpacing: -0.4,
        color: AppColors.textSecondary,
      ),
      labelSmall: GoogleFonts.arimo(
        fontSize: 9,
        fontWeight: FontWeight.w400,
        letterSpacing: -0.4,
        color: AppColors.textPrimary,
      ),
    );
  }
}