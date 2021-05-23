import 'dart:ui';

import 'src/utils/app_localization.dart';
import 'widgets.dart';

extension StringTranslator on String {
  String translate() {
    return KareeMaterialApp.appLocalization.value.translation?[this]?.toString() ?? this;
  }

  String translateWithParams(Map<String, String> params) {
    String self = KareeMaterialApp.appLocalization.value.translation?[this]?.toString() ?? this;
    for (var entryParam in params.entries) {
      self = self.replaceAll('{${entryParam.key}}', entryParam.value);
    }

    return self;
  }
}

class KareeInternationalization {
  static void changeLanguage(Locale locale) {
    AppLocalization.setCurrentLanguage(KareeMaterialApp.appLocalization, locale);
  }
}
