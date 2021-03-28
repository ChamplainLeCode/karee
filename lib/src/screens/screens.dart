/// `Karee Core Screen` Library that manages screens in Karee Core
library karee_core.screens;

import 'package:flutter/material.dart' as cupertino;
import 'package:karee_core/src/constances/constances.dart' show KareeConstants;
import 'package:karee_core/src/widgets/karee_router_error_widget.dart';
import '../routes/Router.dart';

/// screens represents the collections of all screens in the
/// karee application.
///
List<Map<Symbol, dynamic>> screens = [
  {#name: KareeConstants.KAREE_ERROR_SCREEN_NAME, #screen: () => KareeRouterErrorWidget()}
];

/// subscribeScreen Function: Function use by application to subscribes their
/// screens in core library
///
void subscribeScreen(Map<Symbol, dynamic> screen) => screens.add(screen);

/// screen Function: Function use by core KareeRouter to launch screen on
/// navigate
///
void screen(String name, RouteMode mode,
    {dynamic parameter,
    RouteDirection direction = RouteDirection.LEFT_TO_RIGHT,
    cupertino.BuildContext? context}) {
  switch (mode) {
    case RouteMode.REPLACE:
      KareeRouter.navigatorKey.currentState?.pushReplacementNamed(name, arguments: parameter);
      break;
    case RouteMode.POP:
      KareeRouter.navigatorKey.currentState?.pop(name);
      break;
    case RouteMode.PUSH:
      KareeRouter.navigatorKey.currentState?.pushNamed(name, arguments: parameter);
      break;
    case RouteMode.EMPTY:
      KareeRouter.navigatorKey.currentState?.pushNamedAndRemoveUntil(name, (_) => false, arguments: parameter);
      break;
    default:
      KareeRouter.navigatorKey.currentState?.pop(false);
  }
}
