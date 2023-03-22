import 'dart:convert';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'app_language.dart' show AppLanguage;
import '../constances/library.dart' show KareeConstants;
import '../observables/library.dart' show Of;
import '../errors/translation/translation_file_not_exists.dart';

import '../resources/io.dart';

///
/// `KareeInternationalization`: Class that provides internationalization for
/// your Karee applications.
///
class KareeInternationalization {
  /// Used to know whether Internationalization has been init yet or not.
  /// It preserves frameworks for multiple initializations.
  static bool _init = false;

  /// Global Application Localization instance.
  /// See [AppLocalization]
  static late Of<AppLocalization> _appLocalization;

  /// ## KareeInternationalization.changeLanguage
  ///
  /// Statically call this function to change application language.
  /// This will automatically refresh all loaded screens and components of the
  /// application.
  ///
  static void changeLanguage(Locale locale) {
    AppLocalization._changeLanguage(_appLocalization, locale);
  }

  /// ### @get currentLocale
  /// Get the current locale used in the application.
  static Locale? get currentLocale => _appLocalization.value.locale;

  /// ### @get appLocalization
  ///
  /// Retrieve the current AppLocalization observable Object.
  static Of<AppLocalization> get appLocalization => _appLocalization;

  ///
  /// This function is used to initialize appLocalization. This function is
  /// called both in KareeMaterialApp and KareeModule.initialize(). Because
  /// `_appLocalization` is marked as **late** and is called in two places,
  /// it's important to avoid `LateInitializationError`. Karee will surround it
  /// with a try-catch structure.
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

  /// Only for internal call. `AppLocalization.init` is a static function used
  /// to initialize the appLocalization instance in Karee framework.
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
/// Class used to better manage internationalization within your Karee
/// Application.
///
class AppLocalization {
  Of<AppLanguage>? _currentLanguage;
  Map<String, dynamic>? translation;

  /// `Getter` of the current application locale.
  Locale? get locale => _currentLanguage?.value.locale;

  /// Only for internal call. `AppLocalization._changeLanguage` is the function
  /// that internally updates the current language locale, and propagate the
  /// update in all the application.
  static void _changeLanguage(
      Of<AppLocalization> appLObs, Locale locale) async {
    if (appLObs.value._currentLanguage?.value != null) {
      appLObs.value._currentLanguage?.value = AppLanguage.fromLocale(locale);

      await appLObs.value._readTranslationFile(locale);
      appLObs.refresh();
    }
  }

  /// **_readTranslationFile()** Permits to load the content of the matching
  /// translation file asset from a given locale.
  Future<void> _readTranslationFile(Locale locale) async {
    var path = '''${KareeConstants.kApplicationLocalizationRessourcDir}'''
        '''/${locale.languageCode.toLowerCase()}'''
        '''${locale.countryCode != null ? '_${locale.countryCode!.toLowerCase()}' : ''}.json''';
    String translationString = await loadConfig(path);

    try {
      translation = jsonDecode(translationString);
      // ignore: empty_catches
    } catch (e) {}
  }
}

/// `AppLocalizationExtension`: Provides a set of methods compatible to
/// AppLocalization objects, and hence can be applied on them.
///
extension AppLocalizationExtension on AppLocalization {
  /// **readModuleTranslationFile()** Permits to load the content of the
  /// matching translation file asset from a given locale of a module.
  Future<void> readModuleTranslationFile(Locale locale, String package) async {
    var path = '''$package'''
        '''${KareeConstants.kApplicationLocalizationRessourcDir}'''
        '''/${locale.languageCode.toLowerCase()}'''
        '''${locale.countryCode != null ? '_${locale.countryCode!.toLowerCase()}' : ''}.json''';
    String translationString = await loadConfig(path);
    try {
      if (translation == null) {
        translation = jsonDecode(translationString);
      } else {
        translation!.addAll(jsonDecode(translationString));
      }
      // ignore: empty_catches
    } catch (e) {}
  }
}
