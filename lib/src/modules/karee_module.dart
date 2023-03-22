import 'dart:async' show FutureOr;

import 'package:flutter/material.dart';
import 'package:karee/core.dart';
import 'package:karee/widgets.dart';
import '../../internationalization.dart';

///
/// Interface that should be implemented by every module.
///
abstract class KareeModule {
  ///
  /// This String `Getter` represents the name of the module.
  /// This value represents also the directory and the flutter application name
  /// in the pubspec of the module.
  ///
  String get name;

  ///
  /// This object, is used to keep in memory a reference to all modules of this
  /// karee application.
  ///
  static final Map<String, KareeModule> _modules = {};

  ///
  /// `Getter` of the list of subscribed modules in this application.
  /// The key is the base path of the module.
  /// The value is the module instance.
  ///
  static Map<String, KareeModule> get modules => _modules;

  ///
  /// This `Getter`, is used to know whether the current module should be loaded
  /// during the application startup or late when it will be required.
  ///
  bool get startWithRoot;

  ///
  /// This variable is used to set module as already initialized.
  ///
  bool _isInitialized = false;

  ///
  /// Check whether the module is already initialized.
  ///
  bool get isInitialized => _isInitialized;

  ///
  /// This function is called when the module is being initialized.
  /// We launch a module automaticaly when it's marked as root or
  /// when the application request the module for the first time.
  ///
  @mustCallSuper
  FutureOr<void> initialize() {
    _isInitialized = true;

    var package = 'packages/$name/';
    var obsAppLocalization = KareeInternationalization.initAppLocalization();
    obsAppLocalization.listen((appLocalization) async => await appLocalization
        .readModuleTranslationFile(appLocalization.locale!, package));
    if (KareeMaterialApp.type == KareeApplicationType.application) {
      return obsAppLocalization.value
          .readModuleTranslationFile(obsAppLocalization.value.locale!, package);
    }
  }
}

///
/// Interface implemented by each modules that shares the same Router with the root
/// application.
///
abstract class KareeRoutableModule extends KareeModule {
  /// The module path.
  String get path;

  FutureOr<void> _init() {
    return initialize();
  }
}

///
/// Class used to load a module in the Root application.
///
class KareeModuleLoader {
  ///
  /// Function used to subcribe our module in Karee. It does not means that it
  /// will be immediatly loaded. It will be loaded at same time with the root
  /// application if the [KareeModule.startWithRoot] is set to true.
  /// Otherwise it will be loaded when needed.
  ///
  static FutureOr<void> load<T extends KareeModule>(T e) async {
    if (e is KareeRoutableModule) {
      //////////////////////////////////////////////////////////////////////////
      /// When we ask to load a routable module, we'll init it only if it's the
      /// root module. Otherwise, we'll load it later on navigation fails by filte-
      /// ring by route starts with path.
      //////////////////////////////////////////////////////////////////////////

      KareeModule._modules[e.path] = e;

      if (e.startWithRoot) return await e._init();
    }
  }
}
