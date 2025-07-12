import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../theme/app_theme.dart';
import 'routes.dart';

class AwakeiaApp extends ConsumerWidget {
  const AwakeiaApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Getting the router configuration from the provider
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: 'Awakeia - Habit Tracker',

      // Setting the application icon
      theme: AppTheme.theme,

      // Connecting the router to the MaterialApp
      routerConfig: router,

      // Turning off the debug banner
      debugShowCheckedModeBanner: false,
    );
  }
}
