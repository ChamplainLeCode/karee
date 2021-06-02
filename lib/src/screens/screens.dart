import 'package:flutter/material.dart' as cupertino;
import 'package:flutter/widgets.dart';
import '../widgets/screen_widget.dart';
import '../widgets/router_widget.dart';
import '../constances/constances.dart' show KareeConstants;
import '../errors/errors_solutions.dart';
import '../errors/exceptions/widget_error.dart';
import '../widgets/karee_router_error_widget.dart';
import '../routes/router.dart';

/// screens represents the collections of all screens in the
/// karee application.
///
List<Map<Symbol, dynamic>> screens = [
  {#name: KareeConstants.kareeErrorScreenName, #screen: () => KareeRouterErrorWidget()}
];

/// subscribeScreen Function: Function use by application to subscribes their
/// screens in core library
///
void subscribeScreen(Map<Symbol, dynamic> screen) => screens.add(screen);

/// screen Function: Function use by core KareeRouter to launch screen on
/// navigate
///
void screen(dynamic screen, RouteMode mode,
    {dynamic argument,
    Symbol? routerName,
    RouteDirection direction = RouteDirection.LEFT_TO_RIGHT,
    cupertino.BuildContext? context}) {
  try {
    var isString = screen is String,
        isStls = screen is StatelessScreen,
        isStfs = screen is StatefulScreen,
        isRoutable = screen is RoutableWidget;
    if (!(isString || isStls || isStfs || isRoutable)) {
      throw NotManageableWidgetException(screen);
    }
    print(
        'ty Is manageableWidget = ${!(screen is String || screen is StatelessScreen || screen is StatefulScreen || screen is RoutableWidget)}');
    if (routerName != null && mode != RouteMode.NONE) {
      throw BadUseOfRouterWidgetException(routerName, mode);
    }

    /// Internal Routing using RouterWidget
    if (routerName != null) {
      doInternalRouting(routerName, screen, argument);
      return;
    }
    switch (mode) {
      case RouteMode.REPLACE:
        if (screen is String) {
          KareeRouter.navigatorKey.currentState?.pushReplacementNamed(screen, arguments: argument);
        } else {
          var settings = RouteSettings(arguments: argument, name: KareeRouter.currentRoute);
          KareeRouter.navigatorKey.currentState
              ?.pushReplacement(cupertino.MaterialPageRoute(builder: (_) => screen, settings: settings));
        }
        break;
      case RouteMode.PUSH:
        if (screen is String) {
          KareeRouter.navigatorKey.currentState?.pushNamed(screen, arguments: argument);
        } else {
          var settings = RouteSettings(arguments: argument, name: KareeRouter.currentRoute);
          KareeRouter.navigatorKey.currentState
              ?.push(cupertino.MaterialPageRoute(builder: (_) => screen, settings: settings));
        }
        break;
      case RouteMode.EMPTY:
        if (screen is String) {
          KareeRouter.navigatorKey.currentState?.pushNamedAndRemoveUntil(screen, (_) => false, arguments: argument);
        } else {
          var settings = RouteSettings(
            name: KareeRouter.currentRoute,
            arguments: argument,
          );
          KareeRouter.navigatorKey.currentState?.pushAndRemoveUntil(
              cupertino.MaterialPageRoute(builder: (_) => screen, settings: settings), (route) => false);
        }
        break;
      default:
        KareeRouter.navigatorKey.currentState?.pop(false);
    }
  } on NotManageableWidgetException catch (ex, st) {
    KareeRouter.goto(KareeConstants.kareeErrorPath, parameter: {
      #title: ex.message,
      #stack: st,
      #env: [screen, KareeRouter.currentRoute!, mode, argument],
      #errorCode: KareeErrorCode.NOT_KAREE_SCREEN
    });
  } on BadUseOfRouterWidgetException catch (ex, st) {
    KareeRouter.goto(KareeConstants.kareeErrorPath, parameter: {
      #title: ex.message,
      #stack: st,
      #env: [
        '#${routerName.toString().substring(8, routerName.toString().length - 2)}',
        mode,
        KareeRouter.currentRoute!,
        argument
      ],
      #errorCode: KareeErrorCode.BAD_USE_OF_ROUTABLE_WIDGET
    });
  }
}
