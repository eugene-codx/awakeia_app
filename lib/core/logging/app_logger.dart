import 'package:flutter/foundation.dart';
import 'package:talker/talker.dart';

/// Centralized logging system using Talker 4.9.2
/// Provides consistent logging across the entire application
class AppLogger {

  /// Private constructor
  AppLogger._internal() {
    _talker = Talker(
      settings: TalkerSettings(
        enabled: true,
        useHistory: true,
        maxHistoryItems: 1000,
        useConsoleLogs: kDebugMode,
        colors: {
          TalkerLogType.error.key: AnsiPen()..red(),
          TalkerLogType.critical.key: AnsiPen()..magenta(),
          TalkerLogType.info.key: AnsiPen()..blue(),
          TalkerLogType.warning.key: AnsiPen()..yellow(),
          TalkerLogType.debug.key: AnsiPen()..green(),
          TalkerLogType.verbose.key: AnsiPen()..cyan(),
          NetworkLog.getKey: AnsiPen()..xterm(208), // Orange for network
          AuthLog.getKey: AnsiPen()..xterm(165), // Purple for auth
        },
        titles: {
          TalkerLogType.error.key: 'ERROR',
          TalkerLogType.critical.key: 'CRITICAL',
          TalkerLogType.info.key: 'INFO',
          TalkerLogType.warning.key: 'WARNING',
          TalkerLogType.debug.key: 'DEBUG',
          TalkerLogType.verbose.key: 'VERBOSE',
          NetworkLog.getKey: 'NETWORK',
          AuthLog.getKey: 'AUTH',
        },
      ),
      logger: TalkerLogger(
        settings: TalkerLoggerSettings(
          enableColors: kDebugMode,
          maxLineWidth: 120,
          lineSymbol: '─',
        ),
      ),
    );
  }
  static AppLogger? _instance;
  late final Talker _talker;

  /// Singleton instance
  static AppLogger get instance => _instance ??= AppLogger._internal();

  /// Get the Talker instance for advanced usage
  Talker get talker => _talker;

  // Standard logging methods

  /// Log debug messages (only in debug mode)
  static void debug(String message) {
    if (kDebugMode) {
      instance._talker.debug(message);
    }
  }

  /// Log info messages
  static void info(String message) {
    instance._talker.info(message);
  }

  /// Log warning messages
  static void warning(String message) {
    instance._talker.warning(message);
  }

  /// Log error messages
  static void error(String message, [Object? error, StackTrace? stackTrace]) {
    if (error != null && stackTrace != null) {
      instance._talker.handle(error, stackTrace, message);
    } else {
      instance._talker.error(message);
    }
  }

  /// Log critical messages
  static void critical(String message,
      [Object? error, StackTrace? stackTrace,]) {
    if (error != null && stackTrace != null) {
      instance._talker.handle(error, stackTrace, message);
    } else {
      instance._talker.critical(message);
    }
  }

  /// Log verbose messages (only in debug mode)
  static void verbose(String message) {
    if (kDebugMode) {
      instance._talker.verbose(message);
    }
  }

  // Custom logging methods for specific domains

  /// Log network-related messages
  static void network(String message) {
    instance._talker.logCustom(NetworkLog(message));
  }

  /// Log authentication-related messages
  static void auth(String message) {
    instance._talker.logCustom(AuthLog(message));
  }

  /// Log app lifecycle events
  static void lifecycle(String message) {
    instance._talker.logCustom(LifecycleLog(message));
  }

  /// Log navigation events
  static void navigation(String message) {
    instance._talker.logCustom(NavigationLog(message));
  }

  /// Log performance metrics
  static void performance(String message) {
    instance._talker.logCustom(PerformanceLog(message));
  }

  /// Clear all logs
  static void clearLogs() {
    instance._talker.cleanHistory();
  }

  /// Get formatted log history
  static List<String> getLogHistory() {
    return instance._talker.history
        .map((log) => log.generateTextMessage())
        .toList();
  }

  /// Handle exceptions with context
  static void handleException(
    Object exception,
    StackTrace stackTrace, [
    String? context,
  ]) {
    final message =
        context != null ? '$context: $exception' : exception.toString();
    instance._talker.handle(exception, stackTrace, message);
  }
}

/// Custom log for network operations
class NetworkLog extends TalkerLog {
  NetworkLog(String super.message);

  /// Log title
  static String get getTitle => 'NETWORK';

  /// Log key
  static String get getKey => 'network_log';

  /// Log color
  static AnsiPen get getPen => AnsiPen()..xterm(208);

  @override
  String get title => getTitle;

  @override
  String get key => getKey;

  @override
  AnsiPen get pen => getPen;
}

/// Custom log for authentication operations
class AuthLog extends TalkerLog {
  AuthLog(String super.message);

  /// Log title
  static String get getTitle => 'AUTH';

  /// Log key
  static String get getKey => 'auth_log';

  /// Log color
  static AnsiPen get getPen => AnsiPen()..xterm(165);

  @override
  String get title => getTitle;

  @override
  String get key => getKey;

  @override
  AnsiPen get pen => getPen;
}

/// Custom log for app lifecycle events
class LifecycleLog extends TalkerLog {
  LifecycleLog(String super.message);

  /// Log title
  static String get getTitle => 'LIFECYCLE';

  /// Log key
  static String get getKey => 'lifecycle_log';

  /// Log color
  static AnsiPen get getPen => AnsiPen()..xterm(46);

  @override
  String get title => getTitle;

  @override
  String get key => getKey;

  @override
  AnsiPen get pen => getPen;
}

/// Custom log for navigation events
class NavigationLog extends TalkerLog {
  NavigationLog(String super.message);

  /// Log title
  static String get getTitle => 'NAVIGATION';

  /// Log key
  static String get getKey => 'navigation_log';

  /// Log color
  static AnsiPen get getPen => AnsiPen()..xterm(81);

  @override
  String get title => getTitle;

  @override
  String get key => getKey;

  @override
  AnsiPen get pen => getPen;
}

/// Custom log for performance metrics
class PerformanceLog extends TalkerLog {
  PerformanceLog(String super.message);

  /// Log title
  static String get getTitle => 'PERFORMANCE';

  /// Log key
  static String get getKey => 'performance_log';

  /// Log color
  static AnsiPen get getPen => AnsiPen()..xterm(226);

  @override
  String get title => getTitle;

  @override
  String get key => getKey;

  @override
  AnsiPen get pen => getPen;
}
