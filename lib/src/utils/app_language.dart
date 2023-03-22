import 'dart:ui';

///
/// AppLanguage: defines the model of current language for internationalization.
///
class AppLanguage {
  /// The application current locale.
  Locale? locale;

  AppLanguage(String _locale) : locale = Locale(_locale);

  /// Function to get the application language from the current app locale.
  AppLanguage.fromLocale(this.locale);
  AppLanguage.internal();
  @override
  String toString() => 'AppLanguage: $locale';
}
