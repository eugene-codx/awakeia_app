import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../theme/app_colors.dart';
import '../theme/app_decorations.dart';
import '../theme/app_text_styles.dart';

// Custom back button widget for reuse across screens
class CustomBackButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String? tooltip;

  const CustomBackButton({
    super.key,
    this.onPressed,
    this.tooltip = 'Back',
  });

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
      onPressed: onPressed ?? () => context.go('/first'),
      tooltip: tooltip,
    );
  }
}

// Gradient background widget
// Use this for screens with gradient background
class GradientBackground extends StatelessWidget {
  final Widget child;
  final List<Color>? colors;

  const GradientBackground({
    super.key,
    required this.child,
    this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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

// Primary card widget with consistent styling
class PrimaryCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final VoidCallback? onTap;

  const PrimaryCard({
    super.key,
    required this.child,
    this.padding,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: padding ?? AppSpacing.paddingLG,
        decoration: AppDecorations.primaryCard,
        child: child,
      ),
    );
  }
}

// Stats card widget for displaying numbers and labels
class StatsCard extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final Color iconColor;

  const StatsCard({
    super.key,
    required this.icon,
    required this.value,
    required this.label,
    this.iconColor = AppColors.accentIcon,
  });

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

// Welcome message widget
class WelcomeMessage extends StatelessWidget {
  final String title;
  final String subtitle;

  const WelcomeMessage({
    super.key,
    required this.title,
    required this.subtitle,
  });

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

// Custom input field with consistent styling
class CustomTextField extends StatelessWidget {
  final String hintText;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;

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
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      style: AppTextStyles.inputText,
      validator: validator,
      onChanged: onChanged,
      decoration: AppDecorations.primaryInput.copyWith(
        hintText: hintText,
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

// Social login button widget
class SocialLoginButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onPressed;

  const SocialLoginButton({
    super.key,
    required this.icon,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
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

// Loading overlay widget
class LoadingOverlay extends StatelessWidget {
  final bool isLoading;
  final Widget child;
  final String? loadingText;

  const LoadingOverlay({
    super.key,
    required this.isLoading,
    required this.child,
    this.loadingText,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading)
          Container(
            color: AppColors.overlay,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      AppColors.primaryText,
                    ),
                  ),
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

// Error message widget
class ErrorMessage extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;

  const ErrorMessage({
    super.key,
    required this.message,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppSpacing.paddingMD,
      decoration: AppDecorations.primaryCard,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.error_outline,
            color: AppColors.error,
            size: 48,
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            message,
            style: AppTextStyles.error,
            textAlign: TextAlign.center,
          ),
          if (onRetry != null) ...[
            const SizedBox(height: AppSpacing.md),
            ElevatedButton(
              onPressed: onRetry,
              child: const Text('Try Again'),
            ),
          ],
        ],
      ),
    );
  }
}

// Empty state widget
class EmptyState extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String? buttonText;
  final VoidCallback? onButtonPressed;

  const EmptyState({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.buttonText,
    this.onButtonPressed,
  });

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
          ElevatedButton.icon(
            onPressed: onButtonPressed,
            icon: const Icon(Icons.add),
            label: Text(buttonText!),
          ),
        ],
      ],
    );
  }
}

// Section divider with title
class SectionDivider extends StatelessWidget {
  final String title;

  const SectionDivider({
    super.key,
    required this.title,
  });

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
