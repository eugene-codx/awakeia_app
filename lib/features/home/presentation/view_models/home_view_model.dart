import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/logging/app_logger.dart';
import '../../../../shared/base/base_view_model.dart';
import '../../../auth/domain/entities/user_entity.dart';
import '../../../auth/presentation/providers/auth_providers.dart';

/// Состояние главного экрана
class HomeState {
  const HomeState({
    this.selectedTabIndex = 0,
    this.todayCompletedHabits = 0,
    this.totalHabitsToday = 0,
    this.currentStreak = 0,
    this.hasHabits = false,
  });

  final int selectedTabIndex;
  final int todayCompletedHabits;
  final int totalHabitsToday;
  final int currentStreak;
  final bool hasHabits;

  HomeState copyWith({
    int? selectedTabIndex,
    int? todayCompletedHabits,
    int? totalHabitsToday,
    int? currentStreak,
    bool? hasHabits,
  }) {
    return HomeState(
      selectedTabIndex: selectedTabIndex ?? this.selectedTabIndex,
      todayCompletedHabits: todayCompletedHabits ?? this.todayCompletedHabits,
      totalHabitsToday: totalHabitsToday ?? this.totalHabitsToday,
      currentStreak: currentStreak ?? this.currentStreak,
      hasHabits: hasHabits ?? this.hasHabits,
    );
  }

  /// Получить текст для счетчика выполненных привычек
  String get completedHabitsText => '$todayCompletedHabits/$totalHabitsToday';

  /// Проверить, есть ли привычки для сегодня
  bool get hasTodayHabits => totalHabitsToday > 0;

  /// Получить процент выполнения за сегодня
  double get completionPercentage {
    if (totalHabitsToday == 0) return 0.0;
    return todayCompletedHabits / totalHabitsToday;
  }
}

/// View Model для главного экрана приложения
class HomeViewModel extends BaseViewModelWithState<HomeState> {
  HomeViewModel(this._ref) {
    _init();
  }

  final Ref _ref;

  @override
  void dispose() {
    AppLogger.debug('HomeViewModel disposed');
    super.dispose();
  }

  /// Инициализация view model
  void _init() {
    AppLogger.debug('HomeViewModel initialized');
    setState(const HomeState());

    // Слушаем изменения аутентификации
    _ref.listen(currentUserProvider, (previous, next) {
      _onUserChanged(next);
    });

    // Загружаем начальные данные
    _loadInitialData();
  }

  /// Обработка изменения пользователя
  void _onUserChanged(UserEntity? user) {
    AppLogger.debug('User changed in HomeViewModel: ${user?.id}');
    if (user == null) {
      // Пользователь вышел из системы, очищаем состояние
      setState(const HomeState());
    } else {
      // Пользователь вошел в систему, загружаем его данные
      _loadUserData(user);
    }
  }

  /// Загрузка начальных данных
  Future<void> _loadInitialData() async {
    await executeWithLoading(() async {
      // Получаем текущего пользователя
      final currentUser = _ref.read(currentUserProvider);
      if (currentUser != null) {
        await _loadUserData(currentUser);
      }
    });
  }

  /// Загрузка данных пользователя
  Future<void> _loadUserData(UserEntity user) async {
    AppLogger.debug('Loading data for user: ${user.id}');

    try {
      // TODO: Загрузить привычки пользователя из репозитория
      // Пока используем заглушки
      await Future<dynamic>.delayed(const Duration(milliseconds: 500));

      setState(state?.copyWith(
        todayCompletedHabits: 0,
        totalHabitsToday: 0,
        currentStreak: 0,
        hasHabits: false,
      ),);

      AppLogger.debug('User data loaded successfully');
    } catch (e, stackTrace) {
      AppLogger.error('Failed to load user data', e, stackTrace);
      setError('Failed to load user data: $e');
    }
  }

  /// Изменить выбранную вкладку в bottom navigation
  void changeTab(int index) {
    AppLogger.debug('Changing tab to index: $index');

    if (state?.selectedTabIndex != index) {
      setState(state?.copyWith(selectedTabIndex: index));
    }
  }

  /// Обновить данные экрана
  Future<void> refresh() async {
    AppLogger.debug('Refreshing home screen data');

    await executeWithLoading(() async {
      final currentUser = _ref.read(currentUserProvider);
      if (currentUser != null) {
        await _loadUserData(currentUser);
      }
    });
  }

  /// Создать новую привычку
  Future<void> createNewHabit() async {
    AppLogger.debug('Creating new habit requested');

    // TODO: Навигация к экрану создания привычки
    // Пока показываем заглушку
    setError('Создание привычек будет добавлено в следующих версиях');

    // Очищаем ошибку через 3 секунды
    Future.delayed(const Duration(seconds: 3), () {
      clearError();
    });
  }

  /// Отметить привычку как выполненную
  Future<void> markHabitCompleted(String habitId) async {
    AppLogger.debug('Marking habit as completed: $habitId');

    await executeWithLoading(() async {
      // TODO: Реализовать логику отметки привычки
      await Future<dynamic>.delayed(const Duration(milliseconds: 200));

      // Обновляем состояние
      final currentState = state;
      if (currentState != null) {
        setState(currentState.copyWith(
          todayCompletedHabits: currentState.todayCompletedHabits + 1,
        ),);
      }
    });
  }

  /// Выйти из аккаунта
  Future<void> signOut() async {
    AppLogger.debug('Sign out requested from HomeViewModel');

    await executeWithLoading(() async {
      final signOut = _ref.read(signOutActionProvider);
      await signOut();
    }, showError: true,);
  }

  /// Получить приветственное сообщение для пользователя
  String getWelcomeMessage(UserEntity? user) {
    if (user == null) return 'Welcome!';

    if (user.isGuest) {
      return 'Welcome, Guest! 👋';
    } else {
      return 'Welcome, ${user.displayName}! 👋';
    }
  }

  /// Проверить, является ли пользователь гостем
  bool get isGuestUser {
    final currentUser = _ref.read(currentUserProvider);
    return currentUser?.isGuest ?? false;
  }

  /// Получить текущего пользователя
  UserEntity? get currentUser => _ref.read(currentUserProvider);
}
