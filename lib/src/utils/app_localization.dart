import 'dart:convert';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'app_language.dart' show AppLanguage;
import '../constances/library.dart' show KareeConstants;
import '../observables/library.dart' show Of;
import '../errors/translation/translation_file_not_exists.dart';

import '../resources/io.dart';

class KareeInternationalization {
  /// Used to know whether Internationalization has be init yet or not.
  /// it preserves framework  for multiple initialization.
  static bool _init = false;

  /// Global Application Localization instance
  /// see [AppLocalization]
  static late Of<AppLocalization> _appLocalization;

  /// ## KareeInternationalization.changeLanguage
  ///
  /// Statically call to change application language. This will automatically
  /// refresh all loaded screens and components of the application
  ///
  static void changeLanguage(Locale locale) {
    AppLocalization._changeLanguage(_appLocalization, locale);
  }

  /// ### @get currentLocale
  /// Get the current locale used in the application
  static Locale? get currentLocale => _appLocalization.value.locale;

  /// ### @get appLocalization
  ///
  /// Retrieve the current AppLocalization observable Object.
  static Of<AppLocalization> get appLocalization => _appLocalization;

  ///
  /// This function is used to initialize appLocalization, this function is call
  /// both in KareeMaterialApp and KareeModule.initialize(). Because
  /// `_appLocalization` is marked as **late** and it's called in two place, then
  /// it's important to avoid `LateInitializationError`, Karee will surrounds it
  /// with try-catch structure
  ///
  static Of<AppLocalization> initAppLocalization() {
    try {
      return KareeInternationalization.appLocalization;
    } catch (e) {
      KareeInternationalization._appLocalization =
          Of.tag(AppLocalization(), KareeConstants.kApplicationLocalizationTag);
      return KareeInternationalization.appLocalization;
    }
  }

  /// Only for internal call. `AppLocalization.init` is a static function used to initialize the appLocalization
  /// instance in Karee framework
  static Future<void> init(Locale? locale, List<Locale> supportedLocale) async {
    if (_init) return;
    KareeInternationalization._appLocalization =
        Of.tag(AppLocalization(), KareeConstants.kApplicationLocalizationTag);
    var appL = KareeInternationalization._appLocalization.value;

    appL._currentLanguage = Of.tag(
        locale == null
            ? AppLanguage.internal()
            : AppLanguage(locale.languageCode),
        KareeConstants.kApplicationLocalizationTag);
    if (locale != null) {
      if (!supportedLocale.contains(locale)) {
        supportedLocale.add(locale);
      }
      appL._currentLanguage!.value = AppLanguage.fromLocale(locale);
      try {
        await appL._readTranslationFile(locale);
        KareeInternationalization._appLocalization.refresh();
      } on FlutterError {
        throw TranslationFileNotExists(locale);
      }
    }
    _init = true;
  }
}

/// ## AppLocalization
/// Class use to better manage internationalization within your Karee Application.
///
class AppLocalization {
  Of<AppLanguage>? _currentLanguage;
  Map<String, dynamic>? translation;

  Locale? get locale => _currentLanguage?.value.locale;

  /// Only for internal call. `AppLocalization._setCurrentLanguage` is the function that
  /// internally, update the current language locale, and propagate the update in
  /// all the application
  static void _changeLanguage(
      Of<AppLocalization> appLObs, Locale locale) async {
    if (appLObs.value._currentLanguage?.value != null) {
      appLObs.value._currentLanguage?.value = AppLanguage.fromLocale(locale);

      await appLObs.value._readTranslationFile(locale);
      appLObs.refresh();
    }
  }

  Future<void> _readTranslationFile(Locale locale) async {
    var path = '''${KareeConstants.kApplicationLocalizationRessourcDir}'''
        '''/${locale.languageCode.toLowerCase()}'''
        '''${locale.countryCode != null ? '_${locale.countryCode!.toLowerCase()}' : ''}.json''';
    String translationString = await loadConfig(path);

    try {
      translation = jsonDecode(translationString);
    } catch (e) {}
  }
}

extension AppLocalizationExtension on AppLocalization {
  Future<void> readModuleTranslationFile(Locale locale, String package) async {
    var path = '''$package'''
        '''${KareeConstants.kApplicationLocalizationRessourcDir}'''
        '''/${locale.languageCode.toLowerCase()}'''
        '''${locale.countryCode != null ? '_${locale.countryCode!.toLowerCase()}' : ''}.json''';
    String translationString = await loadConfig(path);
    try {
      if (translation == null)
        translation = jsonDecode(translationString);
      else
        translation!.addAll(jsonDecode(translationString));
    } catch (e) {}
  }
}
