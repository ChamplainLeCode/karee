import 'package:flutter/foundation.dart';
import 'package:karee/widgets.dart' show StatefulScreen, StatelessScreen;

import './enumeration.dart';

///
/// Class that defines all managed constants used in karee.
///
class KareeConstants {
  /// Karee error Screen's name.
  ///
  /// To overwrite default kareeScreen in production mode, you may create a
  /// screen [StatelessScreen] or [StatefulScreen] with this constant as name.
  ///
  /// See also [KareeInstanceProfile].
  static const String kareeErrorScreenName = '__karee_internal_error_widget__';

  /// Karee github repository.
  static const String kareeGithub = 'https://github.com/ChamplainLeCode/karee';

  /// Name of the path when an error occurs.
  static const String kareeErrorPath = '__karee_internal__error__';

  /// This is the location of the application config file.
  static final String kApplicationRessourceFile =
      'resources${kIsWeb ? '/' : platformSeparator}config${kIsWeb ? '/' : platformSeparator}application.yaml';

  /// This is the location of the i18n directory.
  static final String kApplicationLocalizationRessourcDir =
      'resources${kIsWeb ? '/' : platformSeparator}i18n';

  /// Default tag used to maintain the instance of current localization in karee.
  static const Symbol kApplicationLocalizationTag = #base;

  /// Platform specific file separator.
  /// This is used to build paths in a platform agnostic way.
  /// For web, the separator is always '/'.
  /// For Windows, the separator is '\'.
  /// For other platforms, the separator is '/'.
  /// This is used to build paths in a platform agnostic way.
  /// See also [kApplicationRessourceFile] and [kApplicationLocalizationRessourcDir]
  static get platformSeparator {
    if (kIsWeb) {
      return '/';
    }
    if (defaultTargetPlatform == TargetPlatform.windows) {
      return '\\';
    }
    return '/';
  }

  /// Private constructor to avoid external instantiation.
  KareeConstants._();
}
