// lib/features/auth/presentation/screens/login_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/extensions/navigation_extensions.dart';
import '../../../../core/logging/app_logger.dart';
import '../../../../shared/shared.dart';
import '../providers/auth_providers.dart';
import '../providers/login_form_provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    AppLogger.info('LoginScreen initialized');

    // Reset form on initialization
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(loginFormProvider.notifier).resetForm();
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    // Get data from provider
    final controller = ref.read(loginFormProvider.notifier);
    final state = ref.watch(loginFormProvider);
    final isLoading = state.isLoading;
    final isPasswordHidden = state.isPasswordHidden;

    // Listen to authentication state changes
    ref.listen(authProvider, (previous, next) {
      next.whenOrNull(
        data: (authState) {
          // Only navigate on successful authentication
          if (authState.isAuthenticated && mounted) {
            final redirect = context.queryParam('redirect');
            if (redirect != null && redirect.isNotEmpty) {
              context.go(redirect);
            } else {
              context.goToHome();
            }
          }
        },
      );
    });

    // Listen to login errors
    ref.listen(
      loginFormProvider.select((state) => state.generalError),
      (previous, current) {
        if (current != null && mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(current),
              backgroundColor: AppColors.error,
              action: SnackBarAction(
                label: 'Dismiss',
                onPressed: controller.clearError,
              ),
            ),
          );
        }
      },
    );

    return PopScope(
      canPop: !isLoading,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Login', style: AppTextStyles.appBarTitle),
          centerTitle: true,
          flexibleSpace: Container(decoration: AppDecorations.headerGradient),
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
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(height: AppSpacing.xl),

                    // App logo
                    const AppLogo(size: AppLogoSize.medium),

                    const SizedBox(height: AppSpacing.xl),

                    // Login form card
                    PrimaryCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Email field
                          CustomTextField(
                            controller: _emailController,
                            hintText: l10n.emailAddress,
                            prefixIcon: Icons.email_outlined,
                            keyboardType: TextInputType.emailAddress,
                            enabled: !isLoading,
                            textInputAction: TextInputAction.next,
                            onChanged: controller.updateEmailUsername,
                            errorText: state.emailUsernameError,
                          ),

                          const SizedBox(height: AppSpacing.md),

                          // Password field
                          CustomTextField(
                            controller: _passwordController,
                            hintText: l10n.password,
                            prefixIcon: Icons.lock_outline,
                            obscureText: isPasswordHidden,
                            enabled: !isLoading,
                            textInputAction: TextInputAction.done,
                            onFieldSubmitted: (_) => _handleLogin(),
                            onChanged: controller.updatePassword,
                            errorText: state.passwordError,
                            suffixIcon: IconButton(
                              icon: Icon(
                                isPasswordHidden
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: AppColors.secondaryIcon,
                              ),
                              onPressed: controller.togglePasswordVisibility,
                            ),
                          ),

                          const SizedBox(height: AppSpacing.md),

                          // Forgot password link
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: isLoading
                                  ? null
                                  : () => context.showComingSoon(
                                        'Password reset',
                                      ),
                              child: Text(
                                l10n.forgotPassword,
                                style: AppTextStyles.linkPrimary,
                              ),
                            ),
                          ),

                          const SizedBox(height: AppSpacing.lg),

                          // Login button using new widget
                          PrimaryButton(
                            text: l10n.login,
                            onPressed: isLoading ? null : _handleLogin,
                            isLoading: isLoading,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: AppSpacing.lg),

                    // Divider
                    const SectionDivider(title: 'OR'),

                    const SizedBox(height: AppSpacing.lg),

                    // Social login buttons
                    Row(
                      children: [
                        Expanded(
                          child: SocialLoginButton(
                            icon: Icons.g_mobiledata,
                            text: 'Google',
                            enabled: !isLoading,
                            onPressed: () =>
                                context.showComingSoon('Google sign in'),
                          ),
                        ),
                        const SizedBox(width: AppSpacing.md),
                        Expanded(
                          child: SocialLoginButton(
                            icon: Icons.facebook,
                            text: 'Facebook',
                            enabled: !isLoading,
                            onPressed: () =>
                                context.showComingSoon('Facebook sign in'),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: AppSpacing.xl),

                    // Register link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          l10n.noAccount,
                          style: AppTextStyles.linkSecondary,
                        ),
                        TextButton(
                          onPressed:
                              isLoading ? null : () => context.goToRegister(),
                          child: Text(
                            l10n.register,
                            style: AppTextStyles.linkPrimary,
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
      ),
    );
  }

  Future<void> _handleLogin() async {
    // Synchronize controller values with state
    final controller = ref.read(loginFormProvider.notifier);
    controller.updateEmailUsername(_emailController.text.trim());
    controller.updatePassword(_passwordController.text);

    // Call sign in
    await controller.signIn();
  }
}
