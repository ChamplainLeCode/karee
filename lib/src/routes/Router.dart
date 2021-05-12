///
/// @Author Champlain Marius Bakop<br>
///
/// @email champlainmarius20@gmail.com
///
/// @github ChamplainLeCode
///
///
/// This library contains the set of tools used to manage navigation
/// in Karee Application
///

library karee_core.route;

import 'package:flutter/cupertino.dart' as cupertino;
import 'package:flutter/material.dart';
import '../constances/constances.dart' show KareeConstants;
import '../errors/errors_solutions.dart' show KareeErrorCode;
import '../errors/exceptions/no_action_found_error.dart';
import '../errors/exceptions/no_route_found_error.dart';
import '../routes/internal_route.dart';
import '../widgets/karee_router_error_widget.dart';
import '../widgets/router_widget.dart';
import '../screens/screens.dart' show screens;
import '../controllers/controller.dart';

///
///

Map<Symbol, RouterWidgetState> _internalRouter = {};

///
/// Notes: Karee provides different ways to navigate between screens. RouteMode helps you to set what kind of navigation policy you want.
///
/// RouteMode.EMPTY. Means that you want to clean navigation before adding current path. Assume that your current navigation path is /settings/user/profile and you want to go back /home, to avoid to remove one by one and push new path, you can use RouteMode.EMPTY,
/// RouteMode.POP: Used to remove current context ( screen ) and return to the previous screen. Assume you are now on the user settings screen ( /settings/user ) and you want to go back to /settings you can call KareeRouter.goBack function with current context (BuildContext) that uses previous constant
/// RouteMode.PUSH: Used to add new navigation context on last one
/// RouteMode.REPLACE: If you want to pop current context and add new one without make two calls KareeRouter.goBack and KareeRouter.goto

enum RouteMode { REPLACE, PUSH, POP, EMPTY, NONE }

///
/// RouteDirection: Not yet implemented, it will be use as screen entry direction
/// during navigation
///
///
enum RouteDirection { LEFT_TO_RIGHT, RIGHT_TO_LEFT, UP_TO_DOWN, DOWN_TO_UP }

///
/// Route: class designed to subscribe events (route) in application.
///
/// Route.on associates the event represented by the path to a specific action .
///
///
class Route {
  static Map<String, dynamic> routeMap = {};

  static void on(String s, dynamic action) {
    assert(action != null);
    routeMap[s] = action;
  }
}

void subscribeRouterWidget(Symbol name, RouterWidgetState state) => _internalRouter[name] = state;

RouterWidgetState? findRouterByName(
  Symbol name,
) {
  if (_internalRouter.containsKey(name)) {
    return _internalRouter[name];
  }
  throw NoActionFoundError('internal Route', name);
}

///
///
void doInternalRouting(Symbol routerName, String screenName, dynamic parameter) {
  try {
    var router = findRouterByName(routerName);

    if (router == null) {
      throw Exception('Unable to find router with name ${routerName.toString()}');
    }
    var widget = screens.firstWhere((routeItem) => routeItem[#name] == screenName)[#screen]?.call();
    final RouteSettings settings = RouteSettings(
      name: screenName,
      arguments: parameter,
    );
    router.load(widget);
  } on StateError catch (e, stack) {
    print(e);
    KareeRouter.goto(KareeConstants.KAREE_ERROR_PATH, parameter: {
      #title: 'No screen found with name $screenName',
      #stack: stack,
      #env: (parameter == null
          ? []
          : parameter is List
              ? parameter
              : [])
        ..reversed.toList()
        ..addAll([screenName, routerName]),
      #errorCode: KareeErrorCode.SCREEN_NOT_FOUND
    });
  } catch (ex, stack) {
    print(ex);
    KareeRouter.goto(KareeConstants.KAREE_ERROR_PATH, parameter: {
      #title: (ex as dynamic).message,
      #stack: stack,
      #env: (parameter == null
          ? []
          : parameter is List
              ? parameter
              : [])
        ..reversed.toList()
        ..addAll([screenName, routerName]),
      #errorCode: KareeErrorCode.NO_ROUTE_FOUND
    });
  }
}

///
/// doRouting: Fonction used to load resource from controller
/// Can be use for application navigation, or to request data.
dynamic doRouting(String control, String method, dynamic params) {
  try {
    var controllerInstance = ControllerReflectable.reflectors[control];
    if (controllerInstance?.hasReflectee ?? false) {
      if (params is List) {
        return controllerInstance?.invoke(method, params);
      } else {
        if (params == null) {
          return controllerInstance?.invoke(method, []);
        }
        return controllerInstance?.invoke(method, [params]);
      }
    }
  } catch (ex, stack) {
    print(ex);
    KareeRouter.goto('__karee_internal__error__', parameter: {
      #title: (ex as dynamic).message,
      #stack: stack,
      #env: (params == null
          ? []
          : params is List
              ? params
              : [])
        ..reversed.toList()
        ..addAll([control, method]),
      #errorCode: KareeErrorCode.NO_ROUTE_FOUND
    });
  }
}

