///
/// KareeInstanceProfile enumeration used to set the profile of the application.
///
/// Application profile is used by Karee to know whether the application is running
/// in dev mode or in prod.
/// ### Development Mode
/// When the dev mode is enabled, developers can get all errors thrown in the application,
/// through a UI.
/// ### Production Mode
/// Otherwise, when prod mode is enable, that means the application is used by end
/// users.
///
/// For this reason, all errors should not be seen by users.
/// Karee offers to you the possibility
///
/// to override the error screen in production. Just add a new Screen in your application, and name
///
/// this one as follows:
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
/// In addition, you can set the contact address of your application and use it everywhere
/// in your application through [KareeMaterialApp.globalErrorContactAddress]('') or get the
/// current profile with [KareeMaterialApp.globalProfile]('').
///
/// See [KareeConstants]('')
///
/// See [KareeMaterialApp]('')

enum KareeInstanceProfile { development, production }

///
/// KareeApplicationType used to know whether the running instance of Karee's
/// instance is an application or a module.
///
enum KareeApplicationType { application, module }

///
/// This enumeration is used to know which kind of application will be ran,
/// MaterialApp or CupertinoApp.
///
enum ApplicationKind { cupertino, material }

///
/// KareeErrorCode is an enumeration that define all keys associated with a
/// specific widget displayed in the Error Screen in dev mode.
///
/// See [KareeInstanceProfile]('')
///
enum KareeErrorCode {
  noInitialScreen,
  screenNotFound,
  noRouteFound,
  generalError,
  notRoutableWidget,
  notKareeScreen,
  badUseOfRoutableWidget,
  noTranslationFile
}
