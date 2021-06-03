import 'dart:ui';

class TranslationFileNotExists implements Exception {
  Locale locale;
  String message;
  TranslationFileNotExists(this.locale)
      : message =
            'Unable to find translation file ${locale.languageCode.toLowerCase()}'
                "${locale.countryCode != null ? '_${locale.countryCode!.toLowerCase()}' : ''}.json";
}
