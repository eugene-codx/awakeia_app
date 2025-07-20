// ===== Register Screen =====
// lib/features/auth/presentation/screens/register_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/extensions/navigation_extensions.dart';
import '../../../../core/logging/app_logger.dart';
import '../../../../shared/shared.dart';
import '../providers/auth_providers.dart';
import '../view_models/auth_view_models.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isPasswordHidden = true;
  bool _isConfirmPasswordHidden = true;

  @override
  void initState() {
    super.initState();
    AppLogger.info('RegisterScreen initialized');
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    AppLogger.info('RegisterScreen disposed');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final isLoading = ref.watch(registerLoadingProvider);
    final emailError = ref.watch(registerEmailErrorProvider);
    final passwordError = ref.watch(registerPasswordErrorProvider);
    final confirmPasswordError =
        ref.watch(registerConfirmPasswordErrorProvider);

    // Listen for auth success
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

    // Listen for errors
    ref.listen(registerErrorProvider, (previous, current) {
      if (current != null && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(current),
            backgroundColor: AppColors.error,
          ),
        );
      }
    });

    return PopScope(
      canPop: true,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Register', style: AppTextStyles.appBarTitle),
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
                  Text(l10n.createAccount, style: AppTextStyles.headline2),
                  const SizedBox(height: AppSpacing.sm),
                  Text(l10n.startYourJourney,
                      style: AppTextStyles.subtitle,
                      textAlign: TextAlign.center,),
                  const SizedBox(height: AppSpacing.xxl),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        CustomTextField(
                          controller: _emailController,
                          hintText: l10n.emailAddress,
                          prefixIcon: Icons.email_outlined,
                          keyboardType: TextInputType.emailAddress,
                          enabled: !isLoading,
                          textInputAction: TextInputAction.next,
                          validator: (_) => emailError,
                        ),
                        const SizedBox(height: AppSpacing.md),
                        CustomTextField(
                          controller: _passwordController,
                          hintText: l10n.password,
                          prefixIcon: Icons.lock_outline,
                          obscureText: _isPasswordHidden,
                          enabled: !isLoading,
                          textInputAction: TextInputAction.next,
                          validator: (_) => passwordError,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isPasswordHidden
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: AppColors.secondaryIcon,
                            ),
                            onPressed: () => setState(
                                () => _isPasswordHidden = !_isPasswordHidden,),
                          ),
                        ),
                        const SizedBox(height: AppSpacing.md),
                        CustomTextField(
                          controller: _confirmPasswordController,
                          hintText: l10n.confirmPassword,
                          prefixIcon: Icons.lock_outline,
                          obscureText: _isConfirmPasswordHidden,
                          enabled: !isLoading,
                          textInputAction: TextInputAction.done,
                          onFieldSubmitted: (_) => _handleRegister(),
                          validator: (_) => confirmPasswordError,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isConfirmPasswordHidden
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: AppColors.secondaryIcon,
                            ),
                            onPressed: () => setState(() =>
                                _isConfirmPasswordHidden =
                                    !_isConfirmPasswordHidden,),
                          ),
                        ),
                        const SizedBox(height: AppSpacing.lg),
                        PrimaryCard(
                          padding: AppSpacing.paddingMD,
                          child: Row(
                            children: [
                              Icon(Icons.info_outline,
                                  color: AppColors.info.withValues(alpha: 0.8),
                                  size: 20,),
                              const SizedBox(width: AppSpacing.sm),
                              Expanded(
                                child: Text(l10n.termsAndConditions,
                                    style: AppTextStyles.caption,),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: AppSpacing.lg),
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
                                          AppColors.primaryButtonText,),
                                    ),
                                  )
                                : Text(l10n.register,
                                    style: AppTextStyles.buttonLarge,),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  SectionDivider(title: l10n.orSignUpWith),
                  const SizedBox(height: AppSpacing.lg),
                  Row(
                    children: [
                      Expanded(
                        child: SocialLoginButton(
                          icon: Icons.g_mobiledata,
                          text: l10n.google,
                          enabled: !isLoading,
                          onPressed: () =>
                              context.showComingSoon('Google Sign Up'),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: SocialLoginButton(
                          icon: Icons.facebook,
                          text: l10n.facebook,
                          enabled: !isLoading,
                          onPressed: () =>
                              context.showComingSoon('Facebook Sign Up'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.md),
                  SocialLoginButton(
                    icon: Icons.apple,
                    text: l10n.apple,
                    enabled: !isLoading,
                    onPressed: () => context.showComingSoon('Apple Sign Up'),
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(l10n.haveAccount,
                          style: AppTextStyles.linkSecondary,),
                      TextButton(
                        onPressed: isLoading
                            ? null
                            : () {
                                final redirect = context.queryParam('redirect');
                                context.goToLogin(redirect: redirect);
                              },
                        child: Text(l10n.login, style: AppTextStyles.link),
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

  Future<void> _handleRegister() async {
    final registerAction = ref.read(registerSignUpActionProvider);
    await registerAction(
      _emailController.text.trim(),
      _passwordController.text,
      _confirmPasswordController.text,
    );
  }
}
