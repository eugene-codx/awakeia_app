import '../../../../core/logging/app_logger.dart';
import '../../../../shared/base/base_state_notifier.dart';
import '../../../auth/domain/entities/user_entity.dart';
import '../../../auth/presentation/providers/auth_providers.dart';
import '../../../onboarding/application/onboarding_notifier.dart';
import 'home_state.dart';

class HomeNotifier extends BaseStateNotifier<HomeState> {
  @override
  HomeState build() {
    AppLogger.info('HomeNotifier.build: Initializing');

    // Listen to auth changes
    _setupAuthListener();

    // Load initial data
    Future.microtask(() => _loadInitialData());

    return const HomeState();
  }

  /// Setup authentication listener
  void _setupAuthListener() {
    ref.listen(currentUserProvider, (previous, next) {
      _onUserChanged(next);
    });
  }

  /// Handle user change
  void _onUserChanged(UserEntity? user) {
    logAction('HomeNotifier._onUserChanged: User changed: ${user?.publicId}');

    if (user == null) {
      // User logged out, clear state
      state = const HomeState();
    } else {
      // User logged in, load their data
      _loadUserData(user);
    }
  }

  /// Load initial data
  Future<void> _loadInitialData() async {
    final currentUser = ref.read(currentUserProvider);
    if (currentUser != null) {
      await _loadUserData(currentUser);
    }
  }

  /// Load user data
  Future<void> _loadUserData(UserEntity user) async {
    logAction(
      'HomeNotifier._loadUserData: Loading data for user: ${user.publicId}',
    );

    // Show loading indicator only if not refreshing
    if (!state.isRefreshing) {
      state = state.copyWith(isLoading: true, error: null);
    }

    try {
      // TODO: Load user habits from repository
      // Using stubs for now
      await Future<void>.delayed(const Duration(milliseconds: 500));

      state = state.copyWith(
        todayCompletedHabits: 0,
        totalHabitsToday: 0,
        currentStreak: 0,
        hasHabits: false,
        isLoading: false,
        isRefreshing: false,
        error: null,
      );

      logAction('HomeNotifier._loadUserData: User data loaded successfully');
    } catch (e, stackTrace) {
      logError(
        'HomeNotifier._loadUserData: Failed to load user data',
        e,
        stackTrace,
      );
      state = state.copyWith(
        isLoading: false,
        isRefreshing: false,
        error: 'Failed to load data: ${e.toString()}',
      );
    }
  }

  /// Change selected tab
  void changeTab(int index) {
    if (index < 0 || index > 3) {
      logError('HomeNotifier.changeTab: Invalid tab index: $index');
      return;
    }

    logAction('HomeNotifier.changeTab: Changing tab to index: $index');

    if (state.selectedTabIndex != index) {
      state = state.copyWith(selectedTabIndex: index);
    }
  }

  /// Refresh screen data
  Future<void> refresh() async {
    logAction('HomeNotifier.refresh: Refreshing home screen data');

    state = state.copyWith(isRefreshing: true, error: null);

    final currentUser = ref.read(currentUserProvider);
    if (currentUser != null) {
      await _loadUserData(currentUser);
    } else {
      state = state.copyWith(isRefreshing: false);
    }
  }

  /// Create new habit
  Future<void> createNewHabit() async {
    logAction('HomeNotifier.createNewHabit: Creating new habit requested');

    // TODO: Navigate to habit creation screen
    // Show temporary message for now
    state = state.copyWith(
      error: 'Creating habits will be added in next versions',
    );

    // Clear error after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      if (state.error == 'Creating habits will be added in next versions') {
        clearError();
      }
    });
  }

  /// Mark habit as completed
  Future<void> markHabitCompleted(String habitId) async {
    logAction(
      'HomeNotifier.markHabitCompleted: Marking habit as completed: $habitId',
    );

    state = state.copyWith(isLoading: true, error: null);

    try {
      // TODO: Implement habit completion logic
      await Future<void>.delayed(const Duration(milliseconds: 200));

      // Update state
      state = state.copyWith(
        todayCompletedHabits: state.todayCompletedHabits + 1,
        isLoading: false,
      );
    } catch (e, stackTrace) {
      logError(
        'HomeNotifier.markHabitCompleted: Failed to mark habit as completed',
        e,
        stackTrace,
      );
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to update habit',
      );
    }
  }

  /// Sign out
  Future<void> signOut() async {
    logAction('HomeNotifier.signOut: Sign out requested');

    state = state.copyWith(isLoading: true, error: null);

    try {
      // Call auth notifier directly instead of using action provider
      final authNotifier = ref.read(authProvider.notifier);
      await authNotifier.signOut();
      final notifier = ref.read(onboardingNotifierProvider.notifier);
      await notifier.reset();

      // State will be reset via _onUserChanged
    } catch (e, stackTrace) {
      logError('HomeNotifier.signOut: Sign out failed', e, stackTrace);
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to sign out',
      );
    }
  }

  /// Clear error
  void clearError() {
    if (state.error != null) {
      logAction('HomeNotifier.clearError: Clearing error');
      state = state.copyWith(error: null);
    }
  }

  /// Get welcome message for user
  String getWelcomeMessage(UserEntity? user) {
    if (user == null) return 'Welcome!';

    if (user.isGuest) {
      return 'Welcome, Guest! 👋';
    } else {
      return 'Welcome, ${user.displayName}! 👋';
    }
  }
}
