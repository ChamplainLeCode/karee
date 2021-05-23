import 'dart:ui';

class AppLanguage {
  Locale locale;

  AppLanguage(String _locale) : locale = Locale(_locale);
  AppLanguage.fromLocale(this.locale);
  @override
  String toString() => 'AppLanguage: $locale';
}
