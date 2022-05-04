import 'package:flutter/material.dart';
import '../../internationalization.dart';

///
/// Interface that should be implements by every module.
///
abstract class KareeModule {
  ///
  /// This String represents the name of the module, this value represents also
  /// the directory and the flutter application name in pubspect of the module
  ///
  String get name;

  ///
  /// This object, is used to keep in memory a reference to all module of this
  /// karee's application.
  ///
  static final Map<String, KareeModule> _modules = {};

  ///
  /// Get the list of subscribed modules in this application,
  /// The key is the base path of the module.
  /// The value is the module instance.
  ///
  static Map<String, KareeModule> get modules => _modules;

  ///
  /// This getter is used to know whether the current module should be loaded
  /// during the application startup or late when it will be required
  ///
  bool get startWithRoot;

  ///
  /// this variable is used to set module as already initialized
  ///
  bool _isInitialized = false;

  ///
  /// Check whether the module is already initialized
  ///
  bool get isInitialized => _isInitialized;

  ///
  /// This function is call when the Module is being initialized.
  /// Whe launch a module automaticaly when it's marked as root or
  /// when application request for the first time.
  ///
  @mustCallSuper
  Future<void> initialize() async {
    _isInitialized = true;
    KareeInternationalization.initAppLocalization().listen((appLocalization) {
      var package = 'packages/$name/';
      appLocalization.readModuleTranslationFile(
          appLocalization.locale!, package);
    });
  }
}

///
/// Interface implemented by each module that share the same Router with the root
/// application
///
abstract class KareeRoutableModule extends KareeModule {
  String get path;

  void _init() {
    initialize();
  }
}

///
/// Class use to load module in Root application
///
class KareeModuleLoader {
  ///
  /// Function used to subcribe our module in Karee. it not means that the
  /// will be immediatly loaded, it will be loaded at same time with the root
  /// application if the [KareeModule.startWithRoot] is set to true, ortherwise
  /// it'll be loaded when needed.
  ///
  static Future<void> load<T extends KareeModule>(T e) async {
    if (e is KareeRoutableModule) {
      //////////////////////////////////////////////////////////////////////////
      /// When we ask to load routable module, we'll init it, only if it's the
      /// root module, otherwise, we'll load later on navigation fails by filte-
      /// ring by route starts with path
      //////////////////////////////////////////////////////////////////////////

      KareeModule._modules[e.path] = e;

      if (e.startWithRoot) return e._init();
    }
  }
}
