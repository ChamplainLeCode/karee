import 'dart:convert';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:karee_core/core.dart' show AppLanguage, KareeConstants, Of;
import 'package:karee_core/src/errors/translation/translation_file_not_exists.dart';

import '../resources/io.dart';

class AppLocalization {
  Of<AppLanguage>? _currentLanguage;
  Map<String, dynamic>? translation;

  Locale? get locale => _currentLanguage?.value.locale;

  static Future<AppLocalization> init(Locale? locale, List<Locale> supportedLocale) async {
    var appL = AppLocalization();

    appL._currentLanguage =
        Of.tag(AppLanguage.fromLocale(locale ?? Locale('')), KareeConstants.kApplicationLocalizationTag);
    if (locale != null) {
      if (!supportedLocale.contains(locale)) {
        supportedLocale.add(locale);
      }
      appL._currentLanguage!.value = AppLanguage.fromLocale(locale);
      try {
        await appL._readTranslationFile(locale);
      } on FlutterError catch (e) {
        throw TranslationFileNotExists(locale);
      }
    }
    return appL;
  }

  static void setCurrentLanguage(Of<AppLocalization> appLObs, Locale locale) async {
    // assert(locale.languageCode != appLObs.value._currentLanguage?.value.locale.languageCode &&
    //     locale.countryCode != appLObs.value._currentLanguage?.value.locale.countryCode);
    if (appLObs.value._currentLanguage?.value != null) {
      appLObs.value._currentLanguage?.value = AppLanguage.fromLocale(locale);

      await appLObs.value._readTranslationFile(locale);
      appLObs.refresh();
    }
  }

  Future<void> _readTranslationFile(Locale locale) async {
    String translationString = await loadConfig('${KareeConstants.kApplicationLocalizationRessourcDir}'
        '/${locale.languageCode.toLowerCase()}'
        "${locale.countryCode != null ? '_${locale.countryCode!.toLowerCase()}' : ''}.json");
    try {
      translation = jsonDecode(translationString);
    } catch (e) {}
  }
}
