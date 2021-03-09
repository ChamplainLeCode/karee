///
/// `Karee Core Widget` Library for all important widgets
///
library karee_core.widget;

import 'package:flutter/material.dart'
    show
        StatelessWidget,
        GlobalKey,
        NavigatorState,
        WidgetBuilder,
        NavigatorObserver,
        GenerateAppTitle,
        ThemeData,
        ThemeMode,
        Color,
        Locale,
        LocalizationsDelegate,
        LocaleListResolutionCallback,
        LocaleResolutionCallback,
        LogicalKeySet,
        Intent,
        Key,
        Widget,
        BuildContext,
        MaterialApp;
import '../routes/Router.dart' show KareeRouter;

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
  final GlobalKey<NavigatorState> navigatorKey;
  final Map<String, WidgetBuilder> routes;
  final List<NavigatorObserver> navigatorObservers;
  final String title;
  final GenerateAppTitle onGenerateTitle;
  final ThemeData theme;
  final ThemeData darkTheme;
  final ThemeMode themeMode;
  final Color color;
  final Locale locale;
  final Iterable<LocalizationsDelegate<dynamic>> localizationsDelegates;
  final LocaleListResolutionCallback localeListResolutionCallback;
  final LocaleResolutionCallback localeResolutionCallback;
  final Iterable<Locale> supportedLocales;
  final bool showPerformanceOverlay;
  final bool checkerboardRasterCacheImages;
  final bool checkerboardOffscreenLayers;
  final bool showSemanticsDebugger;
  final bool debugShowCheckedModeBanner;
  final Map<LogicalKeySet, Intent> shortcuts;
  final bool debugShowMaterialGrid;

  const KareeMaterialApp(
      {Key key,
      this.navigatorKey,
      this.routes = const <String, WidgetBuilder>{},
      //  this.onUnknownRoute,
      this.navigatorObservers = const <NavigatorObserver>[],
      //this.builder,
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
      this.shortcuts});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      key: this.key,
      navigatorKey: this.navigatorKey,
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
