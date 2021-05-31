import 'src/utils/app_localization.dart';
export 'src/utils/app_language.dart';
export 'src/utils/app_localization.dart';

extension StringTranslator on String {
  String translate() {
    return KareeInternationalization.appLocalization.value.translation?[this]?.toString() ?? this;
  }

  String translateWithParams(Map<String, String> params) {
    String self = KareeInternationalization.appLocalization.value.translation?[this]?.toString() ?? this;
    for (var entryParam in params.entries) {
      self = self.replaceAll('\${${entryParam.key}}', entryParam.value);
    }

    return self;
  }
}
