import 'package:karee/src/constances/enumeration.dart'
    show KareeApplicationType;
import 'package:karee/src/modules/library.dart';
import 'package:karee/widgets.dart';
import 'package:flutter/widgets.dart';

///
/// This class is used to know whether Root is launched as application or module.
///
class PackageManager {
  ///
  /// Cache used to map Module name by type.
  ///
  // ignore: prefer_final_fields
  static Map<Type, String?> _packageManager = {};

  ///
  /// This function is used to determine whether the widget will be displayed or
  /// not, depending of running mode.
  ///
  /// see [KareeApplicationType]
  ///
  static T? ofWidget<T extends Widget>(T w) =>
      KareeMaterialApp.type != KareeApplicationType.module ? w : null;

  ///
  /// This function is used to get the package name by Module type.
  ///
  /// When loading an asset, we can optionally specify the package name where we
  /// want to retrieve the asset from. We cannot get assets of the current package
  /// with non null value of this property even if it is the current package's
  /// name.
  ///
  /// Running the root Karee project in application mode, means that the
  /// rootBundle refers to the current application, and the resources of modules
  /// should be loaded with the package name value.
  ///
  /// To allow running a module without getting an error on loading resources from
  /// assets, we should know the mode of execution.
  ///
  ///   - In Application Mode:
  ///
  /// To load an image defined in the module named *payment*, we need to specify
  /// the name of the module.
  ///
  /// ```dart
  ///   AssetImage('assets/images/icon_payment.png', package: 'payment');
  /// ```
  ///
  /// When running application in this mode, the rootBundle refers to the
  /// current instance. So we need to set the package to allow the module to
  /// load their own asset ressources.
  ///
  ///   - In Module Mode
  ///
  /// To load an image defined in the current module named *payment*, we don't have
  /// to specify the name of the module. If we do that, it'll mean that we are
  /// looking for resources outside the current package, and we'll get an error:
  /// `unable to load resource from assets`.
  ///
  /// ```dart
  ///   AssetImage('assets/images/icon_payment.png');
  /// ```
  ///
  /// To avoid checking the execution mode, you just need to use `PackageManager.resourceOf()` to
  /// get the right package definition.
  ///
  /// ```dart
  ///   AssetImage('assets/images/icon_payment.png', package: PackageManager.resourceOf<PaymentModule>());
  /// ```
  ///
  static String? resourceOf<T extends KareeModule>() =>
      KareeMaterialApp.type != KareeApplicationType.module
          ? _getModuleName<T>()
          : null;

  static String? _getModuleName<T>() => _packageManager.putIfAbsent(T, () {
        try {
          return KareeModule.modules.values
              .firstWhere((module) => module is T)
              .name;
        } catch (e) {
          return null;
        }
      });
}
