import 'package:flutter/material.dart';

import '../shared.dart';

/// Demo screen to showcase all custom widgets
///
/// This screen demonstrates how to use each widget from common_widgets.dart
/// organized by categories for easy navigation
class WidgetsDemoScreen extends StatefulWidget {
  const WidgetsDemoScreen({super.key});

  @override
  State<WidgetsDemoScreen> createState() => _WidgetsDemoScreenState();
}

class _WidgetsDemoScreenState extends State<WidgetsDemoScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _agreedToTerms = false;
  bool _showError = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _simulateLoading() {
    setState(() => _isLoading = true);
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) setState(() => _isLoading = false);
    });
  }

  void _toggleError() {
    setState(() => _showError = !_showError);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Widgets Demo',
          style: AppTextStyles.appBarTitle,
        ),
        flexibleSpace: Container(
          decoration: AppDecorations.headerGradient,
        ),
        leading: const CustomBackButton(),
      ),
      body: LoadingOverlay(
        isLoading: _isLoading,
        loadingText: 'Processing...',
        child: GradientBackground(
          child: SingleChildScrollView(
            padding: AppSpacing.screenPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Introduction
                _buildSectionHeader('🎨 Widgets Demo'),
                const WelcomeMessage(
                  title: 'Welcome to Widgets Gallery!',
                  subtitle:
                      'Explore all custom widgets available in Awakeia app.',
                ),
                const SizedBox(height: AppSpacing.xl),

                // ============================================================
                // NAVIGATION WIDGETS
                // ============================================================
                _buildCategoryHeader('1. Navigation Widgets'),
                _buildSectionTitle('CustomBackButton'),
                Text(
                  'Smart back button with automatic navigation logic',
                  style: AppTextStyles.caption,
                ),
                const SizedBox(height: AppSpacing.md),
                Row(
                  children: [
                    CustomBackButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Back button pressed')),
                        );
                      },
                    ),
                    const SizedBox(width: AppSpacing.md),
                    const Text('← Styled back button'),
                  ],
                ),
                const SizedBox(height: AppSpacing.xl),

                // ============================================================
                // LAYOUT WIDGETS
                // ============================================================
                _buildCategoryHeader('2. Layout Widgets'),
                _buildSectionTitle('AppLogo'),
                Text(
                  'App logo in different sizes: small, medium, large',
                  style: AppTextStyles.caption,
                ),
                const SizedBox(height: AppSpacing.md),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        const AppLogo(size: AppLogoSize.small),
                        const SizedBox(height: AppSpacing.sm),
                        Text('Small', style: AppTextStyles.caption),
                      ],
                    ),
                    Column(
                      children: [
                        const AppLogo(size: AppLogoSize.medium),
                        const SizedBox(height: AppSpacing.sm),
                        Text('Medium', style: AppTextStyles.caption),
                      ],
                    ),
                    Column(
                      children: [
                        const AppLogo(size: AppLogoSize.large),
                        const SizedBox(height: AppSpacing.sm),
                        Text('Large', style: AppTextStyles.caption),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.lg),

                _buildSectionTitle('PrimaryCard'),
                Text(
                  'Card with consistent styling and optional tap handler',
                  style: AppTextStyles.caption,
                ),
                const SizedBox(height: AppSpacing.md),
                PrimaryCard(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Card tapped!')),
                    );
                  },
                  child: Column(
                    children: [
                      Text(
                        'Tappable Card',
                        style: AppTextStyles.headline6,
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      Text(
                        'Tap me to see the ripple effect',
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.secondaryText,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.xl),

                // ============================================================
                // BUTTON WIDGETS
                // ============================================================
                _buildCategoryHeader('3. Button Widgets'),
                _buildSectionTitle('PrimaryButton'),
                Text(
                  'Main action button with loading state support',
                  style: AppTextStyles.caption,
                ),
                const SizedBox(height: AppSpacing.md),
                PrimaryButton(
                  text: 'Normal State',
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Primary button pressed')),
                    );
                  },
                ),
                const SizedBox(height: AppSpacing.md),
                PrimaryButton(
                  text: 'With Icon',
                  icon: Icons.check_circle,
                  onPressed: () {},
                ),
                const SizedBox(height: AppSpacing.md),
                const PrimaryButton(
                  text: 'Loading State',
                  isLoading: true,
                  onPressed: null,
                ),
                const SizedBox(height: AppSpacing.md),
                const PrimaryButton(
                  text: 'Disabled State',
                  onPressed: null,
                ),
                const SizedBox(height: AppSpacing.lg),

                _buildSectionTitle('SecondaryButton'),
                Text(
                  'Outlined button for secondary actions',
                  style: AppTextStyles.caption,
                ),
                const SizedBox(height: AppSpacing.md),
                SecondaryButton(
                  text: 'Secondary Action',
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Secondary button pressed'),
                      ),
                    );
                  },
                ),
                const SizedBox(height: AppSpacing.md),
                SecondaryButton(
                  text: 'With Icon',
                  icon: Icons.arrow_back,
                  onPressed: () {},
                ),
                const SizedBox(height: AppSpacing.lg),

                _buildSectionTitle('SocialLoginButton'),
                Text(
                  'Buttons for social authentication',
                  style: AppTextStyles.caption,
                ),
                const SizedBox(height: AppSpacing.md),
                Row(
                  children: [
                    Expanded(
                      child: SocialLoginButton(
                        icon: Icons.g_mobiledata,
                        text: 'Google',
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Google login')),
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: SocialLoginButton(
                        icon: Icons.facebook,
                        text: 'Facebook',
                        enabled: false,
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.xl),

                // ============================================================
                // FORM WIDGETS
                // ============================================================
                _buildCategoryHeader('4. Form Widgets'),
                _buildSectionTitle('CustomTextField'),
                Text(
                  'Text input with consistent styling',
                  style: AppTextStyles.caption,
                ),
                const SizedBox(height: AppSpacing.md),
                CustomTextField(
                  controller: _emailController,
                  hintText: 'Email',
                  prefixIcon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {},
                ),
                const SizedBox(height: AppSpacing.md),
                CustomTextField(
                  controller: _passwordController,
                  hintText: 'Password',
                  prefixIcon: Icons.lock_outline,
                  obscureText: _obscurePassword,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: AppColors.secondaryIcon,
                    ),
                    onPressed: () {
                      setState(() => _obscurePassword = !_obscurePassword);
                    },
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                const CustomTextField(
                  hintText: 'Disabled field',
                  prefixIcon: Icons.block,
                  enabled: false,
                ),
                const SizedBox(height: AppSpacing.lg),

                _buildSectionTitle('CheckboxTile'),
                Text(
                  'Checkbox with label inside a card',
                  style: AppTextStyles.caption,
                ),
                const SizedBox(height: AppSpacing.md),
                CheckboxTile(
                  value: _agreedToTerms,
                  label: 'I agree to the Terms and Conditions',
                  onChanged: (value) {
                    setState(() => _agreedToTerms = value);
                  },
                ),
                const SizedBox(height: AppSpacing.xl),

                // ============================================================
                // FEEDBACK WIDGETS
                // ============================================================
                _buildCategoryHeader('5. Feedback Widgets'),
                _buildSectionTitle('AppLoadingIndicator'),
                Text(
                  'Standard loading spinner',
                  style: AppTextStyles.caption,
                ),
                const SizedBox(height: AppSpacing.md),
                const Center(child: AppLoadingIndicator()),
                const SizedBox(height: AppSpacing.lg),

                _buildSectionTitle('ErrorDisplay'),
                Text(
                  'Error message with retry button',
                  style: AppTextStyles.caption,
                ),
                const SizedBox(height: AppSpacing.md),
                PrimaryCard(
                  child: ErrorDisplay(
                    title: 'Something went wrong',
                    message: 'Unable to load data. Please try again.',
                    onRetry: _toggleError,
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),

                _buildSectionTitle('EmptyState'),
                Text(
                  'Shown when there is no data',
                  style: AppTextStyles.caption,
                ),
                const SizedBox(height: AppSpacing.md),
                PrimaryCard(
                  child: EmptyState(
                    icon: Icons.inbox_outlined,
                    title: 'No items yet',
                    subtitle: 'Start by creating your first item',
                    buttonText: 'Create Item',
                    onButtonPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Create button pressed')),
                      );
                    },
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),

                _buildSectionTitle('LoadingOverlay'),
                Text(
                  'Full screen overlay (tap the button below)',
                  style: AppTextStyles.caption,
                ),
                const SizedBox(height: AppSpacing.md),
                PrimaryButton(
                  text: 'Show Loading Overlay',
                  icon: Icons.hourglass_empty,
                  onPressed: _simulateLoading,
                ),
                const SizedBox(height: AppSpacing.xl),

                // ============================================================
                // DATA DISPLAY WIDGETS
                // ============================================================
                _buildCategoryHeader('6. Data Display Widgets'),
                _buildSectionTitle('StatsCard'),
                Text(
                  'Display statistics with icon and label',
                  style: AppTextStyles.caption,
                ),
                const SizedBox(height: AppSpacing.md),
                const Row(
                  children: [
                    Expanded(
                      child: StatsCard(
                        icon: Icons.local_fire_department,
                        value: '7',
                        label: 'Day Streak',
                        iconColor: AppColors.warning,
                      ),
                    ),
                    SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: StatsCard(
                        icon: Icons.check_circle,
                        value: '3/5',
                        label: 'Completed',
                        iconColor: AppColors.success,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.lg),

                _buildSectionTitle('WelcomeMessage'),
                Text(
                  'Welcome banner with title and subtitle',
                  style: AppTextStyles.caption,
                ),
                const SizedBox(height: AppSpacing.md),
                const WelcomeMessage(
                  title: 'Hello, User! 👋',
                  subtitle: 'Ready to build great habits today?',
                ),
                const SizedBox(height: AppSpacing.lg),

                _buildSectionTitle('SectionDivider'),
                Text(
                  'Divider with centered text',
                  style: AppTextStyles.caption,
                ),
                const SizedBox(height: AppSpacing.md),
                const SectionDivider(title: 'OR'),
                const SizedBox(height: AppSpacing.xl),

                // Bottom spacing
                const SizedBox(height: AppSpacing.xl),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper method to build category headers
  Widget _buildCategoryHeader(String title) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: AppSpacing.sm,
        horizontal: AppSpacing.md,
      ),
      decoration: BoxDecoration(
        color: AppColors.primaryButton.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(AppDecorations.radiusMedium),
      ),
      child: Text(
        title,
        style: AppTextStyles.headline5.copyWith(
          color: AppColors.primaryText,
        ),
      ),
    );
  }

  // Helper method to build section headers
  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: AppTextStyles.headline3,
    );
  }

  // Helper method to build section titles
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(
        top: AppSpacing.md,
        bottom: AppSpacing.sm,
      ),
      child: Text(
        title,
        style: AppTextStyles.headline6.copyWith(
          color: AppColors.primaryText,
        ),
      ),
    );
  }
}
