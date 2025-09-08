// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'Awakeia - Трекер привычек';

  @override
  String get appName => 'Awakeia';

  @override
  String get appSubtitle => 'Твой персональный трекер привычек';

  @override
  String get back => 'Назад';

  @override
  String get home => 'Главная';

  @override
  String get habits => 'Привычки';

  @override
  String get statistics => 'Статистика';

  @override
  String get profile => 'Профиль';

  @override
  String get welcome => 'Добро пожаловать!';

  @override
  String get niceToSeeYou => 'Рады тебя видеть!';

  @override
  String get createAccount => 'Создать аккаунт';

  @override
  String get startYourJourney => 'Начни путь к лучшей версии себя!';

  @override
  String get login => 'Войти';

  @override
  String get register => 'Регистрация';

  @override
  String get continueAsGuest => 'Продолжить как гость';

  @override
  String get username => 'Введите username';

  @override
  String get firstName => 'Ваше имя';

  @override
  String get emailAddress => 'Email адрес';

  @override
  String get password => 'Пароль';

  @override
  String get confirmPassword => 'Подтвердите пароль';

  @override
  String get forgotPassword => 'Забыли пароль?';

  @override
  String get emailRequired => 'Введите email';

  @override
  String get emailInvalid => 'Введите корректный email';

  @override
  String get passwordRequired => 'Введите пароль';

  @override
  String get passwordTooShort => 'Пароль должен содержать минимум 6 символов';

  @override
  String get confirmPasswordRequired => 'Подтвердите пароль';

  @override
  String get passwordsDoNotMatch => 'Пароли не совпадают';

  @override
  String get orSignInWith => 'Или войти с помощью';

  @override
  String get orSignUpWith => 'Или зарегистрироваться с помощью';

  @override
  String get google => 'Google';

  @override
  String get facebook => 'Facebook';

  @override
  String get apple => 'Продолжить с Apple';

  @override
  String get noAccount => 'Нет аккаунта? ';

  @override
  String get haveAccount => 'Уже есть аккаунт? ';

  @override
  String welcomeUser(String userName) {
    return 'Добро пожаловать, $userName! 👋';
  }

  @override
  String get welcomeGuest => 'Добро пожаловать, Гость! 👋';

  @override
  String get readyToCreateHabits => 'Готов создавать полезные привычки?';

  @override
  String get todaysHabits => 'Сегодняшние привычки';

  @override
  String get noHabitsYet => 'Пока привычек нет';

  @override
  String get createFirstHabit =>
      'Создай свою первую привычку и начни путь к лучшей версии себя!';

  @override
  String get createHabit => 'Создать привычку';

  @override
  String get daysInARow => 'дней подряд';

  @override
  String get completed => 'выполнено';

  @override
  String get signingIn => 'Выполняется вход...';

  @override
  String get creatingAccount => 'Создание аккаунта...';

  @override
  String get loadingData => 'Загрузка данных...';

  @override
  String get profileComingSoon => 'Профиль будет добавлен в следующих версиях';

  @override
  String get habitsComingSoon =>
      'Создание привычек будет добавлено в следующих версиях';

  @override
  String get googleSignInComingSoon => 'Вход через Google будет добавлен позже';

  @override
  String get facebookSignInComingSoon =>
      'Вход через Facebook будет добавлен позже';

  @override
  String get appleSignInComingSoon => 'Вход через Apple будет добавлен позже';

  @override
  String get forgotPasswordComingSoon =>
      'Функция восстановления пароля будет добавлена позже';

  @override
  String get termsAndConditions =>
      'Регистрируясь, вы соглашаетесь с условиями использования и политикой конфиденциальности';

  @override
  String mainWillBeAdded(String pageName) {
    return '$pageName будет добавлено в следующих версиях';
  }
}
