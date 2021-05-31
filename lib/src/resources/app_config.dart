import 'io.dart';
import 'package:yaml/yaml.dart';
import '../constances/constances.dart';

late final YamlMap _appConfig;
final Map<String, dynamic> appConfig = {};

Future<void> loadAppConfig() async {
  var stringConfig = await loadConfig(KareeConstants.kApplicationRessourceFile);
  _appConfig = loadYaml(stringConfig);
  _appConfig.forEach((key, value) {
    _loadYamlMap(key, value);
  });
}

void _loadYamlMap(String parentKey, YamlMap m) {
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

dynamic readConfig(String variable) {
  assert(variable.startsWith('@{') && variable.endsWith('}') && variable.length > 3);
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
