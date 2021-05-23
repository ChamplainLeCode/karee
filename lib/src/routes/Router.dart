import 'package:flutter/cupertino.dart' as cupertino;
import 'package:flutter/material.dart';
import 'package:karee_inject/karee_inject.dart' show ControllerReflectable;
import '../errors/exceptions/widget_error.dart';
import '../widgets/library.dart' show StatefulScreen, StatelessScreen;
import '../constances/constances.dart' show KareeConstants;
import '../errors/errors_solutions.dart' show KareeErrorCode;
import '../errors/exceptions/no_action_found_error.dart';
import '../errors/exceptions/no_route_found_error.dart';
import '../routes/internal_route.dart';
import '../widgets/karee_router_error_widget.dart';
import '../widgets/router_widget.dart';
import '../screens/screens.dart' show screen, screens;

///
/// cash of RouterWidget mounted
///
Map<Symbol, RouterWidgetState> _internalRouter = {};

///
/// Notes: Karee provides different ways to navigate between screens. RouteMode helps you to set what kind of navigation policy you want.
///
/// RouteMode.EMPTY. Means that you want to clean navigation before adding current path. Assume that your current navigation path is /settings/user/profile and you want to go back /home, to avoid to remove one by one and push new path, you can use RouteMode.EMPTY,
/// RouteMode.POP: Used to remove current context ( screen ) and return to the previous screen. Assume you are now on the user settings screen ( /settings/user ) and you want to go back to /settings you can call KareeRouter.goBack function with current context (BuildContext) that uses previous constant
/// RouteMode.PUSH: Used to add new navigation context on last one
/// RouteMode.REPLACE: If you want to pop current context and add new one without make two calls KareeRouter.goBack and KareeRouter.goto

enum RouteMode { REPLACE, PUSH, EMPTY, NONE }

///
/// RouteDirection: Not yet implemented, it will be use as screen entry direction
/// during navigation
///
///
enum RouteDirection { LEFT_TO_RIGHT, RIGHT_TO_LEFT, UP_TO_DOWN, DOWN_TO_UP }

typedef RouteActivation = bool Function();

///
/// Route: class designed to subscribe events (route) in application.
///
/// Route.on associates the event represented by the path to a specific action .
///
///
class Route {
  static Map<String, dynamic> _routeMap = {};
  static Map<String, List<dynamic>> _routeWithParams = <String, List<dynamic>>{};
  static Map<RouteActivation, List<String>> _routeActivationMap = {};

  static const String pathVariableGroup = '([0-9a-zA-Z\-_]+)';
  static final RegExp pathVariableRegExp = RegExp(r'{[a-zA-Z0-9\-_]+}');

  static bool defaultRouteActivation() => true;

  static void on(String route, dynamic action, {RouteActivation canActivated = defaultRouteActivation}) {
    assert(action != null && action.toString().isNotEmpty);
    assert(route.isNotEmpty);

    if (route.contains(pathVariableRegExp)) {
      var meta = <dynamic>[action];
      var newPath = route.replaceAllMapped(pathVariableRegExp, (m) {
        meta.add(route.substring(m.start + 1, m.end - 1));
        return pathVariableGroup;
      });
      _routeWithParams[newPath] = meta;
    } else {
      _routeMap[route] = action;
    }
    // routeMap[route] = action;
    if (canActivated != defaultRouteActivation) {
      var routes = _routeActivationMap[canActivated] ?? <String>[];
      routes.add(route);
      _routeActivationMap[canActivated] = routes;
    }
  }
}

/// When a new Router Widget is added in Flutter tree, it is automatically registered
/// available internal router cache
void subscribeRouterWidget(Symbol name, RouterWidgetState state) => _internalRouter[name] = state;

/// When a new Router Widget is removed from Flutter tree, it is automatically unregistered
/// available internal router cache
void unsubscribeRouterWidget(Symbol name, RouterWidgetState state) {
  _internalRouter.removeWhere((key, value) => key == name && value == state);
}

/// Function used to get router from cache buy it name
RouterWidgetState? findRouterByName(
  Symbol name,
) {
  if (_internalRouter.containsKey(name)) {
    return _internalRouter[name];
  }
  throw NoActionFoundError('internal Route', name);
}

