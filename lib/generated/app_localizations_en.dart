// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Awakeia - Habit Tracker';

  @override
  String get appName => 'Awakeia';

  @override
  String get appSubtitle => 'Your personal habit tracker';

  @override
  String get back => 'Back';

  @override
  String get home => 'Home';

  @override
  String get habits => 'Habits';

  @override
  String get statistics => 'Statistics';

  @override
  String get profile => 'Profile';

  @override
  String get welcome => 'Welcome!';

  @override
  String get niceToSeeYou => 'Nice to see you!';

  @override
  String get createAccount => 'Create Account';

  @override
  String get startYourJourney =>
      'Start your journey to a better version of yourself!';

  @override
  String get login => 'Sign In';

  @override
  String get register => 'Sign Up';

  @override
  String get continueAsGuest => 'Continue as guest';

  @override
  String get username => 'Username';

  @override
  String get firstName => 'First name';

  @override
  String get emailAddress => 'Email address';

  @override
  String get password => 'Password';

  @override
  String get confirmPassword => 'Confirm password';

  @override
  String get forgotPassword => 'Forgot password?';

  @override
  String get emailRequired => 'Please enter your email';

  @override
  String get emailInvalid => 'Please enter a valid email';

  @override
  String get passwordRequired => 'Please enter your password';

  @override
  String get passwordTooShort => 'Password must contain at least 6 characters';

  @override
  String get confirmPasswordRequired => 'Please confirm your password';

  @override
  String get passwordsDoNotMatch => 'Passwords do not match';

  @override
  String get orSignInWith => 'Or sign in with';

  @override
  String get orSignUpWith => 'Or sign up with';

  @override
  String get google => 'Google';

  @override
  String get facebook => 'Facebook';

  @override
  String get apple => 'Continue with Apple';

  @override
  String get noAccount => 'Don\'t have an account? ';

  @override
  String get haveAccount => 'Already have an account? ';

  @override
  String welcomeUser(String userName) {
    return 'Welcome, $userName! 👋';
  }

  @override
  String get welcomeGuest => 'Welcome, Guest! 👋';

  @override
  String get readyToCreateHabits => 'Ready to create useful habits?';

  @override
  String get todaysHabits => 'Today\'s Habits';

  @override
  String get noHabitsYet => 'No habits yet';

  @override
  String get createFirstHabit =>
      'Create your first habit and start your journey to a better version of yourself!';

  @override
  String get createHabit => 'Create Habit';

  @override
  String get daysInARow => 'days in a row';

  @override
  String get completed => 'completed';

  @override
  String get signingIn => 'Signing in...';

  @override
  String get creatingAccount => 'Creating account...';

  @override
  String get loadingData => 'Loading data...';

  @override
  String get profileComingSoon => 'Profile will be added in the next versions';

  @override
  String get habitsComingSoon =>
      'Habit creation will be added in the next versions';

  @override
  String get googleSignInComingSoon => 'Google sign-in will be added later';

  @override
  String get facebookSignInComingSoon => 'Facebook sign-in will be added later';

  @override
  String get appleSignInComingSoon => 'Apple sign-in will be added later';

  @override
  String get forgotPasswordComingSoon =>
      'Password recovery will be added later';

  @override
  String get termsAndConditions =>
      'By registering, you agree to the terms of use and privacy policy';

  @override
  String mainWillBeAdded(String pageName) {
    return '$pageName will be added in the next versions';
  }
}
