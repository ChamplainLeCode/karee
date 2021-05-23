import './constances.dart';

import '../widgets/karee_material_app.dart';

/// KareeInstanceProfile enumeration used to set the profile of the application
///
/// Application profile is used by Karee to know wheter the application is running
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
/// in your application through [KareeMaterialApp.globalErrorContactAddress] or get the
/// current profile with [KareeMaterialApp.globalProfile]('')
///
/// see [KareeConstants]
/// see [KareeMaterialApp]

enum KareeInstanceProfile { development, production }
