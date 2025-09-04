import 'dart:convert';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:karee/navigation.dart';
import 'app_language.dart' show AppLanguage;
import '../constances/library.dart' show KareeConstants, KareeErrorCode;
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
  static Of<AppLocalization>? _appLocalization;

  /// This is used to enable or disable i18n in Karee.
  /// If set to `true`, Karee will load the translation file from the
  /// resources/i18n directory.
  /// If set to `false`, Karee will not load any translation file and will not
  /// apply any translation.
  /// This is useful for applications that do not require internationalization.
  /// If you want to use i18n, set this to `true` in your
  /// `KareeMaterialApp` or `KareeModule` initialization.
  /// Default is `false`.
  ///
  static bool i18n = false;

  /// ## KareeInternationalization.changeLanguage
  ///
  /// Statically call this function to change application language.
  /// This will automatically refresh all loaded screens and components of the
  /// application.
  ///
  static void changeLanguage(Locale locale) {
    AppLocalization._changeLanguage(_appLocalization!, locale);
  }

  /// ### @get currentLocale
  /// Get the current locale used in the application.
  static Locale? get currentLocale => _appLocalization!.value.locale;

  /// ### @get appLocalization
  ///
  /// Retrieve the current AppLocalization observable Object.
  static Of<AppLocalization> get appLocalization => _appLocalization!;

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
  static Future<void> init(Locale locale, List<Locale> supportedLocale,
      [bool enableI18n = false]) async {
    if (_init) return;
    KareeInternationalization.i18n = enableI18n;
    KareeInternationalization._appLocalization =
        Of.tag(AppLocalization(), KareeConstants.kApplicationLocalizationTag);
    var appL = KareeInternationalization._appLocalization!.value;

    appL._currentLanguage = Of.tag(AppLanguage(locale.toLanguageTag()),
        KareeConstants.kApplicationLocalizationTag);
    if (!supportedLocale.contains(locale)) {
      supportedLocale.add(locale);
    }
    appL._currentLanguage!.value = AppLanguage.fromLocale(locale);
    try {
      if (enableI18n) {
        await appL._readTranslationFile(locale);
        KareeInternationalization._appLocalization!.refresh();
      } else {
        appL.translation = {};
      }
    } on FlutterError {
      throw TranslationFileNotExists(locale);
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
        '''/${locale.toLanguageTag()}.json''';

    try {
      String translationString = await loadConfig(path);
      translation = jsonDecode(translationString);
    } catch (e) {
      _handleTranslationFileNotExists(locale, path, e as Error);
    }
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
        '''/${locale.toLanguageTag()}.json''';
    try {
      String translationString = await loadConfig(path);
      if (translation == null) {
        translation = jsonDecode(translationString);
      } else {
        translation!.addAll(jsonDecode(translationString));
      }
    } catch (e) {
      _handleTranslationFileNotExists(locale, path, e as Error);
    }
  }

  _handleTranslationFileNotExists(Locale locale, String path, Error ex) {
    KareeRouter.goto(KareeConstants.kareeErrorPath, parameter: {
      #title: ex.toString().split('.').first,
      #stack: ex.stackTrace,
      #env: [
        '${locale.languageCode}${locale.countryCode == null ? '' : '_${locale.countryCode!.toLowerCase()}'}.json',
      ],
      #errorCode: KareeErrorCode.noTranslationFile
    });
  }
}

extension BooleanStateExtension on bool {
  /// Returns the opposite of the current boolean value.
  bool get not => !this;

  /// Returns true if the current boolean value is true, otherwise false.
  bool get isTrue => this;

  /// Returns true if the current boolean value is false, otherwise false.
  bool get isFalse => !this;

  /// Returns true if the current boolean value is enabled, otherwise false.
  bool get isEnabled => this;

  /// Returns true if the current boolean value is disabled, otherwise false.
  bool get isDisabled => !this;

  /// Returns true if the current boolean value is active, otherwise false.
  bool get isActive => this;

  /// Returns true if the current boolean value is inactive, otherwise false.
  bool get isInactive => !this;

  /// Returns true if the current boolean value is checked, otherwise false.
  bool get isChecked => this;

  /// Returns true if the current boolean value is unchecked, otherwise false.
  bool get isUnchecked => !this;

  /// Returns true if the current boolean value is visible, otherwise false.
  bool get isVisible => this;

  /// Returns true if the current boolean value is hidden, otherwise false.
  bool get isHidden => !this;

  /// Returns true if the current boolean value is selected, otherwise false.
  bool get isSelected => this;

  /// Returns true if the current boolean value is unselected, otherwise false.
  bool get isUnselected => !this;
}
