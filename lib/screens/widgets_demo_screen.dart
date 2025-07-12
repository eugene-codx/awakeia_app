import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_decorations.dart';
import '../theme/app_text_styles.dart';
import '../widgets/common_widgets.dart';

// Demo screen to showcase all custom widgets
// This screen demonstrates how to use each widget from common_widgets.dart
class WidgetsDemoScreen extends StatefulWidget {
  const WidgetsDemoScreen({super.key});

  @override
  State<WidgetsDemoScreen> createState() => _WidgetsDemoScreenState();
}

class _WidgetsDemoScreenState extends State<WidgetsDemoScreen> {
  final _emailController = TextEditingController();
  bool _isLoading = false;
  bool _showError = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _simulateLoading() {
    setState(() => _isLoading = true);
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) setState(() => _isLoading = false);
    });
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
      ),
      body: LoadingOverlay(
        isLoading: _isLoading,
        loadingText: 'Data processing...',
        child: GradientBackground(
          child: SingleChildScrollView(
            padding: AppSpacing.screenPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. WelcomeMessage widget demo
                Text(
                  '1. WelcomeMessage widget',
                  style: AppTextStyles.headline5,
                ),
                const SizedBox(height: AppSpacing.sm),
                const WelcomeMessage(
                  title: 'Welcome to Widgets Demo! 🎉',
                  subtitle:
                      'Here you can explore all custom widgets available in this app.',
                ),

                const SizedBox(height: AppSpacing.lg),

                // 2. PrimaryCard widget demo
                Text(
                  '2. PrimaryCard widget',
                  style: AppTextStyles.headline5,
                ),
                const SizedBox(height: AppSpacing.sm),
                PrimaryCard(
                  child: Column(
                    children: [
                      Text(
                        'PrimaryCard widget',
                        style: AppTextStyles.headline6,
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      Text(
                        'Its automatically styled with primary colors and padding.',
                        style: AppTextStyles.bodyMedium,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: AppSpacing.lg),

                // 3. StatsCard widgets demo
                Text(
                  '3. StatsCard widgets',
                  style: AppTextStyles.headline5,
                ),
                const SizedBox(height: AppSpacing.sm),
                Row(
                  children: [
                    Expanded(
                      child: StatsCard(
                        icon: Icons.local_fire_department,
                        value: '15',
                        label: 'day\'s streak',
                        iconColor: AppColors.warning,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: StatsCard(
                        icon: Icons.check_circle,
                        value: '8/10',
                        label: 'done',
                        iconColor: AppColors.success,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: StatsCard(
                        icon: Icons.analytics,
                        value: '87%',
                        label: 'success rate',
                        iconColor: AppColors.info,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: AppSpacing.lg),

                // 4. CustomTextField widget demo
                Text(
                  '4. CustomTextField widget',
                  style: AppTextStyles.headline5,
                ),
                const SizedBox(height: AppSpacing.sm),
                CustomTextField(
                  controller: _emailController,
                  hintText: 'Enter your email',
                  prefixIcon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) =>
                      value?.isEmpty == true ? 'Mandatory field' : null,
                ),

                const SizedBox(height: AppSpacing.md),

                CustomTextField(
                  hintText: 'Password',
                  prefixIcon: Icons.lock_outline,
                  obscureText: true,
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.visibility_off,
                        color: AppColors.secondaryIcon),
                    onPressed: () {},
                  ),
                ),

                const SizedBox(height: AppSpacing.lg),

                // 5. SocialLoginButton widgets demo
                Text(
                  '5. SocialLoginButton widgets',
                  style: AppTextStyles.headline5,
                ),
                const SizedBox(height: AppSpacing.sm),
                Row(
                  children: [
                    Expanded(
                      child: SocialLoginButton(
                        icon: Icons.g_mobiledata,
                        text: 'Google',
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Google button pressed')),
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: SocialLoginButton(
                        icon: Icons.facebook,
                        text: 'Facebook',
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Facebook button pressed')),
                          );
                        },
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: AppSpacing.lg),

                // 6. SectionDivider widget demo
                Text(
                  '6. SectionDivider widget',
                  style: AppTextStyles.headline5,
                ),
                const SizedBox(height: AppSpacing.sm),
                const SectionDivider(title: 'Or choose an option'),

                const SizedBox(height: AppSpacing.lg),

                // 7. EmptyState widget demo
                Text(
                  '7. EmptyState widget',
                  style: AppTextStyles.headline5,
                ),
                const SizedBox(height: AppSpacing.sm),
                PrimaryCard(
                  child: EmptyState(
                    icon: Icons.inbox_outlined,
                    title: 'Nothing here yet',
                    subtitle:
                        'Add your first item to get started with this feature.',
                    buttonText: 'Add Item',
                    onButtonPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Button EmptyState pressed')),
                      );
                    },
                  ),
                ),

                const SizedBox(height: AppSpacing.lg),

                // 8. ErrorMessage widget demo
                Text(
                  '8. ErrorMessage widget',
                  style: AppTextStyles.headline5,
                ),
                const SizedBox(height: AppSpacing.sm),
                if (_showError)
                  ErrorMessage(
                    message:
                        'An error occurred while processing your request. Check your internet connection and try again.',
                    onRetry: () {
                      setState(() => _showError = false);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Retrying...')),
                      );
                    },
                  )
                else
                  ElevatedButton(
                    onPressed: () => setState(() => _showError = true),
                    child: const Text('Show Error Message'),
                  ),

                const SizedBox(height: AppSpacing.lg),

                // 9. LoadingOverlay demo button
                Text(
                  '9. LoadingOverlay widget',
                  style: AppTextStyles.headline5,
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  'LoadingOverlay shows a loading indicator over the entire screen. Press the button below to demonstrate:',
                  style: AppTextStyles.bodyMedium,
                ),
                const SizedBox(height: AppSpacing.sm),
                ElevatedButton(
                  onPressed: _simulateLoading,
                  child: const Text('Show Loading Overlay'),
                ),

                const SizedBox(height: AppSpacing.lg),

                // 10. Text styles demo
                Text(
                  '10. Text Styles',
                  style: AppTextStyles.headline5,
                ),
                const SizedBox(height: AppSpacing.sm),
                PrimaryCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Headline 1', style: AppTextStyles.headline1),
                      Text('Headline 2', style: AppTextStyles.headline2),
                      Text('Headline 3', style: AppTextStyles.headline3),
                      Text('Headline 4', style: AppTextStyles.headline4),
                      Text('Headline 5', style: AppTextStyles.headline5),
                      Text('Headline 6', style: AppTextStyles.headline6),
                      const SizedBox(height: AppSpacing.sm),
                      Text('Body Large', style: AppTextStyles.bodyLarge),
                      Text('Body Medium', style: AppTextStyles.bodyMedium),
                      Text('Body Small', style: AppTextStyles.bodySmall),
                      const SizedBox(height: AppSpacing.sm),
                      Text('Subtitle', style: AppTextStyles.subtitle),
                      Text('Caption', style: AppTextStyles.caption),
                      Text('Link', style: AppTextStyles.link),
                    ],
                  ),
                ),

                const SizedBox(height: AppSpacing.xl),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
