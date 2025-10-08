import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../app/extensions/navigation_extensions.dart';
import '../shared.dart';

// ============================================================================
// NAVIGATION WIDGETS
// ============================================================================

/// Custom back button widget for reuse across screens
///
/// Features:
/// - Custom styling with card background
/// - Smart navigation (pop or go to home)
/// - Optional custom onPressed callback
class CustomBackButton extends StatelessWidget {
  const CustomBackButton({
    super.key,
    this.onPressed,
    this.tooltip = 'Back',
  });

  final VoidCallback? onPressed;
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(AppDecorations.radiusMedium),
          border: Border.all(
            color: AppColors.primaryBorder,
            width: 1,
          ),
        ),
        child: const Icon(
          Icons.arrow_back_ios,
          color: AppColors.primaryIcon,
          size: 16,
        ),
      ),
      onPressed: onPressed ??
          () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.goToHome();
            }
          },
      tooltip: tooltip,
    );
  }
}

// ============================================================================
// LAYOUT WIDGETS
// ============================================================================

/// Gradient background widget
/// Use this for screens with gradient background
class GradientBackground extends StatelessWidget {
  const GradientBackground({
    super.key,
    required this.child,
    this.colors,
  });

  final Widget child;
  final List<Color>? colors;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: colors ?? AppColors.primaryGradient,
        ),
      ),
      child: child,
    );
  }
}

/// Primary card widget with consistent styling
///
/// Features:
/// - Consistent padding and decoration
/// - Optional tap handling with Material ripple effect
class PrimaryCard extends StatelessWidget {
  const PrimaryCard({
    super.key,
    required this.child,
    this.padding,
    this.onTap,
  });

  final Widget child;
  final EdgeInsets? padding;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(AppDecorations.radiusLarge),
        onTap: onTap,
        child: Container(
          width: double.infinity,
          padding: padding ?? AppSpacing.paddingLG,
          decoration: AppDecorations.primaryCard,
          child: child,
        ),
      ),
    );
  }
}

/// App logo widget with different sizes
///
/// Sizes:
/// - small: 64x64
/// - medium: 96x96
/// - large: 120x120
enum AppLogoSize { small, medium, large }

class AppLogo extends StatelessWidget {
  const AppLogo({
    super.key,
    this.size = AppLogoSize.large,
  });

  final AppLogoSize size;

  double get _containerSize {
    switch (size) {
      case AppLogoSize.small:
        return 64;
      case AppLogoSize.medium:
        return 96;
      case AppLogoSize.large:
        return 120;
    }
  }

  double get _iconSize {
    switch (size) {
      case AppLogoSize.small:
        return 32;
      case AppLogoSize.medium:
        return 48;
      case AppLogoSize.large:
        return 64;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _containerSize,
      height: _containerSize,
      decoration: AppDecorations.logoContainer,
      child: Icon(
        Icons.self_improvement,
        size: _iconSize,
        color: AppColors.primaryIcon,
      ),
    );
  }
}

// ============================================================================
// BUTTON WIDGETS
// ============================================================================

/// Primary button with consistent styling
///
/// Features:
/// - Loading state with spinner
/// - Disabled state
/// - Optional icon
/// - Full width option
class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.isFullWidth = true,
    this.icon,
  });

  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isFullWidth;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final button = ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      child: isLoading
          ? const SizedBox(
              height: 24,
              width: 24,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(
                  AppColors.primaryButtonText,
                ),
              ),
            )
          : icon != null
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(icon, size: 20),
                    const SizedBox(width: AppSpacing.sm),
                    Text(text, style: AppTextStyles.buttonLarge),
                  ],
                )
              : Text(text, style: AppTextStyles.buttonLarge),
    );

    return isFullWidth
        ? SizedBox(
            width: double.infinity,
            height: 56,
            child: button,
          )
        : SizedBox(height: 56, child: button);
  }
}

/// Secondary button (outlined) with consistent styling
///
/// Features:
/// - Loading state
/// - Disabled state
/// - Optional icon
/// - Full width option
class SecondaryButton extends StatelessWidget {
  const SecondaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.isFullWidth = true,
    this.icon,
  });

  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isFullWidth;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final button = OutlinedButton(
      onPressed: isLoading ? null : onPressed,
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(
          vertical: AppSpacing.md,
          horizontal: AppSpacing.lg,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDecorations.radiusMedium),
        ),
      ),
      child: isLoading
          ? const SizedBox(
              height: 24,
              width: 24,
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            )
          : icon != null
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(icon, size: 20),
                    const SizedBox(width: AppSpacing.sm),
                    Text(text),
                  ],
                )
              : Text(text),
    );

    return isFullWidth
        ? SizedBox(
            width: double.infinity,
            height: 56,
            child: button,
          )
        : SizedBox(height: 56, child: button);
  }
}

/// Social login button widget for Google, Facebook, Apple, etc.
class SocialLoginButton extends StatelessWidget {
  const SocialLoginButton({
    super.key,
    required this.icon,
    required this.text,
    this.enabled = true,
    required this.onPressed,
  });

  final IconData icon;
  final String text;
  final bool enabled;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: enabled ? onPressed : null,
      style: OutlinedButton.styleFrom(
        padding: AppSpacing.verticalMD,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDecorations.radiusMedium),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 24),
          const SizedBox(width: AppSpacing.sm),
          Text(text),
        ],
      ),
    );
  }
}

// ============================================================================
// FORM WIDGETS
// ============================================================================

