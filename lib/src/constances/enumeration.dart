import 'package:karee/annotations.dart';

///
/// KareeInstanceProfile enumeration used to set the profile of the application
///
/// Application profile is used by Karee to know whether the application is running
/// in dev mode or in prod.
/// ### Development Mode
/// When the dev mode is enabled, developers can get all errors thrown in the application
/// on an UI.
/// ### Production Mode
/// Otherwise when prod mode is enable, that means the applications is used by end
/// users.
///
/// For this reason all error should not been seen buy users.
/// Karee offer to you the possibility
///
/// to override error screen in production. Just add a new Screen in you application, and name
///
/// this one as follow
///
/// ```dart
///   @Screen(KareeConstants.kareeErrorScreenName)
///   class MyErrorScreenInProd extends StatelessScreen{
///
///     Widget builder(BuildContext context){
///       return Scaffold(
///         appBar: AppBar(
///           title: Text('Oups Something Went wrong')
///         ),
///         body: Center(
///           child: BackButton()
///         )
///       );
///     }
///   }
/// ```
/// In addition, you can set contact address of your application and use it everywhere
/// in your application through [KareeMaterialApp.globalErrorContactAddress]('') or get the
/// current profile with [KareeMaterialApp.globalProfile]('')
///
/// See [KareeConstants]('')
///
/// See [KareeMaterialApp]('')

enum KareeInstanceProfile { development, production }

///
/// KareeApplicationType used to know whether the running instance of Karee's
/// instance is application or module
///
enum KareeApplicationType { application, module }

///
/// This enumeration is used to know which kind of application will be run,
/// MaterialApp or CupertinoApp
///
enum ApplicationKind { cupertino, material }

///
/// KareeErrorCode is an enumeration that define all keys associated with a
/// specific widget displayed in Error Screen in dev mode.
///
/// See [KareeInstanceProfile]('')
///
enum KareeErrorCode {
  ///
  ///  Error constant thrown when there is not initial screen in the whole
  ///  application
  ///  
  noInitialScreen,
  ///
  ///  Error constant thrown when routing is done trough screen name, and the 
  ///  screen name is not found
  /// 
  ///  See [Screen]
  ///
  screenNotFound,
  ///
  /// Error constant that specifies some route is triggered and the path represented 
  /// by the string didn't exists
  /// 
  noRouteFound,
  generalError,
  notRoutableWidget,
  notKareeScreen,
  badUseOfRoutableWidget,
  noTranslationFile
}
