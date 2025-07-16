import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/app.dart';
import 'core/logging/app_logger.dart';

void main() {
  // Initialize logging system
  AppLogger.instance;
  AppLogger.info('Application starting...');
  // Starts the Flutter application, covering it with ProviderScope
  // to enable state management with Riverpod.
  runApp(
    const ProviderScope(
      child: AwakeiaApp(),
    ),
  );
}
