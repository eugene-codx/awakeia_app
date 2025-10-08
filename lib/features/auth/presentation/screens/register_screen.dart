// lib/features/auth/presentation/screens/register_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/extensions/navigation_extensions.dart';
import '../../../../core/logging/app_logger.dart';
import '../../../../shared/shared.dart';
import '../providers/auth_providers.dart';
import '../providers/register_form_provider.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _usernameController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    AppLogger.info('RegisterScreen initialized');

    // Reset the form state after the first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(registerFormProvider.notifier).resetForm();
    });
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _firstNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    // Get data and actions from the form provider
    final controller = ref.read(registerFormProvider.notifier);
    final state = ref.watch(registerFormProvider);
    final isLoading = state.isLoading;
    final isPasswordHidden = state.isPasswordHidden;
    final isConfirmPasswordHidden = state.isConfirmPasswordHidden;

    // Listen to auth state changes
    ref.listen(authProvider, (previous, next) {
      next.whenOrNull(
        data: (authState) {
          if (authState.isAuthenticated && mounted) {
            final redirect = context.queryParam('redirect');
            AppLogger.info(
              'RegisterScreen: User is authenticated - redirecting to $redirect',
            );
            if (redirect != null && redirect.isNotEmpty) {
              context.go(redirect);
            } else {
              context.goToHome();
            }
          }
        },
      );
    });

    // Listen to registration errors
    ref.listen(
      registerFormProvider.select((state) => state.generalError),
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
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(height: AppSpacing.xl),

                    // App logo
                    const AppLogo(size: AppLogoSize.medium),

                    const SizedBox(height: AppSpacing.xl),

                    // Registration form card
                    PrimaryCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Username field
                          CustomTextField(
                            controller: _usernameController,
                            hintText: l10n.username,
                            prefixIcon: Icons.person_outline,
                            keyboardType: TextInputType.name,
                            enabled: !isLoading,
                            textInputAction: TextInputAction.next,
                            onChanged: controller.updateUsername,
                            errorText: state.usernameError,
                          ),

                          const SizedBox(height: AppSpacing.md),

                          // Email field
                          CustomTextField(
                            controller: _emailController,
                            hintText: l10n.username,
                            prefixIcon: Icons.email_outlined,
                            keyboardType: TextInputType.emailAddress,
                            enabled: !isLoading,
                            textInputAction: TextInputAction.next,
                            onChanged: controller.updateEmail,
                            errorText: state.emailError,
                          ),

                          const SizedBox(height: AppSpacing.md),

                          // First Name field
                          CustomTextField(
                            controller: _firstNameController,
                            hintText: l10n.firstName,
                            prefixIcon: Icons.person_outline,
                            keyboardType: TextInputType.name,
                            enabled: !isLoading,
                            textInputAction: TextInputAction.next,
                            onChanged: controller.updateFirstName,
                            errorText: state.firstNameError,
                          ),

                          const SizedBox(height: AppSpacing.md),

                          // Password field
                          CustomTextField(
                            controller: _passwordController,
                            hintText: l10n.password,
                            prefixIcon: Icons.lock_outline,
                            obscureText: isPasswordHidden,
                            enabled: !isLoading,
                            textInputAction: TextInputAction.next,
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

                          // Confirm Password field
                          CustomTextField(
                            controller: _confirmPasswordController,
                            hintText: l10n.confirmPassword,
                            prefixIcon: Icons.lock_outline,
                            obscureText: isConfirmPasswordHidden,
                            enabled: !isLoading,
                            textInputAction: TextInputAction.done,
                            onFieldSubmitted: (_) => _handleRegister(),
                            onChanged: controller.updateConfirmPassword,
                            errorText: state.confirmPasswordError,
                            suffixIcon: IconButton(
                              icon: Icon(
                                isConfirmPasswordHidden
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: AppColors.secondaryIcon,
                              ),
                              onPressed:
                                  controller.toggleConfirmPasswordVisibility,
                            ),
                          ),

                          const SizedBox(height: AppSpacing.lg),

                          // Terms and Conditions using new CheckboxTile widget
                          CheckboxTile(
                            value: state.agreedToTerms,
                            label: l10n.termsAndConditions,
                            onChanged: (_) => controller.toggleTermsAgreement(),
                            enabled: !isLoading,
                          ),

                          const SizedBox(height: AppSpacing.lg),

                          // Register button using new widget
                          PrimaryButton(
                            text: l10n.register,
                            onPressed: isLoading ? null : _handleRegister,
                            isLoading: isLoading,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: AppSpacing.xl),

                    // Login link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          l10n.haveAccount,
                          style: AppTextStyles.linkSecondary,
                        ),
                        TextButton(
                          onPressed:
                              isLoading ? null : () => context.goToLogin(),
                          child: Text(
                            l10n.login,
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

  Future<void> _handleRegister() async {
    // Clear previous errors
    ref.read(registerFormProvider.notifier).clearError();

    AppLogger.info(
      'RegisterScreen._handleRegister: Attempting to register with email: ${_emailController.text}',
    );
    // Synchronize the form state
    final controller = ref.read(registerFormProvider.notifier);
    controller.updateEmail(_emailController.text);
    controller.updatePassword(_passwordController.text);
    controller.updateConfirmPassword(_confirmPasswordController.text);

    // Check if terms are agreed
    if (!ref.read(registerFormProvider).agreedToTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please agree to the Terms and Conditions'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    // Call the register method
    await controller.register();
  }
}
