import 'package:flutter/services.dart';

Future<String> loadConfig(String path) {
  return PlatformAssetBundle().loadString(path);
}

bool checkTranslationFileExists(String path) {
  try {
    PlatformAssetBundle().loadString(path);
    return true;
  } catch (e) {
    return false;
  }
}
