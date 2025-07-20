import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/extensions/navigation_extensions.dart';
import '../../../../core/logging/app_logger.dart';
import '../../../../shared/shared.dart';
import '../../../auth/presentation/providers/auth_providers.dart';
import '../providers/home_providers.dart';
import '../widgets/home_widgets.dart';

/// Главный экран приложения с использованием Clean Architecture
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

    // Получаем состояние и действия из view model
    final homeViewModel = ref.watch(homeViewModelProvider);
    final isLoading = ref.watch(homeLoadingProvider);
    final error = ref.watch(homeErrorProvider);
    final selectedTabIndex = ref.watch(selectedTabIndexProvider);

    // Слушаем изменения состояния аутентификации
    ref.listen(authNotifierProvider, (previous, next) {
      next.whenOrNull(
        data: (authState) {
          // Если пользователь стал неаутентифицированным, переходим на первый экран
          if (authState.isUnauthenticated && mounted) {
            AppLogger.info(
                'User became unauthenticated, navigating to first screen',);
            context.goToFirst();
          }
        },
      );
    });

    // Слушаем ошибки home view model
    ref.listen(homeErrorProvider, (previous, current) {
      if (current != null && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(current),
            backgroundColor: AppColors.error,
            action: SnackBarAction(
              label: 'Dismiss',
              textColor: AppColors.primaryText,
              onPressed: () {
                ref.read(clearHomeErrorActionProvider)();
              },
            ),
          ),
        );
      }
    });

    return Scaffold(
      // Кастомный App Bar с обработчиками из view model
      appBar: HomeAppBar(
        title: l10n.appName,
        onProfileTap: () => context.goToProfile(),
        onSettingsTap: () => context.showComingSoon('Settings'),
        onSignOutTap: () => _showSignOutDialog(context),
      ),

      // Основной контент с loading overlay
      body: LoadingOverlay(
        isLoading: isLoading,
        loadingText: l10n.loadingData,
        child: RefreshIndicator(
          onRefresh: () async {
            final refreshAction = ref.read(refreshHomeActionProvider);
            await refreshAction();
          },
          child: HomeContent(
            onCreateHabit: () {
              final createAction = ref.read(createHabitActionProvider);
              createAction();
            },
            onHabitTap: (habitId) {
              final markCompletedAction =
                  ref.read(markHabitCompletedActionProvider);
              markCompletedAction(habitId);
            },
          ),
        ),
      ),

      // Floating Action Button
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final createAction = ref.read(createHabitActionProvider);
          createAction();
        },
        child: const Icon(Icons.add),
      ),

      // Кастомный Bottom Navigation
      bottomNavigationBar: HomeBottomNavigation(
        currentIndex: selectedTabIndex,
        onTap: (index) {
          final changeTabAction = ref.read(changeTabActionProvider);
          changeTabAction(index);
          _handleBottomNavTap(context, index);
        },
      ),
    );
  }

  /// Обработка нажатий на bottom navigation
  void _handleBottomNavTap(BuildContext context, int index) {
    switch (index) {
      case 0:
        // Уже на главной
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

  /// Показать диалог подтверждения выхода
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
      final signOutAction = ref.read(homeSignOutActionProvider);
      await signOutAction();
    }
  }
}
