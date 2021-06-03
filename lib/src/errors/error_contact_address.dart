import '../widgets/karee_material_app.dart';

import '../constances/enumeration.dart';

/// When you are going to release your application, you need to turn
/// your application profile to production and setup the error contact.
/// You can also customize your application general error screen. And if
/// you need you access to your error contact address use the static variable
/// see [KareeMaterialApp.globalErrorContactAddress]
///
/// see [KareeInstanceProfile]
class ErrorContactAddress {
  /// The version of your application
  final String appVersion;

  /// The name of your application
  final String appName;

  /// The support address that you can provide to your end users
  final String appSupportEmail;

  const ErrorContactAddress(
      {required this.appName,
      required this.appSupportEmail,
      required this.appVersion});
}
