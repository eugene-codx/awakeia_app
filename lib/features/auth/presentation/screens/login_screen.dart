// ===== Login Screen =====
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
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    // Get data from new provider
    final controller = ref.read(loginFormProvider.notifier);
    final state = ref.watch(loginFormProvider);
    final isLoading = state.isLoading;
    final isPasswordHidden = state.isPasswordHidden;

    // Listen to authentication state changes (no changes)
    ref.listen(authNotifierProvider, (previous, next) {
      next.whenOrNull(
        data: (authState) {
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

    // Listen to general errors from provider
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
      canPop: !isLoading, // Don't allow back during loading
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
              child: Column(
                children: [
                  const SizedBox(height: AppSpacing.xxl),
                  Text(l10n.welcome, style: AppTextStyles.headline2),
                  const SizedBox(height: AppSpacing.sm),
                  Text(l10n.niceToSeeYou, style: AppTextStyles.subtitle),
                  const SizedBox(height: AppSpacing.xxl),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        // Email field with new logic
                        CustomTextField(
                          controller: _emailController,
                          hintText: l10n.emailAddress,
                          prefixIcon: Icons.email_outlined,
                          keyboardType: TextInputType.emailAddress,
                          enabled: !isLoading,
                          textInputAction: TextInputAction.next,
                          onChanged: controller.updateEmailUsername,
                          // New handler
                          errorText: state.emailUsernameError,
                        ),

                        const SizedBox(height: AppSpacing.md),

                        // Password field with new logic
                        CustomTextField(
                          controller: _passwordController,
                          hintText: l10n.password,
                          prefixIcon: Icons.lock_outline,
                          obscureText: isPasswordHidden,
                          // From state
                          enabled: !isLoading,
                          textInputAction: TextInputAction.done,
                          onFieldSubmitted: (_) => _handleLogin(),
                          onChanged: controller.updatePassword,
                          // New handler
                          errorText: state.passwordError,
                          // Error from state
                          suffixIcon: IconButton(
                            icon: Icon(
                              isPasswordHidden
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: AppColors.secondaryIcon,
                            ),
                            onPressed: controller
                                .togglePasswordVisibility, // New handler
                          ),
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: isLoading
                                ? null
                                : () =>
                                    context.showComingSoon('Forgot Password'),
                            child: Text(
                              l10n.forgotPassword,
                              style: AppTextStyles.linkSecondary,
                            ),
                          ),
                        ),
                        const SizedBox(height: AppSpacing.lg),
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
                  SectionDivider(title: l10n.orSignInWith),
                  const SizedBox(height: AppSpacing.lg),
                  Row(
                    children: [
                      Expanded(
                        child: SocialLoginButton(
                          icon: Icons.g_mobiledata,
                          text: l10n.google,
                          enabled: !isLoading,
                          onPressed: () =>
                              context.showComingSoon('Google Sign In'),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: SocialLoginButton(
                          icon: Icons.facebook,
                          text: l10n.facebook,
                          enabled: !isLoading,
                          onPressed: () =>
                              context.showComingSoon('Facebook Sign In'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(l10n.noAccount, style: AppTextStyles.linkSecondary),
                      TextButton(
                        onPressed: isLoading
                            ? null
                            : () {
                                final redirect = context.queryParam('redirect');
                                context.goToRegister(redirect: redirect);
                              },
                        child: Text(l10n.register, style: AppTextStyles.link),
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

  Future<void> _handleLogin() async {
    // Synchronize controller values with state
    final controller = ref.read(loginFormProvider.notifier);
    controller.updateEmailUsername(_emailController.text);
    controller.updatePassword(_passwordController.text);

    // Call sign in
    await controller.signIn();
  }
}
