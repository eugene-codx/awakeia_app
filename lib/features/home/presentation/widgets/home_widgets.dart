import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/shared.dart';
import '../../../auth/presentation/providers/auth_providers.dart';
import '../providers/home_providers.dart';

/// Custom App Bar for the main screen
class HomeAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const HomeAppBar({
    super.key,
    required this.title,
    this.onProfileTap,
    this.onSettingsTap,
    this.onSignOutTap,
  });

  final String title;
  final VoidCallback? onProfileTap;
  final VoidCallback? onSettingsTap;
  final VoidCallback? onSignOutTap;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBar(
      title: Text(
        title,
        style: AppTextStyles.appBarTitle,
      ),
      centerTitle: true,
      flexibleSpace: Container(
        decoration: AppDecorations.headerGradient,
      ),
      elevation: 0,
      actions: [
        PopupMenuButton<String>(
          icon: const Icon(
            Icons.more_vert,
            color: AppColors.primaryIcon,
          ),
          onSelected: (value) {
            switch (value) {
              case 'profile':
                onProfileTap?.call();
                break;
              case 'settings':
                onSettingsTap?.call();
                break;
              case 'signout':
                onSignOutTap?.call();
                break;
            }
          },
          itemBuilder: (context) => [
            PopupMenuItem(
              value: 'profile',
              child: Row(
                children: [
                  const Icon(Icons.person_outline),
                  const SizedBox(width: 12),
                  Text(context.l10n.profile),
                ],
              ),
            ),
            const PopupMenuItem(
              value: 'settings',
              child: Row(
                children: [
                  Icon(Icons.settings_outlined),
                  SizedBox(width: 12),
                  Text('Settings'),
                ],
              ),
            ),
            const PopupMenuDivider(),
            const PopupMenuItem(
              value: 'signout',
              child: Row(
                children: [
                  Icon(Icons.logout),
                  SizedBox(width: 12),
                  Text('Sign Out'),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// Main content of the home screen
class HomeContent extends ConsumerWidget {
  const HomeContent({
    super.key,
    this.onCreateHabit,
    this.onHabitTap,
  });

  final VoidCallback? onCreateHabit;
  final ValueChanged<String>? onHabitTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final welcomeMessage = ref.watch(welcomeMessageProvider);

    return GradientBackground(
      colors: AppColors.primaryGradient,
      child: SafeArea(
        child: SingleChildScrollView(
          padding: AppSpacing.screenPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome message
              WelcomeMessage(
                title: welcomeMessage,
                subtitle: l10n.readyToCreateHabits,
              ),

              const SizedBox(height: AppSpacing.lg),

              // Warning for guest user
              const _GuestUserPrompt(),

              // Habits section title
              Text(
                l10n.todaysHabits,
                style: AppTextStyles.headline5,
              ),

              const SizedBox(height: AppSpacing.md),

              // Habits section
              Expanded(
                flex: 0,
                child: _HabitsSection(
                  onCreateHabit: onCreateHabit,
                  onHabitTap: onHabitTap,
                ),
              ),

              const SizedBox(height: AppSpacing.md),

              // Statistics section
              const _StatsSection(),
            ],
          ),
        ),
      ),
    );
  }
}

/// Warning for guest user
class _GuestUserPrompt extends ConsumerWidget {
  const _GuestUserPrompt();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isGuest = ref.watch(isGuestUserProvider);

    // Show only for guest users
    if (!isGuest) {
      return const SizedBox.shrink();
    }

    return PrimaryCard(
      padding: AppSpacing.paddingMD,
      child: Row(
        children: [
          Icon(
            Icons.info_outline,
            color: AppColors.info.withValues(alpha: 0.8),
            size: 20,
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'You\'re using a guest account',
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Sign up to save your progress',
                  style: AppTextStyles.caption,
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () {
              // TODO: Navigation to registration
            },
            child: const Text('Sign Up'),
          ),
        ],
      ),
    );
  }
}

/// Habits section
class _HabitsSection extends ConsumerWidget {
  const _HabitsSection({
    this.onCreateHabit,
    this.onHabitTap,
  });

  final VoidCallback? onCreateHabit;
  final ValueChanged<String>? onHabitTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final hasHabits = ref.watch(homeProvider.select((s) => s.hasHabits));

    return PrimaryCard(
      child: hasHabits
          ? _HabitsList(onHabitTap: onHabitTap)
          : EmptyState(
              icon: Icons.self_improvement,
              title: l10n.noHabitsYet,
              subtitle: l10n.createFirstHabit,
              buttonText: l10n.createHabit,
              onButtonPressed: onCreateHabit,
            ),
    );
  }
}

/// Habits list (placeholder for now)
class _HabitsList extends StatelessWidget {
  const _HabitsList({
    this.onHabitTap,
  });

  final ValueChanged<String>? onHabitTap;

  @override
  Widget build(BuildContext context) {
    // TODO: Implement habits list
    return Center(
      child: Padding(
        padding: AppSpacing.paddingLG,
        child: Text(
          'Habits list will be implemented here',
          style: AppTextStyles.bodyMedium,
        ),
      ),
    );
  }
}

/// Statistics section
class _StatsSection extends ConsumerWidget {
  const _StatsSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final homeState = ref.watch(homeProvider);
    final stats = (
      completed: homeState.todayCompletedHabits,
      total: homeState.totalHabitsToday,
      streak: homeState.currentStreak,
    );
    final completedText = homeState.completedHabitsText;

    return Row(
      children: [
        // Days in a row counter
        Expanded(
          child: StatsCard(
            icon: Icons.local_fire_department,
            value: stats.streak.toString(),
            label: l10n.daysInARow,
            iconColor: AppColors.warning,
          ),
        ),

        const SizedBox(width: AppSpacing.md),

        // Completed today
        Expanded(
          child: StatsCard(
            icon: Icons.check_circle,
            value: completedText,
            label: l10n.completed,
            iconColor: AppColors.success,
          ),
        ),
      ],
    );
  }
}

/// Custom bottom navigation for the home screen
class HomeBottomNavigation extends StatelessWidget {
  const HomeBottomNavigation({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: AppColors.darkPurple,
      selectedItemColor: AppColors.primaryText,
      unselectedItemColor: AppColors.secondaryIcon,
      currentIndex: currentIndex,
      selectedLabelStyle: AppTextStyles.tabBar,
      unselectedLabelStyle: AppTextStyles.tabBar,
      onTap: onTap,
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
    );
  }
}
