import 'package:flutter/services.dart';

///
/// **loadConfig()** Loads an asset from its path.
///
Future<String> loadConfig(String path) {
  return PlatformAssetBundle().loadString(path);
}

///
/// **checkTranslationFileExists()** Ensure that the translation asset file
/// exists from its path.
///
bool checkTranslationFileExists(String path) {
  try {
    PlatformAssetBundle().loadString(path);
    return true;
  } catch (e) {
    return false;
  }
}
