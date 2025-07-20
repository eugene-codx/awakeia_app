import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../app/extensions/navigation_extensions.dart';
import '../core/logging/app_logger.dart';
import '../features/auth/presentation/providers/auth_providers.dart';
import '../shared/shared.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  // Controllers for text fields
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // Form key for validation
  final _formKey = GlobalKey<FormState>();

  // Password visibility toggle
  bool _isPasswordHidden = true;

  // Track if we're currently logging in
  bool _isLoggingIn = false;

  @override
  void initState() {
    super.initState();
    AppLogger.info('LoginScreen initialized');
  }

  @override
  void dispose() {
    // Clean up controllers
    _emailController.dispose();
    _passwordController.dispose();
    AppLogger.info('LoginScreen disposed');
    super.dispose();
  }

  // Handle login action
  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // Prevent multiple login attempts
    if (_isLoggingIn) return;

    setState(() => _isLoggingIn = true);

    try {
      // Get sign in action from provider
      final signIn = ref.read(signInActionProvider);

      // Perform login
      await signIn(
        _emailController.text.trim(),
        _passwordController.text,
      );

      // Check if we have a redirect URL
      if (mounted) {
        final redirect = context.queryParam('redirect');
        if (redirect != null && redirect.isNotEmpty) {
          AppLogger.info('Redirecting to: $redirect');
          context.go(redirect);
        } else {
          context.goToHome();
        }
      }
    } finally {
      if (mounted) {
        setState(() => _isLoggingIn = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get localization instance
    final l10n = context.l10n;

    // Watch auth state for error handling
    ref.listen(authNotifierProvider, (previous, next) {
      next.whenOrNull(
        data: (authState) {
          // Show error message if authentication failed
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
    final isLoading = ref.watch(isAuthLoadingProvider) || _isLoggingIn;

    return PopScope(
      canPop: true,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Login',
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

                  // Welcome title
                  Text(
                    l10n.welcome,
                    style: AppTextStyles.headline2,
                  ),

                  const SizedBox(height: AppSpacing.sm),

                  // Subtitle
                  Text(
                    l10n.niceToSeeYou,
                    style: AppTextStyles.subtitle,
                  ),

                  const SizedBox(height: AppSpacing.xxl),

                  // Login form
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
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return l10n.emailRequired;
                            }
                            if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                .hasMatch(value)) {
                              return l10n.emailInvalid;
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: AppSpacing.md),

                        // Password field
                        CustomTextField(
                          controller: _passwordController,
                          hintText: l10n.password,
                          prefixIcon: Icons.lock_outline,
                          obscureText: _isPasswordHidden,
                          enabled: !isLoading,
                          textInputAction: TextInputAction.done,
                          onFieldSubmitted: (_) => _handleLogin(),
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
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return l10n.passwordRequired;
                            }
                            if (value.length < 6) {
                              return l10n.passwordTooShort;
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: AppSpacing.sm),

                        // Forgot password link
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: isLoading
                                ? null
                                : () {
                                    // TODO: Implement forgot password
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content:
                                            Text(l10n.forgotPasswordComingSoon),
                                      ),
                                    );
                                  },
                            child: Text(
                              l10n.forgotPassword,
                              style: AppTextStyles.linkSecondary,
                            ),
                          ),
                        ),

                        const SizedBox(height: AppSpacing.lg),

                        // Login button
                        SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: ElevatedButton(
                            onPressed: isLoading ? null : _handleLogin,
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
                                    l10n.login,
                                    style: AppTextStyles.buttonLarge,
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: AppSpacing.xl),

                  // Section divider
                  SectionDivider(title: l10n.orSignInWith),

                  const SizedBox(height: AppSpacing.lg),

                  // Social login buttons
                  Row(
                    children: [
                      // Google login
                      Expanded(
                        child: SocialLoginButton(
                          icon: Icons.g_mobiledata,
                          text: l10n.google,
                          enabled: !isLoading,
                          onPressed: () {
                            // TODO: Implement Google login
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(l10n.googleSignInComingSoon),
                              ),
                            );
                          },
                        ),
                      ),

                      const SizedBox(width: AppSpacing.md),

                      // Facebook login
                      Expanded(
                        child: SocialLoginButton(
                          icon: Icons.facebook,
                          text: l10n.facebook,
                          enabled: !isLoading,
                          onPressed: () {
                            // TODO: Implement Facebook login
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

                  const SizedBox(height: AppSpacing.xl),

                  // Sign up prompt
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        l10n.noAccount,
                        style: AppTextStyles.linkSecondary,
                      ),
                      TextButton(
                        onPressed: isLoading
                            ? null
                            : () {
                                // Preserve redirect parameter
                                final redirect = context.queryParam('redirect');
                                context.goToRegister(redirect: redirect);
                              },
                        child: Text(
                          l10n.register,
                          style: AppTextStyles.link,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
