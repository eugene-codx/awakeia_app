/// Storage keys for secure storage
/// Centralized place for all storage key constants
class StorageKeys {
  // Private constructor to prevent instantiation
  StorageKeys._();

  // Authentication keys
  static const String accessToken = 'access_token';
  static const String refreshToken = 'refresh_token';
  static const String tokenExpiryIn = 'expires_in';
  static const String isLoggedIn = 'auth_is_logged_in';
  static const String loginType =
      'auth_login_type'; // email, google, facebook, etc.
  static const String lastLoginTime = 'auth_last_login_time';

  // User data keys
  static const String userId = 'user_id';
  static const String userEmail = 'user_email';
  static const String userName = 'user_name';
  static const String userProfile = 'user_profile_json';
  static const String isGuest = 'user_is_guest';
  static const String userPreferences = 'user_preferences_json';

  // App settings keys
  static const String appLanguage = 'app_language';
  static const String appTheme = 'app_theme';
  static const String firstRun = 'app_first_run';
  static const String onboardingCompleted = 'app_onboarding_completed';
  static const String appVersion = 'app_version';
  static const String lastUpdateCheck = 'app_last_update_check';

  // Security keys
  static const String biometricsEnabled = 'security_biometrics_enabled';
  static const String pinEnabled = 'security_pin_enabled';
  static const String pinHash = 'security_pin_hash';
  static const String autoLockEnabled = 'security_auto_lock_enabled';
  static const String autoLockDuration = 'security_auto_lock_duration';
  static const String lastActiveTime = 'security_last_active_time';

  // Database keys
  static const String databasePassword = 'database_password';
  static const String databaseVersion = 'database_version';
  static const String databaseInitialized = 'database_initialized';
  static const String lastDatabaseBackup = 'database_last_backup';

  // Feature flags and experiments
  static const String featureFlags = 'feature_flags_json';
  static const String experimentsEnabled = 'experiments_enabled';
  static const String betaFeatures = 'beta_features_json';

  // Habits-related keys (for future implementation)
  static const String habitsData = 'habits_data_json';
  static const String habitsSettings = 'habits_settings_json';
  static const String habitsReminders = 'habits_reminders_json';
  static const String habitsStats = 'habits_stats_json';

  // Notifications keys
  static const String notificationsEnabled = 'notifications_enabled';
  static const String notificationToken = 'notification_token';
  static const String notificationSettings = 'notification_settings_json';
  static const String lastNotificationTime = 'notification_last_time';

  // Cache keys
  static const String cacheLastCleared = 'cache_last_cleared';
  static const String cacheSize = 'cache_size';
  static const String cacheSettings = 'cache_settings_json';

  // Sync keys
  static const String syncEnabled = 'sync_enabled';
  static const String lastSyncTime = 'sync_last_time';
  static const String syncSettings = 'sync_settings_json';
  static const String syncStatus = 'sync_status';

  // Development and debug keys
  static const String debugMode = 'debug_mode';
  static const String debugLogs = 'debug_logs_json';
  static const String mockData = 'mock_data_enabled';

  /// Get all authentication-related keys
  static List<String> get authKeys => [
        accessToken,
        refreshToken,
        tokenExpiryIn,
        isLoggedIn,
        loginType,
        lastLoginTime,
      ];

  /// Get all user-related keys
  static List<String> get userKeys => [
        userId,
        userEmail,
        userName,
        userProfile,
        isGuest,
        userPreferences,
      ];

  /// Get all security-related keys
  static List<String> get securityKeys => [
        biometricsEnabled,
        pinEnabled,
        pinHash,
        autoLockEnabled,
        autoLockDuration,
        lastActiveTime,
      ];

  /// Get all database-related keys
  static List<String> get databaseKeys => [
        databasePassword,
        databaseVersion,
        databaseInitialized,
        lastDatabaseBackup,
      ];

  /// Get all app settings keys
  static List<String> get appSettingsKeys => [
        appLanguage,
        appTheme,
        firstRun,
        onboardingCompleted,
        appVersion,
        lastUpdateCheck,
      ];

  /// Get all sensitive keys that should be handled with extra care
  static List<String> get sensitiveKeys => [
        accessToken,
        refreshToken,
        pinHash,
        databasePassword,
        notificationToken,
      ];

  /// Check if a key is authentication-related
  static bool isAuthKey(String key) => authKeys.contains(key);

  /// Check if a key is user-related
  static bool isUserKey(String key) => userKeys.contains(key);

  /// Check if a key is security-related
  static bool isSecurityKey(String key) => securityKeys.contains(key);

  /// Check if a key is sensitive
  static bool isSensitiveKey(String key) => sensitiveKeys.contains(key);

  /// Get key description for debugging
  static String getKeyDescription(String key) {
    switch (key) {
      case accessToken:
        return 'Authentication token for API access';
      case refreshToken:
        return 'Refresh token for token renewal';
      case userId:
        return 'Unique user identifier';
      case userEmail:
        return 'User email address';
      case userName:
        return 'User display name';
      case databasePassword:
        return 'Database encryption password';
      case biometricsEnabled:
        return 'Biometric authentication enabled flag';
      case appLanguage:
        return 'Application language setting';
      case appTheme:
        return 'Application theme setting';
      default:
        return 'Storage key: $key';
    }
  }
}
