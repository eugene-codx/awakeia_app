import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

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

  // Email validation
  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Enter email';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Enter valid email';
    }
    return null;
  }

  // Password validation
  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Enter password';
    }
    if (value.length < 6) {
      return 'Password must contain at least 6 characters';
    }
    return null;
  }

  // Confirm password validation
  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Confirm password';
    }
    if (value != _passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    // Watch auth state for loading and error handling
    final authStatus = ref.watch(authProvider);
    final isLoading = authStatus.isLoading;

    return Scaffold(
      // Using GradientBackground widget
      body: GradientBackground(
        child: LoadingOverlay(
          isLoading: isLoading,
          loadingText: 'Creating account...',
          child: SafeArea(
            child: SingleChildScrollView(
              padding: AppSpacing.screenPadding,
              child: Column(
                children: [
                  const SizedBox(height: AppSpacing.xxl),

                  // Title using centralized text styles
                  Text(
                    'Create Account',
                    style: AppTextStyles.headline2,
                  ),

                  const SizedBox(height: AppSpacing.sm),

                  // Subtitle
                  Text(
                    'Start your journey to a better version of yourself!',
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
                          hintText: 'Email address',
                          prefixIcon: Icons.email_outlined,
                          keyboardType: TextInputType.emailAddress,
                          validator: _validateEmail,
                        ),

                        const SizedBox(height: AppSpacing.md),

                        // Password field using CustomTextField widget
                        CustomTextField(
                          controller: _passwordController,
                          hintText: 'Password',
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
                          validator: _validatePassword,
                        ),

                        const SizedBox(height: AppSpacing.md),

                        // Confirm password field using CustomTextField widget
                        CustomTextField(
                          controller: _confirmPasswordController,
                          hintText: 'Confirm password',
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
                          validator: _validateConfirmPassword,
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
                                  'By registering, you agree to the terms of use and privacy policy',
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
                              'Register',
                              style: AppTextStyles.buttonLarge,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: AppSpacing.xl),

                  // Section divider using custom widget
                  const SectionDivider(
                      title: 'Or register with'),

                  const SizedBox(height: AppSpacing.lg),

                  // Social registration buttons using SocialLoginButton widget
                  Row(
                    children: [
                      // Google registration
                      Expanded(
                        child: SocialLoginButton(
                          icon: Icons.g_mobiledata,
                          text: 'Google',
                          onPressed: () {
                            // TODO: Implement Google registration
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    'Google registration will be added later'),
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
                          text: 'Facebook',
                          onPressed: () {
                            // TODO: Implement Facebook registration
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    'Facebook registration will be added later'),
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
                    text: 'Continue with Apple',
                    onPressed: () {
                      // TODO: Implement Apple registration
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                              'Apple registration will be added later'),
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
                        'Already have an account? ',
                        style: AppTextStyles.linkSecondary,
                      ),
                      TextButton(
                        onPressed: () {
                          context.go('/login');
                        },
                        child: Text(
                          'Login',
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
