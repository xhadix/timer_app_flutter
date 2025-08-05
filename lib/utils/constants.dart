import 'package:flutter/material.dart';

class AppColors {
  // Gradient colors
  static const Color gradientStart = Color(0xFF0E215A);
  static const Color gradientEnd = Color(0xFF1D47BA);
  
  // Navigation background
  static const Color navigationBackground = Color(0xFF1F49BE);
  
  // Text colors
  static const Color textPrimary = Colors.white;
  static const Color textSecondary = Color(0x99FFFFFF); // 60% opacity
  static const Color textTertiary = Color(0x66FFFFFF); // 40% opacity
  
  // Background colors
  static const Color cardBackground = Color(0x1AFFFFFF); // 10% opacity
  static const Color cardBackgroundHover = Color(0x26FFFFFF); // 15% opacity
  
  // Border colors
  static const Color borderColor = Color(0x33FFFFFF); // 20% opacity
  static const Color borderColorFocus = Color(0x66FFFFFF); // 40% opacity
}

class AppSpacing {
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;
  static const double xxl = 48.0;
}

class AppRadius {
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 12.0;
  static const double lg = 16.0;
  static const double xl = 24.0;
}

class AppTypography {
  static const TextStyle heading1 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );
  
  static const TextStyle heading2 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );
  
  static const TextStyle body1 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
  );
  
  static const TextStyle body2 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
  );
  
  static const TextStyle caption = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: AppColors.textTertiary,
  );
} 