import 'dart:io';

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
/// with custom configuration for Karee.
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

  /// Global Application profile on execution.
  ///
  /// see [KareeInstanceProfile]
  static KareeInstanceProfile? globalProfile;

  ///
  /// Global Application type.
  ///
  static KareeApplicationType type = KareeApplicationType.application;

  /// Global Application Contact address.
  /// see [ErrorContactAddress]
  static ErrorContactAddress? globalErrorContactAddress;

  ///
  /// Kind of application.
  ///
  final ApplicationKind kind;

  /// Actions that can be used in the application.
  /// see [Action]
  /// see [Intent]
  /// see [LogicalKeySet]
  final Map<Type, Action<Intent>>? actions;

  /// High contrast dark theme for the application.
  /// see [ThemeData.highContrastDarkTheme]
  final ThemeData? highContrastDarkTheme;

  /// High contrast theme for the application.
  /// see [ThemeData.highContrastDarkTheme]
  final ThemeData? highContrastTheme;

  /// Key to access the ScaffoldMessengerState of the application.
  /// see [ScaffoldMessengerState]
  /// see [GlobalKey]
  final GlobalKey<ScaffoldMessengerState>? scaffoldMessengerKey;

  /// Restoration ID to save and restore the state of the application.
  /// See [RestorationScope] for more information.

  final String? restorationScopeId;

  /// Constructor of KareeMaterialApp
  ///
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
      bool enableI18n = false,
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
    KareeMaterialApp.$assert(
        profile == KareeInstanceProfile.development ||
            (profile == KareeInstanceProfile.production &&
                errorContactAddress != null),
        'If you use KareeInstanceProfile.production, you must provide an error contact address.',
        [
          'profile: $profile',
          'errorContactAddress: ${errorContactAddress?.toString() ?? 'null'}'
        ]);
    KareeMaterialApp.$assert(
        (enableI18n && (locale != null || supportedLocales.isNotEmpty)) ||
            (!enableI18n && locale == null && supportedLocales.isEmpty),
        'If you enable i18n, you must provide a locale or a list of supported locales.',
        [
          'enableI18n: $enableI18n',
          'locale: ${locale?.toLanguageTag()}',
          'supportedLocales: ${supportedLocales.toString()}'
        ],
        KareeErrorCode.enableI18nError);
    KareeMaterialApp.globalProfile = profile;
    KareeMaterialApp.globalErrorContactAddress = errorContactAddress;
    KareeInternationalization.init(locale ?? Locale(Platform.localeName),
            supportedLocales.toList(), enableI18n)
        .catchError((onError, st) {
      var ex = onError as TranslationFileNotExists;

      KareeRouter.goto(KareeConstants.kareeErrorPath, parameter: {
        #title: ex.message,
        #stack: st,
        #env: [
          '${ex.locale.languageCode}${ex.locale.countryCode == null ? '' : '_${ex.locale.countryCode!.toLowerCase()}'}.json',
        ],
        #errorCode: KareeErrorCode.noTranslationFile
      });
    }, test: (exception) => exception is TranslationFileNotExists);

    // uncomment for testing
    // if (!Platform.environment.containsKey('FLUTTER_TEST')) {
    ErrorWidget.builder = (FlutterErrorDetails detail) {
      return KareeRouterErrorWidget(
          detail.summary.name,
          detail.stack,
          KareeErrorCode.generalError,
          detail.context!.getChildren().map((e) => e.name ?? '').toList());
    };
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Observer.withProviders(
        providers: observables..add(KareeInternationalization.appLocalization),
        child: (ctx) {
          return Observer.on<AppLocalization>(
              tag: KareeConstants.kApplicationLocalizationTag,
              builder: (_, lang) {
                if (kind == ApplicationKind.cupertino) {
                  return CupertinoApp(
                    actions: actions,
                    restorationScopeId: restorationScopeId,
                    key: key,
                    navigatorKey: KareeRouter.navigatorKey,
                    navigatorObservers: navigatorObservers,
                    title: title,
                    routes: const <String, WidgetBuilder>{},
                    onGenerateTitle: onGenerateTitle,
                    color: color,
                    theme: cupertinoTheme,
                    localeListResolutionCallback: localeListResolutionCallback,
                    localeResolutionCallback: localeResolutionCallback,
                    debugShowCheckedModeBanner: debugShowCheckedModeBanner,
                    showPerformanceOverlay: showPerformanceOverlay,
                    checkerboardRasterCacheImages:
                        checkerboardRasterCacheImages,
                    checkerboardOffscreenLayers: checkerboardOffscreenLayers,
                    showSemanticsDebugger: showSemanticsDebugger,
                    shortcuts: shortcuts,
                    onGenerateRoute: KareeRouter.router(context),
                  );
                }
                return MaterialApp(
                    highContrastDarkTheme: highContrastDarkTheme,
                    highContrastTheme: highContrastTheme,
                    restorationScopeId: restorationScopeId,
                    scaffoldMessengerKey: scaffoldMessengerKey,
                    key: key,
                    actions: actions,
                    navigatorKey: KareeRouter.navigatorKey,
                    navigatorObservers: navigatorObservers,
                    title: title,
                    routes: const <String, WidgetBuilder>{},
                    onGenerateTitle: onGenerateTitle,
                    color: color,
                    theme: theme,
                    darkTheme: darkTheme,
                    themeMode: themeMode,
                    localeListResolutionCallback: localeListResolutionCallback,
                    localeResolutionCallback: localeResolutionCallback,
                    debugShowMaterialGrid: debugShowMaterialGrid,
                    showPerformanceOverlay: showPerformanceOverlay,
                    checkerboardRasterCacheImages:
                        checkerboardRasterCacheImages,
                    checkerboardOffscreenLayers: checkerboardOffscreenLayers,
                    showSemanticsDebugger: showSemanticsDebugger,
                    debugShowCheckedModeBanner: debugShowCheckedModeBanner,
                    shortcuts: shortcuts,
                    onGenerateRoute: KareeRouter.router(context));
              });
        });
  }

  ///
  /// Karee assert function that will check a condition and if false
  /// will redirect to the Karee error screen with the provided message
  /// and environment.
  ///
  static void $assert(bool condition, String message,
      [List<String> env = const [],
      KareeErrorCode errorCode = KareeErrorCode.assertionError]) {
    if (!condition) {
      KareeRouter.goto(KareeConstants.kareeErrorPath, parameter: {
        #title: message,
        #stack: StackTrace.current,
        #env: env,
        #errorCode: errorCode
      });
    }
  }
}