/// Custom input field with consistent styling
///
/// Features:
/// - Prefix and suffix icons
/// - Password visibility toggle
/// - Validation support
/// - Error text display
class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.controller,
    this.keyboardType,
    this.validator,
    this.onChanged,
    this.enabled = true,
    this.textInputAction,
    this.onFieldSubmitted,
    this.errorText,
  });

  final String hintText;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;
  final bool enabled;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onFieldSubmitted;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      style: AppTextStyles.inputText,
      validator: validator,
      onChanged: onChanged,
      enabled: enabled,
      textInputAction: textInputAction,
      onFieldSubmitted: onFieldSubmitted,
      decoration: AppDecorations.primaryInput.copyWith(
        hintText: hintText,
        errorText: errorText,
        prefixIcon: prefixIcon != null
            ? Icon(
                prefixIcon,
                color: AppColors.secondaryIcon,
              )
            : null,
        suffixIcon: suffixIcon,
      ),
    );
  }
}

/// Checkbox tile for terms, conditions, etc.
///
/// Features:
/// - Checkbox with label
/// - Tap to toggle
/// - Disabled state
class CheckboxTile extends StatelessWidget {
  const CheckboxTile({
    super.key,
    required this.value,
    required this.label,
    required this.onChanged,
    this.enabled = true,
  });

  final bool value;
  final String label;
  final ValueChanged<bool> onChanged;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return PrimaryCard(
      padding: AppSpacing.paddingMD,
      onTap: enabled ? () => onChanged(!value) : null,
      child: Row(
        children: [
          Checkbox(
            value: value,
            onChanged: enabled ? (_) => onChanged(!value) : null,
            activeColor: AppColors.primaryButton,
            checkColor: AppColors.primaryButtonText,
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              label,
              style: AppTextStyles.caption,
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// FEEDBACK WIDGETS
// ============================================================================

/// Loading overlay widget
///
/// Covers the entire screen with a semi-transparent overlay
/// and shows a loading indicator with optional text
class LoadingOverlay extends StatelessWidget {
  const LoadingOverlay({
    super.key,
    required this.isLoading,
    required this.child,
    this.loadingText,
  });

  final bool isLoading;
  final Widget child;
  final String? loadingText;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading)
          ColoredBox(
            color: AppColors.overlay,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const AppLoadingIndicator(),
                  if (loadingText != null) ...[
                    const SizedBox(height: AppSpacing.md),
                    Text(
                      loadingText!,
                      style: AppTextStyles.bodyMedium,
                    ),
                  ],
                ],
              ),
            ),
          ),
      ],
    );
  }
}

/// Standard loading indicator for the app
class AppLoadingIndicator extends StatelessWidget {
  const AppLoadingIndicator({
    super.key,
    this.size = 40,
  });

  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: const CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(
          AppColors.primaryText,
        ),
      ),
    );
  }
}

/// Error display widget
///
/// Shows error icon, message, and optional retry button
class ErrorDisplay extends StatelessWidget {
  const ErrorDisplay({
    super.key,
    required this.message,
    this.title = 'Error',
    this.icon = Icons.error_outline,
    this.onRetry,
  });

  final String message;
  final String title;
  final IconData icon;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: 64,
          color: AppColors.error,
        ),
        const SizedBox(height: AppSpacing.md),
        Text(
          title,
          style: AppTextStyles.headline5,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          message,
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.secondaryText,
          ),
          textAlign: TextAlign.center,
        ),
        if (onRetry != null) ...[
          const SizedBox(height: AppSpacing.lg),
          PrimaryButton(
            text: 'Retry',
            onPressed: onRetry,
            isFullWidth: false,
            icon: Icons.refresh,
          ),
        ],
      ],
    );
  }
}

/// Empty state widget
///
/// Shows when there's no data to display
class EmptyState extends StatelessWidget {
  const EmptyState({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.buttonText,
    this.onButtonPressed,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final String? buttonText;
  final VoidCallback? onButtonPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: 64,
          color: AppColors.secondaryIcon,
        ),
        const SizedBox(height: AppSpacing.md),
        Text(
          title,
          style: AppTextStyles.headline5,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          subtitle,
          style: AppTextStyles.subtitle,
          textAlign: TextAlign.center,
        ),
        if (buttonText != null && onButtonPressed != null) ...[
          const SizedBox(height: AppSpacing.lg),
          PrimaryButton(
            text: buttonText!,
            onPressed: onButtonPressed,
            icon: Icons.add,
            isFullWidth: false,
          ),
        ],
      ],
    );
  }
}

// ============================================================================
// DATA DISPLAY WIDGETS
// ============================================================================

/// Stats card widget for displaying numbers and labels
class StatsCard extends StatelessWidget {
  const StatsCard({
    super.key,
    required this.icon,
    required this.value,
    required this.label,
    this.iconColor = AppColors.accentIcon,
  });

  final IconData icon;
  final String value;
  final String label;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppSpacing.paddingMD,
      decoration: AppDecorations.statsCard,
      child: Column(
        children: [
          Icon(
            icon,
            color: iconColor,
            size: 32,
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            value,
            style: AppTextStyles.statsNumber,
          ),
          Text(
            label,
            style: AppTextStyles.statsLabel,
          ),
        ],
      ),
    );
  }
}

/// Welcome message widget
class WelcomeMessage extends StatelessWidget {
  const WelcomeMessage({
    super.key,
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: AppSpacing.paddingLG,
      decoration: AppDecorations.welcomeContainer,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextStyles.headline4,
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            subtitle,
            style: AppTextStyles.subtitle,
          ),
        ],
      ),
    );
  }
}

/// Section divider with title
class SectionDivider extends StatelessWidget {
  const SectionDivider({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 1,
            color: AppColors.divider,
          ),
        ),
        Padding(
          padding: AppSpacing.horizontalMD,
          child: Text(
            title,
            style: AppTextStyles.subtitle,
          ),
        ),
        Expanded(
          child: Container(
            height: 1,
            color: AppColors.divider,
          ),
        ),
      ],
    );
  }
}
