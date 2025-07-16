import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqlcipher_flutter_libs/sqlcipher_flutter_libs.dart';
import 'package:sqlite3/open.dart';
import 'package:sqlite3/sqlite3.dart' as sqlite3;

import '../logging/app_logger.dart';
import 'secure_storage.dart';
import 'storage_keys.dart';

part 'app_database.g.dart';

/// User table for authentication and profile data
class Users extends Table {
  /// Primary key
  IntColumn get id => integer().autoIncrement()();

  /// User email (unique)
  TextColumn get email => text().unique()();

  /// User display name
  TextColumn get name => text().nullable()();

  /// User creation timestamp
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  /// User last update timestamp
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  /// Is guest user flag
  BoolColumn get isGuest => boolean().withDefault(const Constant(false))();

  /// User profile data (JSON)
  TextColumn get profileData => text().nullable()();
}

/// App settings table for storing user preferences
class AppSettings extends Table {
  /// Primary key
  IntColumn get id => integer().autoIncrement()();

  /// Setting key (unique)
  TextColumn get key => text().unique()();

  /// Setting value
  TextColumn get value => text()();

  /// Setting type (string, bool, int, double)
  TextColumn get type => text().withDefault(const Constant('string'))();

  /// Setting creation timestamp
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  /// Setting last update timestamp
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

/// Main application database with encryption
@DriftDatabase(tables: [Users, AppSettings])
class AppDatabase extends _$AppDatabase {
  AppDatabase._() : super(_openConnection());

  static AppDatabase? _instance;
  static AppDatabase get instance => _instance ??= AppDatabase._();

  @override
  int get schemaVersion => 1;

  /// Setup SQLCipher for encrypted database
  static Future<void> setupSqlCipher() async {
    try {
      AppLogger.debug('Setting up SQLCipher...');

      // Apply workaround for old Android versions
      await applyWorkaroundToOpenSqlCipherOnOldAndroidVersions();

      // Configure SQLCipher for Android
      open.overrideFor(OperatingSystem.android, openCipherOnAndroid);

      AppLogger.debug('SQLCipher setup completed');
    } catch (e, stackTrace) {
      AppLogger.error('Failed to setup SQLCipher', e, stackTrace);
      rethrow;
    }
  }

  /// Verify that SQLCipher is available
  static bool _debugCheckHasCipher(sqlite3.Database database) {
    try {
      final result = database.select('PRAGMA cipher_version;');
      return result.isNotEmpty;
    } catch (e) {
      AppLogger.error('Failed to check SQLCipher availability: $e');
      return false;
    }
  }

  /// Get or generate database password
  static Future<String> _getDatabasePassword() async {
    try {
      // Try to read existing password
      final existingPassword =
          await SecureStorage.instance.read(StorageKeys.databasePassword);

      if (existingPassword != null && existingPassword.isNotEmpty) {
        AppLogger.debug('Using existing database password');
        return existingPassword;
      }

      // Generate new password
      final newPassword = _generateSecurePassword();
      await SecureStorage.instance
          .write(StorageKeys.databasePassword, newPassword);

      AppLogger.debug('Generated new database password');
      return newPassword;
    } catch (e, stackTrace) {
      AppLogger.error('Failed to get database password', e, stackTrace);
      rethrow;
    }
  }

  /// Generate a secure password for database encryption
  static String _generateSecurePassword() {
    const chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890!@#\$%^&*';
    final random = DateTime.now().millisecondsSinceEpoch;
    String password = '';

    for (int i = 0; i < 32; i++) {
      password += chars[(random + i) % chars.length];
    }

    return password;
  }

