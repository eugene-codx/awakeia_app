import 'package:flutter/material.dart';

import 'app_colors.dart';

// Central place for all decorations and container styles
// This class contains all decoration constants used throughout the app
class AppDecorations {
  // Private constructor to prevent instantiation
  AppDecorations._();

  // Border radius values
  static const double radiusSmall = 8.0;
  static const double radiusMedium = 12.0;
  static const double radiusLarge = 16.0;
  static const double radiusXLarge = 24.0;

  // Gradient decorations
  static const BoxDecoration primaryGradient = BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: AppColors.primaryGradient,
    ),
  );

  static BoxDecoration headerGradient = BoxDecoration(
    gradient: const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: AppColors.headerGradient,
    ),
    boxShadow: [
      BoxShadow(
        color: AppColors.mediumPurple.withValues(alpha: 0.3),
        blurRadius: 20,
        spreadRadius: 5,
      ),
    ],
  );

  // Card decorations
  static BoxDecoration get primaryCard => BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(radiusLarge),
        border: Border.all(
          color: AppColors.primaryBorder,
          width: 1.0,
        ),
      );

  static BoxDecoration get secondaryCard => BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(radiusMedium),
        border: Border.all(
          color: AppColors.secondaryBorder,
          width: 1.0,
        ),
      );

  static BoxDecoration get statsCard => BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(radiusMedium),
        border: Border.all(
          color: AppColors.primaryBorder,
          width: 1.0,
        ),
      );

  // Input field decorations
  static InputDecoration get primaryInput => InputDecoration(
        filled: true,
        fillColor: AppColors.inputBackground,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusLarge),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusLarge),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusLarge),
          borderSide: const BorderSide(
            color: AppColors.primaryText,
            width: 2.0,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusLarge),
          borderSide: const BorderSide(
            color: AppColors.error,
            width: 2.0,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusLarge),
          borderSide: const BorderSide(
            color: AppColors.error,
            width: 2.0,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 16.0,
        ),
      );

  // Button decorations
  static BoxDecoration get primaryButton => BoxDecoration(
        color: AppColors.primaryButton,
        borderRadius: BorderRadius.circular(radiusLarge),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8.0,
            offset: const Offset(0, 2),
          ),
        ],
      );

  static BoxDecoration get secondaryButton => BoxDecoration(
        color: AppColors.secondaryButton,
        borderRadius: BorderRadius.circular(radiusLarge),
        border: Border.all(
          color: AppColors.secondaryButtonBorder,
          width: 1.5,
        ),
      );

  static BoxDecoration get iconButton => BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(radiusMedium),
        border: Border.all(
          color: AppColors.primaryBorder,
          width: 1.0,
        ),
      );

  // Container decorations
  static BoxDecoration get welcomeContainer => BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(radiusLarge),
        border: Border.all(
          color: AppColors.primaryBorder,
          width: 1.0,
        ),
      );

  static BoxDecoration get logoContainer => BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(radiusXLarge),
      );

  // Divider decoration
  static Container get divider => Container(
        height: 1.0,
        color: AppColors.divider,
      );

  // Shadow decorations
  static List<BoxShadow> get cardShadow => [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.1),
          blurRadius: 8.0,
          offset: const Offset(0, 2),
        ),
      ];

  static List<BoxShadow> get buttonShadow => [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.15),
          blurRadius: 12.0,
          offset: const Offset(0, 4),
        ),
      ];

  // Bottom sheet decoration
  static BoxDecoration get bottomSheet => const BoxDecoration(
        color: AppColors.darkPurple,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(radiusXLarge),
          topRight: Radius.circular(radiusXLarge),
        ),
      );

  // Dialog decoration
  static BoxDecoration get dialog => BoxDecoration(
        color: AppColors.darkPurple,
        borderRadius: BorderRadius.circular(radiusLarge),
        border: Border.all(
          color: AppColors.primaryBorder,
          width: 1.0,
        ),
      );
}

// Spacing constants
class AppSpacing {
  AppSpacing._();

  // Padding values
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;
  static const double xxl = 48.0;

  // Edge insets
  static const EdgeInsets paddingXS = EdgeInsets.all(xs);
  static const EdgeInsets paddingSM = EdgeInsets.all(sm);
  static const EdgeInsets paddingMD = EdgeInsets.all(md);
  static const EdgeInsets paddingLG = EdgeInsets.all(lg);
  static const EdgeInsets paddingXL = EdgeInsets.all(xl);
  static const EdgeInsets paddingXXL = EdgeInsets.all(xxl);

  // Horizontal padding
  static const EdgeInsets horizontalXS = EdgeInsets.symmetric(horizontal: xs);
  static const EdgeInsets horizontalSM = EdgeInsets.symmetric(horizontal: sm);
  static const EdgeInsets horizontalMD = EdgeInsets.symmetric(horizontal: md);
  static const EdgeInsets horizontalLG = EdgeInsets.symmetric(horizontal: lg);
  static const EdgeInsets horizontalXL = EdgeInsets.symmetric(horizontal: xl);

  // Vertical padding
  static const EdgeInsets verticalXS = EdgeInsets.symmetric(vertical: xs);
  static const EdgeInsets verticalSM = EdgeInsets.symmetric(vertical: sm);
  static const EdgeInsets verticalMD = EdgeInsets.symmetric(vertical: md);
  static const EdgeInsets verticalLG = EdgeInsets.symmetric(vertical: lg);
  static const EdgeInsets verticalXL = EdgeInsets.symmetric(vertical: xl);

  // Screen padding
  static const EdgeInsets screenPadding = EdgeInsets.all(lg);
  static const EdgeInsets screenPaddingHorizontal =
      EdgeInsets.symmetric(horizontal: lg);
  static const EdgeInsets screenPaddingVertical =
      EdgeInsets.symmetric(vertical: lg);
}
