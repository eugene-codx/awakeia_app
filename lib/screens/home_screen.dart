import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../app/extensions/navigation_extensions.dart';
import '../core/logging/app_logger.dart';
import '../features/auth/presentation/providers/auth_providers.dart';
import '../shared/shared.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    AppLogger.info('HomeScreen initialized');
  }

  @override
  void dispose() {
    AppLogger.info('HomeScreen disposed');
    super.dispose();
  }

  void _onBottomNavTap(int index) {
    setState(() => _selectedIndex = index);

    // Navigate based on selected index
    switch (index) {
      case 0:
        // Already on home
        break;
      case 1:
        context.goToHabits();
        break;
      case 2:
        context.goToStatistics();
        break;
      case 3:
        context.goToProfile();
        break;
    }
  }

  Future<void> _handleSignOut() async {
    // Show confirmation dialog
    final shouldSignOut = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sign Out'),
        content: const Text('Are you sure you want to sign out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Sign Out'),
          ),
        ],
      ),
    );

    if (shouldSignOut == true) {
      final signOut = ref.read(signOutActionProvider);
      await signOut();

      if (mounted) {
        context.goToFirst();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get localization instance
    final l10n = context.l10n;

    // Get current user from new auth system
    final currentUser = ref.watch(currentUserProvider);
    final isLoading = ref.watch(isAuthLoadingProvider);

    // Listen for auth state changes
    ref.listen(authNotifierProvider, (previous, next) {
      next.whenOrNull(
        data: (authState) {
          // If user becomes unauthenticated, navigate to first screen
          if (authState.isUnauthenticated && mounted) {
            AppLogger.info(
              'User became unauthenticated, navigating to first screen',
            );
            context.goToFirst();
          }
        },
      );
    });

    return Scaffold(
      // App bar with gradient
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
          // Profile/Settings menu
          PopupMenuButton<String>(
            icon: const Icon(
              Icons.more_vert,
              color: AppColors.primaryIcon,
            ),
            onSelected: (value) async {
              switch (value) {
                case 'profile':
                  context.goToProfile();
                  break;
                case 'settings':
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Settings coming soon')),
                  );
                  break;
                case 'signout':
                  await _handleSignOut();
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
                    Text(l10n.profile),
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
      ),

      // Main content with loading overlay
      body: LoadingOverlay(
        isLoading: isLoading,
        loadingText: l10n.loadingData,
        child: GradientBackground(
          colors: AppColors.primaryGradient,
          child: SafeArea(
            child: Padding(
              padding: AppSpacing.screenPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Welcome message
                  WelcomeMessage(
                    title: currentUser?.isGuest == true
                        ? l10n.welcomeGuest
                        : l10n.welcomeUser(currentUser?.displayName ?? 'User'),
                    subtitle: l10n.readyToCreateHabits,
                  ),

                  const SizedBox(height: AppSpacing.lg),

                  // Guest user prompt
                  if (currentUser?.isGuest == true) ...[
                    PrimaryCard(
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
                            onPressed: () => context.goToRegister(),
                            child: const Text('Sign Up'),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                  ],

                  // Section title
                  Text(
                    l10n.todaysHabits,
                    style: AppTextStyles.headline5,
                  ),

                  const SizedBox(height: AppSpacing.md),

                  // Habits section
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

                  // Quick stats row
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

      // Floating action button
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

      // Bottom navigation bar
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.darkPurple,
        selectedItemColor: AppColors.primaryText,
        unselectedItemColor: AppColors.secondaryIcon,
        currentIndex: _selectedIndex,
        selectedLabelStyle: AppTextStyles.tabBar,
        unselectedLabelStyle: AppTextStyles.tabBar,
        onTap: _onBottomNavTap,
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
