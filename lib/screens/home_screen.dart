import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/auth_provider.dart';
import '../theme/app_colors.dart';
import '../theme/app_decorations.dart';
import '../theme/app_text_styles.dart';
import '../utils/localization_helper.dart';
import '../widgets/common_widgets.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Get localization instance
    final l10n = context.l10n;

    // Get current user from auth provider
    final currentUser = ref.watch(currentUserProvider);
    final isAuthLoading = ref.watch(isAuthLoadingProvider);

    return Scaffold(
      // App bar with gradient using centralized decoration
      appBar: AppBar(
        title: Text(
          l10n.appName,
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
                SnackBar(
                  content: Text(l10n.profileComingSoon),
                ),
              );
            },
          ),
        ],
      ),

      // Main content with loading overlay
      body: LoadingOverlay(
        isLoading: isAuthLoading,
        loadingText: l10n.loadingData,
        child: GradientBackground(
          colors: AppColors.primaryGradient,
          child: SafeArea(
            child: Padding(
              padding: AppSpacing.screenPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Welcome message using localized text with user name
                  WelcomeMessage(
                    title: currentUser?.isGuest == true
                        ? l10n.welcomeGuest
                        : l10n.welcomeUser(currentUser?.name ?? 'User'),
                    subtitle: l10n.readyToCreateHabits,
                  ),

                  const SizedBox(height: AppSpacing.lg),

                  // Section title using localized text
                  Text(
                    l10n.todaysHabits,
                    style: AppTextStyles.headline5,
                  ),

                  const SizedBox(height: AppSpacing.md),

                  // Habits section - using EmptyState widget with localized text
                  Expanded(
                    child: PrimaryCard(
                      child: EmptyState(
                        icon: Icons.self_improvement,
                        title: l10n.noHabitsYet,
                        subtitle: l10n.createFirstHabit,
                        buttonText: l10n.createHabit,
                        onButtonPressed: () {
                          // TODO: Navigate to add habit screen
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(l10n.habitsComingSoon),
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                  const SizedBox(height: AppSpacing.md),

                  // Quick stats row using StatsCard widgets with localized text
                  Row(
                    children: [
                      // Streak counter
                      Expanded(
                        child: StatsCard(
                          icon: Icons.local_fire_department,
                          value: '0',
                          label: l10n.daysInARow,
                          iconColor: AppColors.warning,
                        ),
                      ),

                      const SizedBox(width: AppSpacing.md),

                      // Completed today
                      Expanded(
                        child: StatsCard(
                          icon: Icons.check_circle,
                          value: '0/0',
                          label: l10n.completed,
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
            SnackBar(
              content: Text(l10n.habitsComingSoon),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),

      // Bottom navigation bar with localized text
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
            l10n.home,
            l10n.habits,
            l10n.statistics,
            l10n.profile,
          ];

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(l10n.mainWillBeAdded(pages[index])),
            ),
          );
        },
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: l10n.home,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.list_alt),
            label: l10n.habits,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.analytics),
            label: l10n.statistics,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person),
            label: l10n.profile,
          ),
        ],
      ),
    );
  }
}
