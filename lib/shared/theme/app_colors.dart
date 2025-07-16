import 'package:flutter/material.dart';

// Central place for all app colors
// This class contains all color constants used throughout the app
class AppColors {
  // Private constructor to prevent instantiation
  AppColors._();

  // Primary purple colors from the design
  static const Color lightPurple = Color(0xFFB794F6);
  static const Color mediumPurple = Color(0xFF805AD5);
  static const Color darkPurple = Color(0xFF553C9A);

  // Gradient colors
  static const List<Color> primaryGradient = [
    lightPurple,
    mediumPurple,
    darkPurple,
  ];

  static const List<Color> headerGradient = [
    lightPurple,
    mediumPurple,
  ];

  // Text colors
  static const Color primaryText = Colors.white;
  static const Color secondaryText = Color(0xFFE2E8F0); // Light gray-white
  static const Color hintText = Color(0xFFB2B2B2); // Medium gray

  // Background colors
  static const Color scaffoldBackground = darkPurple;
  static const Color cardBackground =
      Color(0x1AFFFFFF); // White with 10% opacity
  static const Color inputBackground =
      Color(0x4DFFFFFF); // White with 30% opacity

  // Accent colors
  static const Color success = Color(0xFF48BB78); // Green
  static const Color warning = Color(0xFFED8936); // Orange
  static const Color error = Color(0xFFF56565); // Red
  static const Color info = Color(0xFF4299E1); // Blue

  // Button colors
  static const Color primaryButton = Colors.white;
  static const Color primaryButtonText = darkPurple;
  static const Color secondaryButton = Colors.transparent;
  static const Color secondaryButtonBorder = Colors.white;
  static const Color secondaryButtonText = Colors.white;

  // Border colors
  static const Color primaryBorder =
      Color(0x33FFFFFF); // White with 20% opacity
  static const Color secondaryBorder =
      Color(0x1AFFFFFF); // White with 10% opacity

  // Status bar colors
  static const Color statusBarLight = lightPurple;
  static const Color statusBarDark = darkPurple;

  // Icon colors
  static const Color primaryIcon = Colors.white;
  static const Color secondaryIcon =
      Color(0xB3FFFFFF); // White with 70% opacity
  static const Color accentIcon = warning;

  // Divider colors
  static const Color divider = Color(0x4DFFFFFF); // White with 30% opacity

  // Overlay colors
  static const Color overlay = Color(0x80000000); // Black with 50% opacity
  static const Color bottomSheetOverlay =
      Color(0x1AFFFFFF); // White with 10% opacity
}
