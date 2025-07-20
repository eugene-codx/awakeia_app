import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../view_models/home_view_model.dart';

/// Провайдер для HomeViewModel
final homeViewModelProvider = ChangeNotifierProvider<HomeViewModel>((ref) {
  return HomeViewModel(ref);
});

/// Провайдер для состояния главного экрана
final homeStateProvider = Provider<HomeState?>((ref) {
  return ref.watch(homeViewModelProvider).state;
});

/// Провайдер для флага загрузки главного экрана
final homeLoadingProvider = Provider<bool>((ref) {
  return ref.watch(homeViewModelProvider).isLoading;
});

/// Провайдер для ошибки главного экрана
final homeErrorProvider = Provider<String?>((ref) {
  return ref.watch(homeViewModelProvider).error;
});

/// Провайдер для индекса выбранной вкладки
final selectedTabIndexProvider = Provider<int>((ref) {
  return ref.watch(homeStateProvider)?.selectedTabIndex ?? 0;
});

/// Провайдер для статистики привычек
final habitsStatsProvider =
    Provider<({int completed, int total, int streak})>((ref) {
  final state = ref.watch(homeStateProvider);
  return (
    completed: state?.todayCompletedHabits ?? 0,
    total: state?.totalHabitsToday ?? 0,
    streak: state?.currentStreak ?? 0,
  );
});

/// Провайдер для проверки наличия привычек
final hasHabitsProvider = Provider<bool>((ref) {
  return ref.watch(homeStateProvider)?.hasHabits ?? false;
});

/// Провайдер для проверки наличия привычек на сегодня
final hasTodayHabitsProvider = Provider<bool>((ref) {
  return ref.watch(homeStateProvider)?.hasTodayHabits ?? false;
});

/// Провайдер для процента выполнения привычек
final completionPercentageProvider = Provider<double>((ref) {
  return ref.watch(homeStateProvider)?.completionPercentage ?? 0.0;
});

/// Провайдер для текста счетчика выполненных привычек
final completedHabitsTextProvider = Provider<String>((ref) {
  return ref.watch(homeStateProvider)?.completedHabitsText ?? '0/0';
});

// ===== Action Providers =====

/// Провайдер для действия изменения вкладки
final changeTabActionProvider = Provider((ref) {
  return (int index) {
    ref.read(homeViewModelProvider).changeTab(index);
  };
});

/// Провайдер для действия обновления данных
final refreshHomeActionProvider = Provider((ref) {
  return () async {
    await ref.read(homeViewModelProvider).refresh();
  };
});

/// Провайдер для действия создания новой привычки
final createHabitActionProvider = Provider((ref) {
  return () async {
    await ref.read(homeViewModelProvider).createNewHabit();
  };
});

/// Провайдер для действия отметки привычки как выполненной
final markHabitCompletedActionProvider = Provider((ref) {
  return (String habitId) async {
    await ref.read(homeViewModelProvider).markHabitCompleted(habitId);
  };
});

/// Провайдер для действия выхода из аккаунта
final homeSignOutActionProvider = Provider((ref) {
  return () async {
    await ref.read(homeViewModelProvider).signOut();
  };
});

/// Провайдер для очистки ошибок
final clearHomeErrorActionProvider = Provider((ref) {
  return () {
    ref.read(homeViewModelProvider).clearError();
  };
});
