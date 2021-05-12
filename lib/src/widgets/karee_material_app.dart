import 'package:flutter/material.dart'
    show
        BuildContext,
        Color,
        ErrorWidget,
        FlutterErrorDetails,
        GenerateAppTitle,
        Intent,
        Key,
        Locale,
        LocaleListResolutionCallback,
        LocaleResolutionCallback,
        LocalizationsDelegate,
        LogicalKeySet,
        MaterialApp,
        NavigatorObserver,
        StatelessWidget,
        ThemeData,
        ThemeMode,
        Widget,
        WidgetBuilder;
import 'package:karee_core/src/errors/error_contact_address.dart';
import 'package:karee_core/src/errors/errors_solutions.dart';
import 'package:karee_core/src/widgets/karee_router_error_widget.dart';
import '../routes/Router.dart' show KareeRouter;
import 'package:karee_core/src/constances/constances.dart' show KareeInstanceProfile;

///
/// @Author Champlain Marius Bakop
/// @Email champlainmarius20@gmail.com
/// @Github ChamplainLeCode
///
///
///
/// KareeMaterialApp simple Material App based on Flutter MaterialApp
/// with custom Router for Karee
///
class KareeMaterialApp extends StatelessWidget {
  final Map<String, WidgetBuilder> routes;
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

  static KareeInstanceProfile? globalProfile;
  static ErrorContactAddress? globalErrorContactAddress;

  KareeMaterialApp(
      {Key? key,
      this.routes = const <String, WidgetBuilder>{},
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
    return MaterialApp(
      key: this.key,
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
  }
}
