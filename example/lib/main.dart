import 'package:flutter/material.dart';
import 'package:karee/widgets.dart';
import 'package:karee/core.dart';
import 'core/core.dart';

///
/// @Author **Champlain Marius Bakop**
///
/// @Email [champlainmarius20@gmail.com](mailto://champlainmarius20@hotmail.com)
///
/// @Github [ChamplainLeCode](https://github.com/ChamplainLeCode)
///

void main() async {
  // Do not modify
  await initCore();
  runApp(MyKareeApp());

  //! Add your custom configurations
  ///
  /// To stuck your app in portrait
  ///
  // await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
}

class MyKareeApp extends StatelessWidget {
  /// general observable for our app
  final sideMenuSelected = Of.tag(0, #sideMenu);

  @override
  Widget build(BuildContext context) {
    // Don't change this widget

    return KareeMaterialApp(
        kind: ApplicationKind.material,
        locale: Locale('fr'),
        supportedLocales: [Locale('en')],
        observables: [sideMenuSelected],

        /// This is the profile of your application on production
        /// replace KareeInstanceProfile.production by KareeInstanceProfile.development
        /// during development, to better manage error in your application
        profile: KareeInstanceProfile.development,

        /// When you are going to release your application, you need to turn
        /// your application profile to production and setup the error contact.
        /// You can also customize your application general error screen. And if
        /// you need you access to your error contact address use the static variable
        /// KareeMaterialApp.globalErrorContactAddress
        errorContactAddress: ErrorContactAddress(
          appName: 'Karee Sample App',
          appSupportEmail: 'champlainmarius20@gmail.com',
          appVersion: 'v9.0.3',
        ),
        // locale: Locale('en'),
        // supportedLocales: [Locale('en'), Locale('fr')],
        // This represents your app's title
        title: 'Karee Sample App',
        debugShowCheckedModeBanner: false);
  }
}
