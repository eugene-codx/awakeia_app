import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth/presentation/providers/auth_providers.dart';
import 'home_notifier.dart';
import 'home_state.dart';

/// Provider for managing home screen state

/// Main provider for home screen
final homeProvider = AutoDisposeNotifierProvider<HomeNotifier, HomeState>(
  HomeNotifier.new,
);

/// Welcome message provider (useful for reusability)
final welcomeMessageProvider = Provider.autoDispose<String>((ref) {
  final notifier = ref.watch(homeProvider.notifier);
  final user = ref.watch(currentUserProvider);
  return notifier.getWelcomeMessage(user);
});