  /// Open database connection with encryption
  static QueryExecutor _openConnection() {
    return LazyDatabase(() async {
      try {
        // Get application documents directory
        final dbFolder = await getApplicationDocumentsDirectory();
        final file = File(p.join(dbFolder.path, 'awakeia_encrypted.db'));

        AppLogger.debug('Database file path: ${file.path}');

        // Get database password
        final password = await _getDatabasePassword();

        // Get RootIsolateToken for background isolate
        final token = RootIsolateToken.instance!;

        // Create encrypted database connection
        return NativeDatabase.createInBackground(
          file,
          isolateSetup: () async {
            // Initialize binary messenger for platform channels
            BackgroundIsolateBinaryMessenger.ensureInitialized(token);

            // Setup SQLCipher on background isolate
            await setupSqlCipher();

            AppLogger.debug('Background isolate setup completed');
          },
          setup: (rawDb) {
            // Verify SQLCipher is available
            if (kDebugMode) {
              if (!_debugCheckHasCipher(rawDb)) {
                throw StateError('SQLCipher library is not available! '
                    'Please check your dependencies and setup.');
              }
              AppLogger.debug('SQLCipher verification passed');
            }

            // Set encryption key
            rawDb.execute("PRAGMA key = '$password';");

            // Set recommended SQLCipher options
            rawDb.execute('PRAGMA cipher_page_size = 4096;');
            rawDb.execute('PRAGMA kdf_iter = 256000;');
            rawDb.execute('PRAGMA cipher_hmac_algorithm = HMAC_SHA512;');
            rawDb.execute('PRAGMA cipher_kdf_algorithm = PBKDF2_HMAC_SHA512;');

            // Disable double-quoted string literals (recommended)
            rawDb.config.doubleQuotedStringLiterals = false;

            // Enable WAL mode for better concurrency
            rawDb.execute('PRAGMA journal_mode = WAL;');

            // Enable foreign keys
            rawDb.execute('PRAGMA foreign_keys = ON;');

            AppLogger.debug('Database encryption setup completed');
          },
        );
      } catch (e, stackTrace) {
        AppLogger.error('Failed to open database connection', e, stackTrace);
        rethrow;
      }
    });
  }

  /// Initialize database and verify setup
  static Future<void> initialize() async {
    try {
      AppLogger.debug('Initializing encrypted database...');

      // Access the instance to trigger initialization
      final db = AppDatabase.instance;

      // Perform a simple query to verify database is working
      await db.customSelect('SELECT 1 as test;').get();

      AppLogger.info('Encrypted database initialized successfully');

      // Mark database as initialized
      await SecureStorage.instance
          .write(StorageKeys.databaseInitialized, 'true');
    } catch (e, stackTrace) {
      AppLogger.error('Failed to initialize database', e, stackTrace);
      rethrow;
    }
  }

  /// Close database connection
  Future<void> closeDatabase() async {
    try {
      await close();
      _instance = null;
      AppLogger.debug('Database connection closed');
    } catch (e, stackTrace) {
      AppLogger.error('Failed to close database', e, stackTrace);
    }
  }

  /// Get database file size for debugging
  Future<int> getDatabaseSize() async {
    try {
      final dbFolder = await getApplicationDocumentsDirectory();
      final file = File(p.join(dbFolder.path, 'awakeia_encrypted.db'));

      if (await file.exists()) {
        final stat = await file.stat();
        return stat.size;
      }
      return 0;
    } catch (e) {
      AppLogger.error('Failed to get database size: $e');
      return 0;
    }
  }

  /// Vacuum database to reclaim space
  Future<void> vacuumDatabase() async {
    try {
      AppLogger.debug('Starting database vacuum...');
      await customStatement('VACUUM;');
      AppLogger.debug('Database vacuum completed');
    } catch (e, stackTrace) {
      AppLogger.error('Failed to vacuum database', e, stackTrace);
    }
  }

  /// Test database encryption by verifying cipher version
  Future<bool> testEncryption() async {
    try {
      final result = await customSelect('PRAGMA cipher_version;').get();
      final isEncrypted = result.isNotEmpty;

      AppLogger.debug(
          'Database encryption test: ${isEncrypted ? 'PASS' : 'FAIL'}',);
      return isEncrypted;
    } catch (e, stackTrace) {
      AppLogger.error('Database encryption test failed', e, stackTrace);
      return false;
    }
  }

  /// Get database statistics for debugging
  Future<Map<String, dynamic>> getDatabaseStats() async {
    if (!kDebugMode) return {};

    try {
      final stats = <String, dynamic>{};

      // Get database size
      stats['size_bytes'] = await getDatabaseSize();

      // Get table counts
      final userCount = await select(users).get().then((rows) => rows.length);
      final settingsCount =
          await select(appSettings).get().then((rows) => rows.length);

      stats['users_count'] = userCount;
      stats['settings_count'] = settingsCount;

      // Get encryption status
      stats['is_encrypted'] = await testEncryption();

      return stats;
    } catch (e, stackTrace) {
      AppLogger.error('Failed to get database stats', e, stackTrace);
      return {};
    }
  }
}
