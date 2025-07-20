import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../app/extensions/navigation_extensions.dart';
import '../core/logging/app_logger.dart';
import '../features/auth/presentation/providers/auth_providers.dart';
import '../generated/app_localizations.dart';
import '../shared/shared.dart';

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

  // Track if we're currently registering
  bool _isRegistering = false;

  @override
  void initState() {
    super.initState();
    AppLogger.info('RegisterScreen initialized');
  }

  @override
  void dispose() {
    // Clean up controllers
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    AppLogger.info('RegisterScreen disposed');
    super.dispose();
  }

  // Handle registration action
  Future<void> _handleRegister() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // Prevent multiple registration attempts
    if (_isRegistering) return;

    setState(() => _isRegistering = true);

    try {
      // Get register action from provider
      final register = ref.read(registerActionProvider);

      // Perform registration
      await register(
        _emailController.text.trim(),
        _passwordController.text,
      );

      // Check if we have a redirect URL
      if (mounted) {
        final redirect = context.queryParam('redirect');
        if (redirect != null && redirect.isNotEmpty) {
          AppLogger.info('Redirecting to: $redirect after registration');
          context.go(redirect);
        } else {
          context.goToHome();
        }
      }
    } finally {
      if (mounted) {
        setState(() => _isRegistering = false);
      }
    }
  }

  // Email validation
  String? _validateEmail(String? value, AppLocalizations l10n) {
    if (value == null || value.isEmpty) {
      return l10n.emailRequired;
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return l10n.emailInvalid;
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

    // Watch auth state for error handling
    ref.listen(authNotifierProvider, (previous, next) {
      next.whenOrNull(
        data: (authState) {
          // Show error message if registration failed
          if (authState.isUnauthenticated && authState.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(authState.errorMessage!),
                backgroundColor: AppColors.error,
              ),
            );
          }
        },
      );
    });

    // Get loading state from auth
    final isLoading = ref.watch(isAuthLoadingProvider) || _isRegistering;

    return PopScope(
      canPop: true,
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
            onPressed: () => context.goToFirst(),
            tooltip: l10n.back,
          ),
        ),
        body: GradientBackground(
          child: SafeArea(
            child: SingleChildScrollView(
              padding: AppSpacing.screenPadding,
              child: Column(
                children: [
                  const SizedBox(height: AppSpacing.xxl),

                  // Title
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
                        // Email field
                        CustomTextField(
                          controller: _emailController,
                          hintText: l10n.emailAddress,
                          prefixIcon: Icons.email_outlined,
                          keyboardType: TextInputType.emailAddress,
                          enabled: !isLoading,
                          textInputAction: TextInputAction.next,
                          validator: (value) => _validateEmail(value, l10n),
                        ),

                        const SizedBox(height: AppSpacing.md),

                        // Password field
                        CustomTextField(
                          controller: _passwordController,
                          hintText: l10n.password,
                          prefixIcon: Icons.lock_outline,
                          obscureText: _isPasswordHidden,
                          enabled: !isLoading,
                          textInputAction: TextInputAction.next,
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
                          validator: (value) => _validatePassword(value, l10n),
                        ),

                        const SizedBox(height: AppSpacing.md),

                        // Confirm password field
                        CustomTextField(
                          controller: _confirmPasswordController,
                          hintText: l10n.confirmPassword,
                          prefixIcon: Icons.lock_outline,
                          obscureText: _isConfirmPasswordHidden,
                          enabled: !isLoading,
                          textInputAction: TextInputAction.done,
                          onFieldSubmitted: (_) => _handleRegister(),
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
                                color: AppColors.info.withValues(alpha: 0.8),
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

                        // Register button
                        SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: ElevatedButton(
                            onPressed: isLoading ? null : _handleRegister,
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
                                : Text(
                                    l10n.register,
                                    style: AppTextStyles.buttonLarge,
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: AppSpacing.xl),

                  // Section divider
                  SectionDivider(title: l10n.orSignUpWith),

                  const SizedBox(height: AppSpacing.lg),

                  // Social registration buttons
                  Row(
                    children: [
                      // Google registration
                      Expanded(
                        child: SocialLoginButton(
                          icon: Icons.g_mobiledata,
                          text: l10n.google,
                          enabled: !isLoading,
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
                          enabled: !isLoading,
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

                  // Apple registration
                  SocialLoginButton(
                    icon: Icons.apple,
                    text: l10n.apple,
                    enabled: !isLoading,
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
                        onPressed: isLoading
                            ? null
                            : () {
                                // Preserve redirect parameter
                                final redirect = context.queryParam('redirect');
                                context.goToLogin(redirect: redirect);
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
    );
  }
}
