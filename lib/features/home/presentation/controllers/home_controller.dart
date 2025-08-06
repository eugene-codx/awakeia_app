import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../shared/base/base_state_notifier.dart';
import '../../../auth/domain/entities/user_entity.dart';
import '../../../auth/presentation/providers/auth_providers.dart';

part 'home_controller.freezed.dart';

/// Состояние главного экрана
@freezed
abstract class HomeState with _$HomeState {
  const factory HomeState({
    @Default(0) int selectedTabIndex,
    @Default(0) int todayCompletedHabits,
    @Default(0) int totalHabitsToday,
    @Default(0) int currentStreak,
    @Default(false) bool hasHabits,
    @Default(false) bool isLoading,
    String? error,
    @Default(false) bool isRefreshing,
  }) = _HomeState;

  const HomeState._();

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

/// Контроллер для главного экрана (замена HomeViewModel)
class HomeController extends BaseStateNotifier<HomeState> {
  @override
  HomeState build() {
    logAction('Initializing HomeController');

    // Слушаем изменения аутентификации
    _setupAuthListener();

    // Загружаем начальные данные
    Future.microtask(() => _loadInitialData());

    return const HomeState();
  }

  /// Настройка слушателя аутентификации
  void _setupAuthListener() {
    ref.listen(currentUserProvider, (previous, next) {
      _onUserChanged(next);
    });
  }

  /// Обработка изменения пользователя
  void _onUserChanged(UserEntity? user) {
    logAction('User changed: ${user?.id}');

    if (user == null) {
      // Пользователь вышел из системы, очищаем состояние
      state = const HomeState();
    } else {
      // Пользователь вошел в систему, загружаем его данные
      _loadUserData(user);
    }
  }

  /// Загрузка начальных данных
  Future<void> _loadInitialData() async {
    final currentUser = ref.read(currentUserProvider);
    if (currentUser != null) {
      await _loadUserData(currentUser);
    }
  }

  /// Загрузка данных пользователя
  Future<void> _loadUserData(UserEntity user) async {
    logAction('Loading data for user: ${user.id}');

    // Показываем индикатор загрузки только если это не refresh
    if (!state.isRefreshing) {
      state = state.copyWith(isLoading: true, error: null);
    }

    try {
      // TODO: Загрузить привычки пользователя из репозитория
      // Пока используем заглушки
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

      logAction('User data loaded successfully');
    } catch (e, stackTrace) {
      logError('Failed to load user data', e, stackTrace);
      state = state.copyWith(
        isLoading: false,
        isRefreshing: false,
        error: 'Failed to load data: ${e.toString()}',
      );
    }
  }

  /// Изменить выбранную вкладку
  void changeTab(int index) {
    if (index < 0 || index > 3) {
      logError('Invalid tab index: $index');
      return;
    }

    logAction('Changing tab to index: $index');

    if (state.selectedTabIndex != index) {
      state = state.copyWith(selectedTabIndex: index);
    }
  }

  /// Обновить данные экрана
  Future<void> refresh() async {
    logAction('Refreshing home screen data');

    state = state.copyWith(isRefreshing: true, error: null);

    final currentUser = ref.read(currentUserProvider);
    if (currentUser != null) {
      await _loadUserData(currentUser);
    } else {
      state = state.copyWith(isRefreshing: false);
    }
  }

  /// Создать новую привычку
  Future<void> createNewHabit() async {
    logAction('Creating new habit requested');

    // TODO: Навигация к экрану создания привычки
    // Пока показываем временное сообщение
    state = state.copyWith(
      error: 'Creating habits will be added in next versions',
    );

    // Очищаем ошибку через 3 секунды
    Future.delayed(const Duration(seconds: 3), () {
      if (state.error == 'Creating habits will be added in next versions') {
        clearError();
      }
    });
  }

  /// Отметить привычку как выполненную
  Future<void> markHabitCompleted(String habitId) async {
    logAction('Marking habit as completed: $habitId');

    state = state.copyWith(isLoading: true, error: null);

    try {
      // TODO: Реализовать логику отметки привычки
      await Future<void>.delayed(const Duration(milliseconds: 200));

      // Обновляем состояние
      state = state.copyWith(
        todayCompletedHabits: state.todayCompletedHabits + 1,
        isLoading: false,
      );
    } catch (e, stackTrace) {
      logError('Failed to mark habit as completed', e, stackTrace);
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to update habit',
      );
    }
  }

  /// Выйти из аккаунта
  Future<void> signOut() async {
    logAction('Sign out requested');

    state = state.copyWith(isLoading: true, error: null);

    try {
      final signOut = ref.read(signOutActionProvider);
      await signOut();
      // Состояние будет сброшено через _onUserChanged
    } catch (e, stackTrace) {
      logError('Sign out failed', e, stackTrace);
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to sign out',
      );
    }
  }

  /// Очистить ошибку
  void clearError() {
    if (state.error != null) {
      state = state.copyWith(error: null);
    }
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
}

/// Провайдер для HomeController
final homeControllerProvider =
    AutoDisposeNotifierProvider<HomeController, HomeState>(
  HomeController.new,
);

// Convenience providers

/// Состояние загрузки
final homeLoadingProvider = Provider.autoDispose<bool>((ref) {
  return ref.watch(homeControllerProvider).isLoading;
});

/// Ошибка
final homeErrorProvider = Provider.autoDispose<String?>((ref) {
  return ref.watch(homeControllerProvider).error;
});

/// Выбранный индекс вкладки
final selectedTabIndexProvider = Provider.autoDispose<int>((ref) {
  return ref.watch(homeControllerProvider).selectedTabIndex;
});

/// Статистика привычек
final habitsStatsProvider = Provider.autoDispose<
    ({
      int completed,
      int total,
      int streak,
    })>((ref) {
  final state = ref.watch(homeControllerProvider);
  return (
    completed: state.todayCompletedHabits,
    total: state.totalHabitsToday,
    streak: state.currentStreak,
  );
});

/// Есть ли привычки
final hasHabitsProvider = Provider.autoDispose<bool>((ref) {
  return ref.watch(homeControllerProvider).hasHabits;
});

/// Есть ли привычки на сегодня
final hasTodayHabitsProvider = Provider.autoDispose<bool>((ref) {
  return ref.watch(homeControllerProvider).hasTodayHabits;
});

/// Процент выполнения
final completionPercentageProvider = Provider.autoDispose<double>((ref) {
  return ref.watch(homeControllerProvider).completionPercentage;
});

/// Текст счетчика выполненных привычек
final completedHabitsTextProvider = Provider.autoDispose<String>((ref) {
  return ref.watch(homeControllerProvider).completedHabitsText;
});

/// Приветственное сообщение
final welcomeMessageProvider = Provider.autoDispose<String>((ref) {
  final controller = ref.watch(homeControllerProvider.notifier);
  final user = ref.watch(currentUserProvider);
  return controller.getWelcomeMessage(user);
});
