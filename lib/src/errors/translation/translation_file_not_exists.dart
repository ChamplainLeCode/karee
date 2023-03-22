import 'dart:ui';

///
/// Exception thrown when trying to apply a translation by loading a dictionary
/// file by locale name.
///
/// See [Locale]
///
class TranslationFileNotExists implements Exception {
  /// The desired locale.
  Locale locale;

  /// Message of this error.
  String message;
  TranslationFileNotExists(this.locale)
      : message =
            'Unable to find translation file ${locale.languageCode.toLowerCase()}'
                "${locale.countryCode != null ? '_${locale.countryCode!.toLowerCase()}' : ''}.json";
}
