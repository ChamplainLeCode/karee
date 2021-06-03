import 'dart:ui';

class AppLanguage {
  Locale? locale;

  AppLanguage(String _locale) : locale = Locale(_locale);
  AppLanguage.fromLocale(this.locale);
  AppLanguage.internal();
  @override
  String toString() => 'AppLanguage: $locale';
}
