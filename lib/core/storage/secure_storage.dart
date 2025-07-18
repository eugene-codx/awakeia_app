import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../logging/app_logger.dart';

/// Secure storage wrapper using flutter_secure_storage 9.2.4
/// Provides encrypted key-value storage for sensitive data
class SecureStorage {
  /// Private constructor
  SecureStorage._internal() {
    _storage = const FlutterSecureStorage(
      aOptions: AndroidOptions(
        encryptedSharedPreferences: true,
      ),
      iOptions: IOSOptions(
        accessibility: KeychainAccessibility.first_unlock_this_device,
      ),
      lOptions: LinuxOptions(),
      wOptions: WindowsOptions(
        useBackwardCompatibility: true,
      ),
      mOptions: MacOsOptions(
        accessibility: KeychainAccessibility.first_unlock_this_device,
      ),
    );
  }

  static SecureStorage? _instance;
  late final FlutterSecureStorage _storage;

  /// Singleton instance
  static SecureStorage get instance => _instance ??= SecureStorage._internal();

  /// Read a value from secure storage
  Future<String?> read({
    required String key,
  }) async {
    try {
      final value = await _storage.read(key: key);
      if (value != null) {
        AppLogger.debug('SecureStorage: Read key [$key] successfully');
      }
      return value;
    } catch (e, stackTrace) {
      AppLogger.error(
        'SecureStorage: Failed to read key [$key]',
        e,
        stackTrace,
      );
      return null;
    }
  }

  /// Write a value to secure storage
  Future<void> write({
    required String key,
    required String value,
  }) async {
    try {
      await _storage.write(key: key, value: value);
      AppLogger.debug('SecureStorage: Written key [$key] successfully');
    } catch (e, stackTrace) {
      AppLogger.error(
        'SecureStorage: Failed to write key [$key]',
        e,
        stackTrace,
      );
      rethrow;
    }
  }

  /// Delete a value from secure storage
  Future<void> delete({
    required String key,
  }) async {
    try {
      await _storage.delete(key: key);
      AppLogger.debug('SecureStorage: Deleted key [$key] successfully');
    } catch (e, stackTrace) {
      AppLogger.error(
        'SecureStorage: Failed to delete key [$key]',
        e,
        stackTrace,
      );
      rethrow;
    }
  }

  /// Delete all values from secure storage
  Future<void> deleteAll() async {
    try {
      await _storage.deleteAll();
      AppLogger.debug('SecureStorage: Deleted all keys successfully');
    } catch (e, stackTrace) {
      AppLogger.error(
        'SecureStorage: Failed to delete all keys',
        e,
        stackTrace,
      );
      rethrow;
    }
  }

  /// Read all values from secure storage
  Future<Map<String, String>> readAll() async {
    try {
      final values = await _storage.readAll();
      AppLogger.debug(
        'SecureStorage: Read all keys successfully (${values.length} items)',
      );
      return values;
    } catch (e, stackTrace) {
      AppLogger.error('SecureStorage: Failed to read all keys', e, stackTrace);
      return {};
    }
  }

  /// Check if a key exists in secure storage
  Future<bool> containsKey({
    required String key,
  }) async {
    try {
      final value = await _storage.read(key: key);
      return value != null;
    } catch (e, stackTrace) {
      AppLogger.error(
        'SecureStorage: Failed to check key [$key]',
        e,
        stackTrace,
      );
      return false;
    }
  }

  /// Clear all authentication-related data
  Future<void> clearAuthData() async {
    try {
      final allKeys = await _storage.readAll();
      final authKeys = allKeys.keys
          .where(
            (key) =>
                key.startsWith('auth_') ||
                key.startsWith('user_') ||
                key.startsWith('token_'),
          )
          .toList();

      for (final key in authKeys) {
        await _storage.delete(key: key);
      }

      AppLogger.debug('SecureStorage: Cleared ${authKeys.length} auth keys');
    } catch (e, stackTrace) {
      AppLogger.error(
        'SecureStorage: Failed to clear auth data',
        e,
        stackTrace,
      );
      rethrow;
    }
  }

  /// Get storage statistics for debugging
  Future<Map<String, dynamic>> getStorageStats() async {
    if (!kDebugMode) return {};

    try {
      final allValues = await _storage.readAll();
      final stats = <String, dynamic>{
        'total_keys': allValues.length,
        'keys': allValues.keys.toList(),
        'key_sizes': <String, int>{},
      };

      for (final entry in allValues.entries) {
        stats['key_sizes'][entry.key] = entry.value.length;
      }

      return stats;
    } catch (e, stackTrace) {
      AppLogger.error(
        'SecureStorage: Failed to get storage stats',
        e,
        stackTrace,
      );
      return {};
    }
  }

  /// Initialize secure storage (for testing purposes)
  Future<void> initialize() async {
    try {
      // Test read/write to ensure storage is working
      const testKey = '_test_key_';
      const testValue = 'test_value';

      await _storage.write(key: testKey, value: testValue);
      final readValue = await _storage.read(key: testKey);
      await _storage.delete(key: testKey);

      if (readValue == testValue) {
        AppLogger.debug('SecureStorage: Initialization successful');
      } else {
        throw Exception('Storage test failed');
      }
    } catch (e, stackTrace) {
      AppLogger.error('SecureStorage: Initialization failed', e, stackTrace);
      rethrow;
    }
  }
}
