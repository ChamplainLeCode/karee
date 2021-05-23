import 'package:flutter/material.dart'
    show
        Action,
        BuildContext,
        Color,
        ErrorWidget,
        FlutterErrorDetails,
        GenerateAppTitle,
        GlobalKey,
        Intent,
        Key,
        Locale,
        LocaleListResolutionCallback,
        LocaleResolutionCallback,
        LocalizationsDelegate,
        LogicalKeySet,
        MaterialApp,
        NavigatorObserver,
        ScaffoldMessengerState,
        StatelessWidget,
        ThemeData,
        ThemeMode,
        Widget,
        WidgetBuilder;
import '../errors/library.dart';
import '../widgets/library.dart';
import '../routes/Router.dart' show KareeRouter;
import '../constances/library.dart' show KareeInstanceProfile;
import '../observables/library.dart' show Of, Observer;

///
/// ### KareeMaterialApp
///
/// Simple Material App based on Flutter MaterialApp
/// with custom configuration for Karee
///
class KareeMaterialApp extends StatelessWidget {
  final List<NavigatorObserver> navigatorObservers;
  final String title;
  final GenerateAppTitle? onGenerateTitle;
  final ThemeData? theme;
  final ThemeData? darkTheme;
  final ThemeMode themeMode;
  final Color? color;
  final Locale? locale;
  final Iterable<LocalizationsDelegate<dynamic>>? localizationsDelegates;
  final LocaleListResolutionCallback? localeListResolutionCallback;
  final LocaleResolutionCallback? localeResolutionCallback;
  final Iterable<Locale> supportedLocales;
  final bool showPerformanceOverlay;
  final bool checkerboardRasterCacheImages;
  final bool checkerboardOffscreenLayers;
  final bool showSemanticsDebugger;
  final bool debugShowCheckedModeBanner;
  final Map<LogicalKeySet, Intent>? shortcuts;
  final bool debugShowMaterialGrid;
  final KareeInstanceProfile profile;
  final ErrorContactAddress? errorContactAddress;

  /// Set of observables that can be what in all the application.
  ///
  /// see [Of]
  ///
  /// see [Observer]
  final List<Of> observables;

  /// Global Application profile on execution
  ///
  /// see [KareeInstanceProfile]
  static KareeInstanceProfile? globalProfile;

  /// Global Application Contact address
  /// see [ErrorContactAddress]
  static ErrorContactAddress? globalErrorContactAddress;

  final Map<Type, Action<Intent>>? actions;

  final ThemeData? highContrastDarkTheme;

  final ThemeData? highContrastTheme;

  final GlobalKey<ScaffoldMessengerState>? scaffoldMessengerKey;

  final String? restorationScopeId;

  KareeMaterialApp(
      {Key? key,
      this.restorationScopeId,
      this.scaffoldMessengerKey,
      this.navigatorObservers = const <NavigatorObserver>[],
      this.title = '',
      this.onGenerateTitle,
      this.color,
      this.theme,
      this.darkTheme,
      this.themeMode = ThemeMode.system,
      this.locale,
      this.localizationsDelegates,
      this.localeListResolutionCallback,
      this.localeResolutionCallback,
      this.supportedLocales = const <Locale>[Locale('en', 'US')],
      this.debugShowMaterialGrid = false,
      this.showPerformanceOverlay = false,
      this.checkerboardRasterCacheImages = false,
      this.checkerboardOffscreenLayers = false,
      this.showSemanticsDebugger = false,
      this.debugShowCheckedModeBanner = true,
      this.shortcuts,
      this.profile = KareeInstanceProfile.development,
      this.actions,
      this.highContrastDarkTheme,
      this.highContrastTheme,
      this.observables = const <Of>[],
      this.errorContactAddress}) {
    assert(profile == KareeInstanceProfile.development ||
        profile == KareeInstanceProfile.production && errorContactAddress != null);

    KareeMaterialApp.globalProfile = profile;
    KareeMaterialApp.globalErrorContactAddress = errorContactAddress;
  }

  @override
  Widget build(BuildContext context) {
    ErrorWidget.builder = (FlutterErrorDetails detail) {
      return KareeRouterErrorWidget(detail.summary.name, detail.stack, KareeErrorCode.NO_ROUTE_FOUND,
          detail.context!.getChildren().map((e) => e.name ?? '').toList());
    };
    return Observer.withProviders(
        providers: observables,
        child: (ctx) {
          print('\n################### PROVIDERS CHANGED $observables');
          return MaterialApp(
            highContrastDarkTheme: this.highContrastDarkTheme,
            highContrastTheme: highContrastTheme,
            restorationScopeId: this.restorationScopeId,
            scaffoldMessengerKey: this.scaffoldMessengerKey,
            key: this.key,
            actions: this.actions,
            navigatorKey: KareeRouter.navigatorKey,
            navigatorObservers: this.navigatorObservers,
            title: this.title,
            routes: const <String, WidgetBuilder>{},
            onGenerateTitle: this.onGenerateTitle,
            color: this.color,
            theme: this.theme,
            darkTheme: this.darkTheme,
            themeMode: this.themeMode,
            locale: this.locale,
            localizationsDelegates: this.localizationsDelegates,
            localeListResolutionCallback: this.localeListResolutionCallback,
            localeResolutionCallback: this.localeResolutionCallback,
            supportedLocales: this.supportedLocales,
            debugShowMaterialGrid: this.debugShowMaterialGrid,
            showPerformanceOverlay: this.showPerformanceOverlay,
            checkerboardRasterCacheImages: this.checkerboardRasterCacheImages,
            checkerboardOffscreenLayers: this.checkerboardOffscreenLayers,
            showSemanticsDebugger: this.showSemanticsDebugger,
            debugShowCheckedModeBanner: this.debugShowCheckedModeBanner,
            shortcuts: this.shortcuts,
            onGenerateRoute: KareeRouter.router(context),
          );
        });
  }
}
