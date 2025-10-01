import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/extensions/navigation_extensions.dart';
import '../../../../core/logging/app_logger.dart';
import '../../../../shared/shared.dart';
import '../../../auth/presentation/providers/auth_providers.dart';
import '../providers/home_providers.dart';
import '../widgets/home_widgets.dart';

/// Main application screen using Clean Architecture
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
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

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    // Get state from provider
    final isLoading = ref.watch(homeProvider.select((s) => s.isLoading));
    final selectedTabIndex =
        ref.watch(homeProvider.select((s) => s.selectedTabIndex));

    // Listen to authentication state changes
    ref.listen(authProvider, (previous, next) {
      next.whenOrNull(
        data: (authState) {
          // If user became unauthenticated, navigate to first screen
          if (authState.isUnauthenticated && mounted) {
            AppLogger.info(
              'User became unauthenticated, navigating to first screen',
            );
            context.goToFirst();
          }
        },
      );
    });

    // Listen to home provider errors
    ref.listen(homeProvider.select((s) => s.error), (previous, current) {
      if (current != null && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(current),
            backgroundColor: AppColors.error,
            action: SnackBarAction(
              label: 'Dismiss',
              textColor: AppColors.primaryText,
              onPressed: () {
                ref.read(homeProvider.notifier).clearError();
              },
            ),
          ),
        );
      }
    });

    return Scaffold(
      // Custom App Bar with handlers from view model
      appBar: HomeAppBar(
        title: l10n.appName,
        onProfileTap: () => context.goToProfile(),
        onSettingsTap: () => context.showComingSoon('Settings'),
        onSignOutTap: () => _showSignOutDialog(context),
      ),

      // Main content with loading overlay
      body: LoadingOverlay(
        isLoading: isLoading,
        loadingText: l10n.loadingData,
        child: RefreshIndicator(
          onRefresh: () async {
            await ref.read(homeProvider.notifier).refresh();
          },
          child: HomeContent(
            onCreateHabit: () {
              ref.read(homeProvider.notifier).createNewHabit();
            },
            onHabitTap: (habitId) {
              ref.read(homeProvider.notifier).markHabitCompleted(habitId);
            },
          ),
        ),
      ),

      // Floating Action Button
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(homeProvider.notifier).createNewHabit();
        },
        child: const Icon(Icons.add),
      ),

      // Custom Bottom Navigation
      bottomNavigationBar: HomeBottomNavigation(
        currentIndex: selectedTabIndex,
        onTap: (index) {
          ref.read(homeProvider.notifier).changeTab(index);
          _handleBottomNavTap(context, index);
        },
      ),
    );
  }

  /// Handle bottom navigation taps
  void _handleBottomNavTap(BuildContext context, int index) {
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

  /// Show sign out confirmation dialog
  Future<void> _showSignOutDialog(BuildContext context) async {
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

    if (shouldSignOut == true && mounted) {
      await ref.read(homeProvider.notifier).signOut();
    }
  }
}
