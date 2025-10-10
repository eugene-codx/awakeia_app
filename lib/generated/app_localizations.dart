import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ru.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ru'),
  ];

  /// The title of the application
  ///
  /// In en, this message translates to:
  /// **'Awakeia - Habit Tracker'**
  String get appTitle;

  /// Short app name
  ///
  /// In en, this message translates to:
  /// **'Awakeia'**
  String get appName;

  /// App subtitle shown on first screen
  ///
  /// In en, this message translates to:
  /// **'Your personal habit tracker'**
  String get appSubtitle;

  /// Back button text
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// Home navigation item
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// Habits navigation item
  ///
  /// In en, this message translates to:
  /// **'Habits'**
  String get habits;

  /// Statistics navigation item
  ///
  /// In en, this message translates to:
  /// **'Statistics'**
  String get statistics;

  /// Profile navigation item
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// Welcome message
  ///
  /// In en, this message translates to:
  /// **'Welcome!'**
  String get welcome;

  /// Subtitle on login screen
  ///
  /// In en, this message translates to:
  /// **'Nice to see you!'**
  String get niceToSeeYou;

  /// Create account title
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get createAccount;

  /// Subtitle on register screen
  ///
  /// In en, this message translates to:
  /// **'Start your journey to a better version of yourself!'**
  String get startYourJourney;

  /// Login button text
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get login;

  /// Register button text
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get register;

  /// Continue as guest button
  ///
  /// In en, this message translates to:
  /// **'Continue as guest'**
  String get continueAsGuest;

  /// Username field placeholder
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get username;

  /// First name field placeholder
  ///
  /// In en, this message translates to:
  /// **'First name'**
  String get firstName;

  /// Email field placeholder
  ///
  /// In en, this message translates to:
  /// **'Email address'**
  String get emailAddress;

  /// Password field placeholder
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// Confirm password field placeholder
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get confirmPassword;

  /// Forgot password link
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get forgotPassword;

  /// Email required validation message
  ///
  /// In en, this message translates to:
  /// **'Please enter your email'**
  String get emailRequired;

  /// Invalid email validation message
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email'**
  String get emailInvalid;

  /// Password required validation message
  ///
  /// In en, this message translates to:
  /// **'Please enter your password'**
  String get passwordRequired;

  /// Password too short validation message
  ///
  /// In en, this message translates to:
  /// **'Password must contain at least 6 characters'**
  String get passwordTooShort;

  /// Confirm password required validation message
  ///
  /// In en, this message translates to:
  /// **'Please confirm your password'**
  String get confirmPasswordRequired;

  /// Passwords don't match validation message
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordsDoNotMatch;

  /// Social login section divider
  ///
  /// In en, this message translates to:
  /// **'Or sign in with'**
  String get orSignInWith;

  /// Social register section divider
  ///
  /// In en, this message translates to:
  /// **'Or sign up with'**
  String get orSignUpWith;

  /// Google login button
  ///
  /// In en, this message translates to:
  /// **'Google'**
  String get google;

  /// Facebook login button
  ///
  /// In en, this message translates to:
  /// **'Facebook'**
  String get facebook;

  /// Apple login button
  ///
  /// In en, this message translates to:
  /// **'Continue with Apple'**
  String get apple;

  /// No account prompt
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account? '**
  String get noAccount;

  /// Have account prompt
  ///
  /// In en, this message translates to:
  /// **'Already have an account? '**
  String get haveAccount;

  /// Welcome message with user name
  ///
  /// In en, this message translates to:
  /// **'Welcome, {userName}! 👋'**
  String welcomeUser(String userName);

  /// Welcome message for guest user
  ///
  /// In en, this message translates to:
  /// **'Welcome, Guest! 👋'**
  String get welcomeGuest;

  /// Subtitle on home screen
  ///
  /// In en, this message translates to:
  /// **'Ready to create useful habits?'**
  String get readyToCreateHabits;

  /// Today's habits section title
  ///
  /// In en, this message translates to:
  /// **'Today\'s Habits'**
  String get todaysHabits;

  /// Empty state title
  ///
  /// In en, this message translates to:
  /// **'No habits yet'**
  String get noHabitsYet;

  /// Empty state subtitle
  ///
  /// In en, this message translates to:
  /// **'Create your first habit and start your journey to a better version of yourself!'**
  String get createFirstHabit;

  /// Create habit button
  ///
  /// In en, this message translates to:
  /// **'Create Habit'**
  String get createHabit;

  /// Streak counter label
  ///
  /// In en, this message translates to:
  /// **'days in a row'**
  String get daysInARow;

  /// Completed habits label
  ///
  /// In en, this message translates to:
  /// **'completed'**
  String get completed;

  /// Loading message for login
  ///
  /// In en, this message translates to:
  /// **'Signing in...'**
  String get signingIn;

  /// Loading message for registration
  ///
  /// In en, this message translates to:
  /// **'Creating account...'**
  String get creatingAccount;

  /// General loading message
  ///
  /// In en, this message translates to:
  /// **'Loading data...'**
  String get loadingData;

  /// Profile feature coming soon message
  ///
  /// In en, this message translates to:
  /// **'Profile will be added in the next versions'**
  String get profileComingSoon;

  /// Habits feature coming soon message
  ///
  /// In en, this message translates to:
  /// **'Habit creation will be added in the next versions'**
  String get habitsComingSoon;

  /// Google sign-in coming soon message
  ///
  /// In en, this message translates to:
  /// **'Google sign-in will be added later'**
  String get googleSignInComingSoon;

  /// Facebook sign-in coming soon message
  ///
  /// In en, this message translates to:
  /// **'Facebook sign-in will be added later'**
  String get facebookSignInComingSoon;

  /// Apple sign-in coming soon message
  ///
  /// In en, this message translates to:
  /// **'Apple sign-in will be added later'**
  String get appleSignInComingSoon;

  /// Password recovery coming soon message
  ///
  /// In en, this message translates to:
  /// **'Password recovery will be added later'**
  String get forgotPasswordComingSoon;

  /// Terms and conditions text
  ///
  /// In en, this message translates to:
  /// **'By registering, you agree to the terms of use and privacy policy'**
  String get termsAndConditions;

  /// Generic coming soon message for navigation
  ///
  /// In en, this message translates to:
  /// **'{pageName} will be added in the next versions'**
  String mainWillBeAdded(String pageName);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'ru'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'ru':
      return AppLocalizationsRu();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
