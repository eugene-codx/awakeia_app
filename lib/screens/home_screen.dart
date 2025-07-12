import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/auth_provider.dart';
import '../theme/app_colors.dart';
import '../theme/app_decorations.dart';
import '../theme/app_text_styles.dart';
import '../widgets/common_widgets.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Get current user from auth provider
    final currentUser = ref.watch(currentUserProvider);
    final isAuthLoading = ref.watch(isAuthLoadingProvider);

    return Scaffold(
      // App bar with gradient using centralized decoration
      appBar: AppBar(
        title: Text(
          'Awakeia',
          style: AppTextStyles.appBarTitle,
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: AppDecorations.headerGradient,
        ),
        elevation: 0,
        actions: [
          // Profile button
          IconButton(
            icon: const Icon(
              Icons.person_outline,
              color: AppColors.primaryIcon,
            ),
            onPressed: () {
              // TODO: Navigate to profile screen
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                      'The profile screen will be added in future versions'),
                ),
              );
            },
          ),
        ],
      ),

      // Main content with loading overlay
      body: LoadingOverlay(
        isLoading: isAuthLoading,
        loadingText: 'Loading...',
        child: GradientBackground(
          colors: AppColors.primaryGradient,
          child: SafeArea(
            child: Padding(
              padding: AppSpacing.screenPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Welcome message using custom widget
                  WelcomeMessage(
                    title: currentUser?.isGuest == true
                        ? 'Welcome, Guest 👋'
                        : 'Welcome, ${currentUser?.name ?? 'User'}! 👋',
                    subtitle: 'Ready to track your habits?',
                  ),

                  const SizedBox(height: AppSpacing.lg),

                  // Section title using centralized text style
                  Text(
                    'Today\'s Habits',
                    style: AppTextStyles.headline5,
                  ),

                  const SizedBox(height: AppSpacing.md),

                  // Habits section - using EmptyState widget
                  Expanded(
                    child: PrimaryCard(
                      child: EmptyState(
                        icon: Icons.self_improvement,
                        title: 'No Habits Yet',
                        subtitle: 'Create your first habit to get started!',
                        buttonText: 'Create Habit',
                        onButtonPressed: () {
                          // TODO: Navigate to add habit screen
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  'Creating habits will be added in future versions'),
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                  const SizedBox(height: AppSpacing.md),

                  // Quick stats row using StatsCard widgets
                  Row(
                    children: [
                      // Streak counter
                      Expanded(
                        child: StatsCard(
                          icon: Icons.local_fire_department,
                          value: '0',
                          label: 'days streak',
                          iconColor: AppColors.warning,
                        ),
                      ),

                      const SizedBox(width: AppSpacing.md),

                      // Completed today
                      Expanded(
                        child: StatsCard(
                          icon: Icons.check_circle,
                          value: '0/0',
                          label: 'completed today',
                          iconColor: AppColors.success,
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

      // Floating action button with theme styling
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Navigate to add habit screen
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Creating habits will be added in future versions'),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),

      // Bottom navigation bar with theme styling
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.darkPurple,
        selectedItemColor: AppColors.primaryText,
        unselectedItemColor: AppColors.secondaryIcon,
        currentIndex: 0,
        selectedLabelStyle: AppTextStyles.tabBar,
        unselectedLabelStyle: AppTextStyles.tabBar,
        onTap: (index) {
          // TODO: Implement bottom navigation
          final List<String> pages = [
            'Main',
            'Habits',
            'Statistics',
            'Profile',
          ];

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content:
                  Text('${pages[index]} page will be added in future versions'),
            ),
          );
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Main',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            label: 'Habits',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics),
            label: 'Statistics',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
