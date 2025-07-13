import 'package:flutter/material.dart';

import '../generated/app_localizations.dart';

// Helper class for easy access to localizations throughout the app
// This provides a convenient way to access translations without context
class LocalizationHelper {
  // Private constructor to prevent instantiation
  LocalizationHelper._();

  // Current context for localization
  static BuildContext? _context;

  // Initialize the helper with context
  static void init(BuildContext context) {
    _context = context;
  }

  // Get current AppLocalizations instance
  static AppLocalizations get current {
    if (_context == null) {
      throw Exception(
          'LocalizationHelper not initialized. Call LocalizationHelper.init(context) first.');
    }
    return AppLocalizations.of(_context!)!;
  }

  // Convenient getter for common use
  static AppLocalizations of(BuildContext context) {
    return AppLocalizations.of(context)!;
  }

  // Check if locale is RTL (Right-to-Left)
  static bool isRTL(BuildContext context) {
    final locale = Localizations.localeOf(context);
    // Add RTL languages here if needed (Arabic, Hebrew, etc.)
    const rtlLanguages = ['ar', 'he', 'fa', 'ur'];
    return rtlLanguages.contains(locale.languageCode);
  }

  // Get current locale
  static Locale getCurrentLocale(BuildContext context) {
    return Localizations.localeOf(context);
  }

  // Get current language code
  static String getCurrentLanguageCode(BuildContext context) {
    return Localizations.localeOf(context).languageCode;
  }

  // Check if current language is specific language
  static bool isCurrentLanguage(BuildContext context, String languageCode) {
    return getCurrentLanguageCode(context) == languageCode;
  }

  // Format messages with parameters
  static String formatMessage(String message, Map<String, String> params) {
    String result = message;
    params.forEach((key, value) {
      result = result.replaceAll('{$key}', value);
    });
    return result;
  }
}

// Extension on BuildContext for easier access to localizations
extension LocalizationExtension on BuildContext {
  // Quick access to AppLocalizations
  AppLocalizations get l10n => AppLocalizations.of(this)!;

  // Quick access to locale
  Locale get locale => Localizations.localeOf(this);

  // Quick access to language code
  String get languageCode => locale.languageCode;

  // Check if RTL
  bool get isRTL => LocalizationHelper.isRTL(this);
}

// Global function for accessing localizations (use sparingly)
AppLocalizations l10n(BuildContext context) => AppLocalizations.of(context)!;
