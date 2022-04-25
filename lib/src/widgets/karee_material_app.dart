import 'package:flutter/cupertino.dart';
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
        // LocalizationsDelegate,
        LogicalKeySet,
        MaterialApp,
        NavigatorObserver,
        ScaffoldMessengerState,
        StatelessWidget,
        ThemeData,
        ThemeMode,
        Widget,
        WidgetBuilder;
import 'package:karee/src/constances/enumeration.dart';
import '../constances/constances.dart';
import '../errors/translation/translation_file_not_exists.dart';
import '../utils/app_localization.dart';
import '../errors/library.dart';
import '../routes/router.dart' show KareeRouter;
import '../constances/enumeration.dart'
    show
        KareeInstanceProfile,
        KareeApplicationType,
        KareeErrorCode,
        ApplicationKind;
import '../observables/library.dart' show Of, Observer;
import 'karee_router_error_widget.dart';

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
  final CupertinoThemeData? cupertinoTheme;
  final ThemeData? darkTheme;
  final ThemeMode themeMode;
  final Color? color;
  final Locale? locale;
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

  /// Set of observables that can be watched in all the application.
  ///
  /// see [Of]
  ///
  /// see [Observer]
  final List<Of> observables;

  /// Global Application profile on execution
  ///
  /// see [KareeInstanceProfile]
  static KareeInstanceProfile? globalProfile;

  ///
  /// Global Application type
  ///
  static KareeApplicationType type = KareeApplicationType.application;

  /// Global Application Contact address
  /// see [ErrorContactAddress]
  static ErrorContactAddress? globalErrorContactAddress;

  ///
  /// Kind of applicatoin
  ///
  final ApplicationKind kind;
  final Map<Type, Action<Intent>>? actions;

  final ThemeData? highContrastDarkTheme;

  final ThemeData? highContrastTheme;

  final GlobalKey<ScaffoldMessengerState>? scaffoldMessengerKey;

  final String? restorationScopeId;

  KareeMaterialApp(
      {Key? key,
      required this.kind,
      this.restorationScopeId,
      this.scaffoldMessengerKey,
      this.navigatorObservers = const <NavigatorObserver>[],
      this.title = '',
      this.onGenerateTitle,
      this.color,
      this.cupertinoTheme,
      this.theme,
      this.darkTheme,
      this.themeMode = ThemeMode.system,
      this.locale,
      this.localeListResolutionCallback,
      this.localeResolutionCallback,
      this.supportedLocales = const <Locale>[],
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
      required this.observables,
      this.errorContactAddress}) {
    assert(profile == KareeInstanceProfile.development ||
        (profile == KareeInstanceProfile.production &&
            errorContactAddress != null));
    KareeMaterialApp.globalProfile = profile;
    KareeMaterialApp.globalErrorContactAddress = errorContactAddress;
    KareeInternationalization.init(this.locale, this.supportedLocales.toList())
        .catchError((onError, st) {
      var ex = onError as TranslationFileNotExists;

      KareeRouter.goto(KareeConstants.kareeErrorPath, parameter: {
        #title: ex.message,
        #stack: st,
        #env: [
          '${ex.locale.languageCode}${ex.locale.countryCode == null ? '' : '_${ex.locale.countryCode!.toLowerCase()}'}.json',
        ],
        #errorCode: KareeErrorCode.NO_TRANSLATION_FILE
      });
    }, test: (exception) => exception is TranslationFileNotExists);

    ErrorWidget.builder = (FlutterErrorDetails detail) {
      return KareeRouterErrorWidget(
          detail.summary.name,
          detail.stack,
          KareeErrorCode.GENERAL_ERROR,
          detail.context!.getChildren().map((e) => e.name ?? '').toList());
    };
  }

  @override
  Widget build(BuildContext context) {
    return Observer.withProviders(
        providers: observables..add(KareeInternationalization.appLocalization),
        child: (ctx) {
          return Observer.on<AppLocalization>(
              tag: KareeConstants.kApplicationLocalizationTag,
              builder: (_, lang) {
                if (this.kind == ApplicationKind.cupertino) {
                  return CupertinoApp(
                    actions: this.actions,
                    restorationScopeId: this.restorationScopeId,
                    key: this.key,
                    navigatorKey: KareeRouter.navigatorKey,
                    navigatorObservers: this.navigatorObservers,
                    title: this.title,
                    routes: const <String, WidgetBuilder>{},
                    onGenerateTitle: this.onGenerateTitle,
                    color: this.color,
                    theme: this.cupertinoTheme,
                    localeListResolutionCallback:
                        this.localeListResolutionCallback,
                    localeResolutionCallback: this.localeResolutionCallback,
                    debugShowCheckedModeBanner: this.debugShowCheckedModeBanner,
                    showPerformanceOverlay: this.showPerformanceOverlay,
                    checkerboardRasterCacheImages:
                        this.checkerboardRasterCacheImages,
                    checkerboardOffscreenLayers:
                        this.checkerboardOffscreenLayers,
                    showSemanticsDebugger: this.showSemanticsDebugger,
                    shortcuts: this.shortcuts,
                    onGenerateRoute: KareeRouter.router(context),
                  );
                }
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
                    localeListResolutionCallback:
                        this.localeListResolutionCallback,
                    localeResolutionCallback: this.localeResolutionCallback,
                    debugShowMaterialGrid: this.debugShowMaterialGrid,
                    showPerformanceOverlay: this.showPerformanceOverlay,
                    checkerboardRasterCacheImages:
                        this.checkerboardRasterCacheImages,
                    checkerboardOffscreenLayers:
                        this.checkerboardOffscreenLayers,
                    showSemanticsDebugger: this.showSemanticsDebugger,
                    debugShowCheckedModeBanner: this.debugShowCheckedModeBanner,
                    shortcuts: this.shortcuts,
                    onGenerateRoute: KareeRouter.router(context));
              });
        });
  }
}
