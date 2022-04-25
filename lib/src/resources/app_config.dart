import 'io.dart';
import 'package:yaml/yaml.dart';
import '../constances/constances.dart';

late final YamlMap _appConfig;

///
/// Cache of loaded configurations in this application.
///
final Map<String, dynamic> appConfig = {};

///
/// Function used to read [application.yaml]() from resources/config directory.
///
/// the parameter [package] is optionally used to etermine whether the
/// configuration should be load inside a module or not
///
Future<void> loadAppConfig([String package = '']) async {
  var stringConfig =
      await loadConfig(package + KareeConstants.kApplicationRessourceFile);
  try {
    _appConfig = loadYaml(stringConfig);
    _appConfig.forEach((key, value) {
      _loadYamlMap(key, value);
    });
  } catch (e) {
    var newConfig = loadYaml(stringConfig);
    newConfig.forEach((key, value) {
      _loadYamlMap(key, value);
    });
  }
}

///
/// Function that reads value of Yaml node.
///
void _loadYamlMap(String parentKey, Object m) {
  if (m is String)
    appConfig[parentKey] = m;
  else if (m is YamlMap)
    m.forEach((key, value) {
      if (value is num || value is String || value == null) {
        appConfig['$parentKey.$key'] = value;
        return;
      }
      if (value is YamlMap) {
        _loadYamlMap('$parentKey.$key', value);
        return;
      }
      if (value is YamlList) {
        appConfig['$parentKey.$key'] = value.value.toList();
        return;
      }
    });
}

///
/// Function used to read configuration variable from application config in
/// memory.
///
/// This function is used when we inject value via **@Value([variable](''))**
/// where variable is the parameter
///
dynamic readConfig(String variable) {
  assert(variable.startsWith('@{') &&
      variable.endsWith('}') &&
      variable.length > 3);
  var varKey = variable.substring(2, variable.length - 1);
  var value = appConfig[varKey];

  /// String value can contains subvariable
  if (value != null && value is String) {
    var r = RegExp(r"(\@\{[\w\.]+\})");
    r.allMatches(value).map((e) => e.group(0)).toList().forEach((el) {
      value = value.replaceAll(el, readConfig(el!));
    });
  }
  return value;
}