///
/// Use to perform internal routing.
///
/// see [RoutableWidget]
/// see [RouterWidget]
void doInternalRouting(Symbol routerName, dynamic screenName, dynamic param) {
  try {
    var router = findRouterByName(routerName);

    if (router == null) {
      throw Exception('Unable to find router with name ${routerName.toString()}');
    }
    if (screenName is String || screenName is cupertino.Widget) {
      var widget;
      if (screenName is Widget) {
        widget = screenName;
      } else {
        widget = screens.firstWhere((routeItem) => routeItem[#name] == screenName)[#screen]?.call();
      }
      if (widget is RoutableWidget) {
        router.load(widget..onParam(param));
        return;
      }

      throw NotRoutableWidgetException(routerName.toString(), widget.runtimeType);
    } else {}
  } on NotRoutableWidgetException catch (e, stack) {
    KareeRouter.goto(KareeConstants.kareeErrorPath, parameter: {
      #title: '${e.message}',
      #stack: stack,
      #env: (param == null
          ? []
          : param is List
              ? param
              : [])
        ..reversed.toList()
        ..addAll([screenName, routerName, e.widgetType]),
      #errorCode: KareeErrorCode.NOT_ROUTABLE_WIDGET
    });
  } on StateError catch (e, stack) {
    print(e);
    KareeRouter.goto(KareeConstants.kareeErrorPath, parameter: {
      #title: 'No screen found with name $screenName',
      #stack: stack,
      #env: (param == null
          ? []
          : param is List
              ? param
              : [])
        ..reversed.toList()
        ..addAll([screenName, routerName]),
      #errorCode: KareeErrorCode.SCREEN_NOT_FOUND
    });
  } catch (ex, stack) {
    print(ex);
    KareeRouter.goto(KareeConstants.kareeErrorPath, parameter: {
      #title: (ex as dynamic).message,
      #stack: stack,
      #env: (param == null
          ? []
          : param is List
              ? param
              : [])
        ..reversed.toList()
        ..addAll([screenName, '#' + routerName.toString().substring(8, routerName.toString().length - 3)]),
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
    KareeRouter.goto(KareeConstants.kareeErrorPath, parameter: {
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
  static final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  static BuildContext? currentContext;
  static String? _currentRoute;
  static Map<String, String>? _pathVariables;
  static dynamic _lastArguments;

  static GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;
  static String? get currentRoute => _currentRoute;
  static Map<String, String>? get pathVariables => _pathVariables;

  static dynamic goto(String routeName, {dynamic parameter}) {
    assert(routeName.isNotEmpty);

    var canActivatedEntry = Route._routeActivationMap.entries.firstWhere((entry) => entry.value.contains(routeName),
        orElse: () => MapEntry(Route.defaultRouteActivation, []));
    if (!canActivatedEntry.key()) {
      /// Route Guard refused access to this routes
      return false;
    }

    KareeRouter._currentRoute = routeName;

    /// We reset path variable for this call Session
    _pathVariables = null;

    dynamic action = findActionFor(routeName);
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
        screen(KareeConstants.kareeErrorPath, RouteMode.PUSH, argument: {
          #title: e.message,
          #stack: st,
          #env: [routeName, parameter],
          #errorCode: KareeErrorCode.NO_ROUTE_FOUND
        });
      } else if (e is NoRouteFoundError) {
        screen(KareeConstants.kareeErrorPath, RouteMode.PUSH, argument: {
          #title: e.message,
          #stack: st,
          #env: [routeName, if (parameter != null) parameter],
          #errorCode: KareeErrorCode.NO_ROUTE_FOUND
        });
      }
    }
  }

  /// Function used to get specific action from a path route.
  ///
  /// This function also setup **KareeRouter.pathVariables** value when the path
  /// represented by this route contains url parameters
  static dynamic findActionFor(String ro) {
    MapEntry<String, dynamic> action =
        Route._routeMap.entries.firstWhere((entry) => entry.key == ro, orElse: () => MapEntry('', null));
    if (action.value == null) {
      var arg = Route._routeWithParams.entries
          .firstWhere((entryParam) => RegExp(entryParam.key).hasMatch(ro), orElse: () => MapEntry('', <String>[]));
      if (arg.value.isNotEmpty) {
        var actionAndPathVar = RegExp(arg.key)
            .allMatches(ro)
            .map((e) => e.groups(List<int>.generate(e.groupCount + 1, (ind) => ind)))
            .firstWhere((element) => true, orElse: () => <String>[]);
        KareeRouter._pathVariables = {};
        for (int i = 1; i < actionAndPathVar.length; i++) {
          KareeRouter._pathVariables!.addEntries([MapEntry(Route._routeWithParams[arg.key]![i], actionAndPathVar[i]!)]);
        }
        return arg.value.first;
      }
      return null;
    }
    return action.value;
  }

  ///
  /// General router for application. Overload by Karee to override default navigator
  ///
  static get getRouter => (cupertino.RouteSettings rs) {
        return appRoute(rs);
      };
  static cupertino.Route<dynamic> appRoute(cupertino.RouteSettings settings) {
    try {
      var widget = settings.name == null || settings.name == '/'
          ? initialScreen()
          : screens.firstWhere((routeItem) => routeItem[#name] == settings.name, orElse: () {
              return {#screen: () => null};
            })[#screen]?.call();
      if (widget == null) {
        throw NoRouteFoundError(settings.name, settings.arguments);
      }

      if (!(widget is StatelessScreen) && !(widget is StatefulScreen) && !(widget is RoutableWidget)) {
        throw NotManagableWidgetException(widget);
      }
      if (settings.arguments != null) {
        KareeRouter._lastArguments = settings.arguments;
      }
      return cupertino.PageRouteBuilder(
          settings: RouteSettings(
              name: KareeRouter.currentRoute, arguments: settings.arguments ?? KareeRouter._lastArguments),
          transitionDuration: Duration(milliseconds: 0),
          pageBuilder: (_, a1, a2) {
            // KareeRouter.currentContext = _;
            return widget;
          });
    } on NoRouteFoundError catch (e, st) {
      KareeRouter._lastArguments = [
        settings.name!,
        KareeRouter.currentRoute!,
        if (settings.arguments != null) settings.arguments.toString()
      ];
      return cupertino.PageRouteBuilder(
          transitionDuration: Duration(milliseconds: 0),
          pageBuilder: (_, a1, a2) => KareeRouterErrorWidget('No screen found with name ${settings.name}', st,
              KareeErrorCode.SCREEN_NOT_FOUND, KareeRouter._lastArguments));
    } on NotManagableWidgetException catch (ex, st) {
      KareeRouter._lastArguments = [
        ex.screen.toString(),
        settings.name!,
        KareeRouter.currentRoute!,
        if (settings.arguments != null) settings.arguments.toString()
      ];
      return cupertino.PageRouteBuilder(
          transitionDuration: Duration(milliseconds: 0),
          pageBuilder: (_, a1, a2) =>
              KareeRouterErrorWidget(ex.message, st, KareeErrorCode.NOT_KAREE_SCREEN, KareeRouter._lastArguments));
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
  static goBack() {
    if (KareeRouter.navigatorKey.currentState!.canPop()) KareeRouter.navigatorKey.currentState!.pop();
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
