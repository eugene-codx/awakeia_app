import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'home_notifier.dart';
import 'home_state.dart';

/// Provider for managing home screen state

/// Main provider for home screen
final homeProvider = AutoDisposeNotifierProvider<HomeNotifier, HomeState>(
  HomeNotifier.new,
);
