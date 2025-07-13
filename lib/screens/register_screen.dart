import 'package:awakeia/utils/localization_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../generated/app_localizations.dart';
import '../providers/auth_provider.dart';
import '../theme/app_colors.dart';
import '../theme/app_decorations.dart';
import '../theme/app_text_styles.dart';
import '../widgets/common_widgets.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  // Controllers for text fields
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  // Form key for validation
  final _formKey = GlobalKey<FormState>();

  // Password visibility toggles
  bool _isPasswordHidden = true;
  bool _isConfirmPasswordHidden = true;

  @override
  void dispose() {
    // Clean up controllers
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  // Handle registration action
  Future<void> _handleRegister() async {
    if (_formKey.currentState!.validate()) {
      // Call auth provider register method
      await ref.read(authProvider.notifier).register(
            _emailController.text.trim(),
            _passwordController.text,
          );

      // Check if registration was successful
      final authStatus = ref.read(authProvider);
      if (authStatus.isAuthenticated && mounted) {
        context.go('/home');
      } else if (authStatus.error != null && mounted) {
        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(authStatus.error!),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  // Handle back navigation
  void _handleBack() {
    // Navigate back to first screen
    context.go('/first');
  }

  // Email validation
  String? _validateEmail(String? value, AppLocalizations l10n) {
    if (value == null || value.isEmpty) {
      return l10n.emailRequired;
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return l10n.emailRequired;
    }
    return null;
  }

  // Password validation
  String? _validatePassword(String? value, AppLocalizations l10n) {
    if (value == null || value.isEmpty) {
      return l10n.passwordRequired;
    }
    if (value.length < 6) {
      return l10n.passwordTooShort;
    }
    return null;
  }

  // Confirm password validation
  String? _validateConfirmPassword(String? value, AppLocalizations l10n) {
    if (value == null || value.isEmpty) {
      return l10n.confirmPasswordRequired;
    }
    if (value != _passwordController.text) {
      return l10n.passwordsDoNotMatch;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    // Get localization instance
    final l10n = context.l10n;
    // Watch auth state for loading and error handling
    final authStatus = ref.watch(authProvider);
    final isLoading = authStatus.isLoading;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, Object? result) {
        if (!didPop) context.go('/first');
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Register',
            style: AppTextStyles.appBarTitle,
          ),
          centerTitle: true,
          flexibleSpace: Container(
            decoration: AppDecorations.headerGradient,
          ),
          elevation: 0,
          leading: CustomBackButton(
            onPressed: _handleBack,
            tooltip: l10n.back,
          ),
        ),
        // Using GradientBackground widget
        body: GradientBackground(
          child: LoadingOverlay(
            isLoading: isLoading,
            loadingText: l10n.creatingAccount,
            child: SafeArea(
              child: SingleChildScrollView(
                padding: AppSpacing.screenPadding,
                child: Column(
                  children: [
                    const SizedBox(height: AppSpacing.xxl),

                    // Title using centralized text styles
                    Text(
                      l10n.createAccount,
                      style: AppTextStyles.headline2,
                    ),

                    const SizedBox(height: AppSpacing.sm),

                    // Subtitle
                    Text(
                      l10n.startYourJourney,
                      style: AppTextStyles.subtitle,
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: AppSpacing.xxl),

                    // Registration form
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          // Email field using CustomTextField widget
                          CustomTextField(
                            controller: _emailController,
                            hintText: l10n.emailAddress,
                            prefixIcon: Icons.email_outlined,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) => _validateEmail(value, l10n),
                          ),

                          const SizedBox(height: AppSpacing.md),

                          // Password field using CustomTextField widget
                          CustomTextField(
                            controller: _passwordController,
                            hintText: l10n.password,
                            prefixIcon: Icons.lock_outline,
                            obscureText: _isPasswordHidden,
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isPasswordHidden
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: AppColors.secondaryIcon,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isPasswordHidden = !_isPasswordHidden;
                                });
                              },
                            ),
                            validator: (value) =>
                                _validatePassword(value, l10n),
                          ),

                          const SizedBox(height: AppSpacing.md),

                          // Confirm password field using CustomTextField widget
                          CustomTextField(
                            controller: _confirmPasswordController,
                            hintText: l10n.confirmPassword,
                            prefixIcon: Icons.lock_outline,
                            obscureText: _isConfirmPasswordHidden,
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isConfirmPasswordHidden
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: AppColors.secondaryIcon,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isConfirmPasswordHidden =
                                      !_isConfirmPasswordHidden;
                                });
                              },
                            ),
                            validator: (value) =>
                                _validateConfirmPassword(value, l10n),
                          ),

                          const SizedBox(height: AppSpacing.lg),

                          // Terms and conditions info
                          PrimaryCard(
                            padding: AppSpacing.paddingMD,
                            child: Row(
                              children: [
                                Icon(
                                  Icons.info_outline,
                                  color: AppColors.info,
                                  size: 20,
                                ),
                                const SizedBox(width: AppSpacing.sm),
                                Expanded(
                                  child: Text(
                                    l10n.termsAndConditions,
                                    style: AppTextStyles.caption,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: AppSpacing.lg),

                          // Register button - uses theme automatically
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: isLoading ? null : _handleRegister,
                              child: Text(
                                l10n.register,
                                style: AppTextStyles.buttonLarge,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: AppSpacing.xl),

                    // Section divider using custom widget
                    SectionDivider(title: l10n.orSignUpWith),

                    const SizedBox(height: AppSpacing.lg),

                    // Social registration buttons using SocialLoginButton widget
                    Row(
                      children: [
                        // Google registration
                        Expanded(
                          child: SocialLoginButton(
                            icon: Icons.g_mobiledata,
                            text: l10n.google,
                            onPressed: () {
                              // TODO: Implement Google registration
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(l10n.googleSignInComingSoon),
                                ),
                              );
                            },
                          ),
                        ),

                        const SizedBox(width: AppSpacing.md),

                        // Facebook registration
                        Expanded(
                          child: SocialLoginButton(
                            icon: Icons.facebook,
                            text: l10n.facebook,
                            onPressed: () {
                              // TODO: Implement Facebook registration
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(l10n.facebookSignInComingSoon),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: AppSpacing.md),

                    // Additional social options (example of extending functionality)
                    SocialLoginButton(
                      icon: Icons.apple,
                      text: l10n.apple,
                      onPressed: () {
                        // TODO: Implement Apple registration
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(l10n.appleSignInComingSoon),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: AppSpacing.xl),

                    // Login prompt
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          l10n.haveAccount,
                          style: AppTextStyles.linkSecondary,
                        ),
                        TextButton(
                          onPressed: () {
                            context.go('/login');
                          },
                          child: Text(
                            l10n.login,
                            style: AppTextStyles.link,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: AppSpacing.lg),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
