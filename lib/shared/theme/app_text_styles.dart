import 'package:flutter/material.dart';

import 'app_colors.dart';

// Central place for all text styles
// This class contains all text style constants used throughout the app
class AppTextStyles {
  // Private constructor to prevent instantiation
  AppTextStyles._();

  // Base text style
  static const TextStyle _baseStyle = TextStyle(
    fontFamily: 'SF Pro Display', // You can change this to your preferred font
    color: AppColors.primaryText,
  );

  // Headline styles
  static final TextStyle headline1 = _baseStyle.copyWith(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    height: 1.2,
  );

  static final TextStyle headline2 = _baseStyle.copyWith(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    height: 1.3,
  );

  static final TextStyle headline3 = _baseStyle.copyWith(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    height: 1.3,
  );

  static final TextStyle headline4 = _baseStyle.copyWith(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    height: 1.4,
  );

  static final TextStyle headline5 = _baseStyle.copyWith(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    height: 1.4,
  );

  static final TextStyle headline6 = _baseStyle.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 1.4,
  );

  // Body text styles
  static final TextStyle bodyLarge = _baseStyle.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    height: 1.5,
  );

  static final TextStyle bodyMedium = _baseStyle.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    height: 1.5,
  );

  static final TextStyle bodySmall = _baseStyle.copyWith(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    height: 1.4,
  );

  // Special text styles
  static final TextStyle subtitle = _baseStyle.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.secondaryText,
    height: 1.5,
  );

  static final TextStyle caption = _baseStyle.copyWith(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: AppColors.secondaryText,
    height: 1.3,
  );

  static final TextStyle overline = _baseStyle.copyWith(
    fontSize: 10,
    fontWeight: FontWeight.w500,
    color: AppColors.secondaryText,
    letterSpacing: 1.2,
    height: 1.6,
  );

  // Button text styles
  static final TextStyle buttonLarge = _baseStyle.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.primaryButtonText,
    height: 1.0,
  );

  static final TextStyle buttonMedium = _baseStyle.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.primaryButtonText,
    height: 1.0,
  );

  static final TextStyle buttonSmall = _baseStyle.copyWith(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: AppColors.primaryButtonText,
    height: 1.0,
  );

  // Input field text styles
  static final TextStyle inputText = _baseStyle.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.primaryText,
    height: 1.2,
  );

  static final TextStyle inputHint = _baseStyle.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.hintText,
    height: 1.2,
  );

  static final TextStyle inputLabel = _baseStyle.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.secondaryText,
    height: 1.2,
  );

  // Link text styles
  static final TextStyle linkPrimary = _baseStyle.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.primaryText,
    decoration: TextDecoration.underline,
    height: 1.2,
  );

  static final TextStyle linkSecondary = _baseStyle.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.secondaryText,
    height: 1.2,
  );

  // Error text style
  static final TextStyle error = _baseStyle.copyWith(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: AppColors.error,
    height: 1.3,
  );

  // Success text style
  static final TextStyle success = _baseStyle.copyWith(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: AppColors.success,
    height: 1.3,
  );

  // App bar title style
  static final TextStyle appBarTitle = _baseStyle.copyWith(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: AppColors.primaryText,
    height: 1.2,
  );

  // Tab bar text style
  static final TextStyle tabBar = _baseStyle.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    height: 1.2,
  );

  // Stats/numbers text styles
  static final TextStyle statsNumber = _baseStyle.copyWith(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AppColors.primaryText,
    height: 1.0,
  );

  static final TextStyle statsLabel = _baseStyle.copyWith(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: AppColors.secondaryText,
    height: 1.2,
  );
}
