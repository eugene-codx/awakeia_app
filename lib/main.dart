import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/app.dart';
import 'core/logging/app_logger.dart';
import 'core/storage/app_database.dart';
import 'core/storage/secure_storage.dart';

void main() async {
  // Ensure Flutter binding is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize logging system
  AppLogger.instance;
  AppLogger.info('Application starting...');

  try {
    // Initialize secure storage
    await SecureStorage.instance.initialize();
    AppLogger.info('Secure storage initialized');

    // Initialize encrypted database
    await AppDatabase.initialize();
    AppLogger.info('Encrypted database initialized');

    // Run the Flutter application
    runApp(
      const ProviderScope(
        child: AwakeiaApp(),
      ),
    );
  } catch (e, stackTrace) {
    AppLogger.critical('Failed to initialize application', e, stackTrace);

    // Run app with error state if initialization fails
    runApp(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error, size: 64, color: Colors.red),
                const SizedBox(height: 16),
                const Text(
                  'Initialization Error',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  'Failed to initialize the application.\nPlease restart the app.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