///
/// `KareeRouter`: To navigate between screens you may use KareeRouter that offers you two ways to go forward and to go back
///
/// `KareeRouter.goto( routeName, parameter )`
///
/// `routeName` it is the same path or event defined in the Routes.dart file
/// `parameter` it is the arguments list that should be injected in your Route action
///
/// `KareeRouter.goBack( context )`
///
///
class KareeRouter {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static BuildContext? currentContext;

  static dynamic goto(String routeName, {dynamic parameter}) {
    dynamic action = Route.routeMap[routeName];
    try {
      if (action != null) {
        if (action is Function) {
          if (parameter == null) {
            return action();
          } else
            return action(parameter);
        } else if (action is String) {
          List<String> li = action.split('@');
          if (li.length == 2) {
            String controllerName = li[0];
            String methodName = li[1];
            return doRouting(controllerName, methodName, parameter);
          }
        }
        throw NoActionFoundError(routeName, parameter);
      } else {
        throw NoRouteFoundError(routeName, parameter);
        // cupertino.Navigator.push(ctxt, launchErrorPage);
        // print('No action for this route');
      }
    } catch (e, st) {
      // rethrow;
      if (e is NoActionFoundError) {
        goto(KareeConstants.KAREE_ERROR_PATH, parameter: {
          #title: e.message,
          #stack: st,
          #env: [routeName, parameter],
          #errorCode: KareeErrorCode.NO_ROUTE_FOUND
        });
      } else if (e is NoRouteFoundError) {
        goto(KareeConstants.KAREE_ERROR_PATH, parameter: {
          #title: e.message,
          #stack: st,
          #env: [routeName, if (parameter != null) parameter],
          #errorCode: KareeErrorCode.NO_ROUTE_FOUND
        });
      }
    }
  }

  ///
  /// General router for application. Overload by Karee to override default navigator
  ///
  static get getRouter => (cupertino.RouteSettings rs) {
        return appRoute(rs);
      };
  static cupertino.Route<dynamic> appRoute(cupertino.RouteSettings settings) {
    try {
      return cupertino.PageRouteBuilder(
          settings: settings,
          transitionDuration: Duration(milliseconds: 0),
          pageBuilder: (_, a1, a2) {
            // KareeRouter.currentContext = _;
            return settings.name == null || settings.name == '/'
                ? initialScreen()
                : screens.firstWhere((routeItem) => routeItem[#name] == settings.name)[#screen]?.call();
          });
    } catch (e) {
      return new RouteTransition(
          builder: (_) {
            return cupertino.Center(child: cupertino.Text("No Route found"));
          },
          settings: settings);
    }
  }

  ///
  /// Function used to find initial screen for `/`. screen selected should set
  /// isInitial to `true`
  ///
  static cupertino.Widget initialScreen() {
    try {
      return screens.firstWhere((routeItem) => routeItem[#initial] ?? false)[#screen]?.call();
    } catch (e, st) {
      return KareeRouterErrorWidget('No Initial Screen found', st, KareeErrorCode.NO_INITIAL_SCREEN, [""]);
    }
  }

  ///
  /// This function return the screen view from its name
  ///
  static cupertino.Widget componentForRouteName(String s) {
    try {
      final scr = screens.firstWhere((routeItem) {
        print("\n### Screen name = ${routeItem[#name]}, Widget = $routeItem match ? = $s");
        return routeItem[#name] == s;
      }, orElse: () => {#screen: null})['screen' as Symbol];
      return scr;
    } catch (e, st) {
      return KareeRouterErrorWidget('No Screen found with name `$s`', st, KareeErrorCode.SCREEN_NOT_FOUND, [s]);
    }
  }

  ///
  /// Implementation of navigator to goback to previous context
  ///
  static goBack(
      [@Deprecated("The context is not necessary for this version, and will completely removed in 2.0.1")
          cupertino.BuildContext? context]) {
    if (KareeRouter.navigatorKey.currentState!.canPop()) KareeRouter.navigatorKey.currentState!.pop(true);
  }

  ///
  /// Default Karee Router
  ///
  static router(cupertino.BuildContext context) {
    launchInternalRoute();
    return appRoute;
  }
}

///
/// Default Karee Transition
///
class RouteTransition<T> extends cupertino.CupertinoPageRoute<T> {
  RouteTransition({required cupertino.WidgetBuilder builder, required cupertino.RouteSettings settings})
      : super(builder: builder, settings: settings, maintainState: true);

  @override
  cupertino.Widget buildTransitions(cupertino.BuildContext context, cupertino.Animation<double> animation,
      cupertino.Animation<double> secondaryAnimation, cupertino.Widget child) {
    return new cupertino.CupertinoPageTransition(
        child: child,
        linearTransition: true,
        primaryRouteAnimation: cupertino.CurvedAnimation(
          parent: animation,
          curve: cupertino.Curves.slowMiddle,
          reverseCurve: cupertino.Curves.bounceInOut,
        ),
        secondaryRouteAnimation: cupertino.CurvedAnimation(
          parent: secondaryAnimation,
          curve: cupertino.Curves.slowMiddle,
          reverseCurve: cupertino.Curves.easeInToLinear,
        ));
  }
}
