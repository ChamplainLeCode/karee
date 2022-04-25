import 'dart:ui';

///
/// Exception thrown when trying to  apply translation by loading dictionary
/// file by locale name.
///
class TranslationFileNotExists implements Exception {
  Locale locale;
  String message;
  TranslationFileNotExists(this.locale)
      : message =
            'Unable to find translation file ${locale.languageCode.toLowerCase()}'
                "${locale.countryCode != null ? '_${locale.countryCode!.toLowerCase()}' : ''}.json";
}
