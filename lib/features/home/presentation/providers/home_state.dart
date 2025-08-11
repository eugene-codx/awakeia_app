import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_state.freezed.dart';

/// State for the home screen
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

  /// Get text for completed habits counter
  String get completedHabitsText => '$todayCompletedHabits/$totalHabitsToday';

  /// Check if there are habits for today
  bool get hasTodayHabits => totalHabitsToday > 0;

  /// Get completion percentage for today
  double get completionPercentage {
    if (totalHabitsToday == 0) return 0.0;
    return todayCompletedHabits / totalHabitsToday;
  }
}
