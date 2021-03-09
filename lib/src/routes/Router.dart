///
/// @Author Champlain Marius Bakop
/// @email champlainmarius20@gmail.com
/// @github ChamplainLeCode
///
///
/// This library contains the set of tools used to manage navigation
/// in Karee Application
///

library karee_core.route;

import 'package:flutter/cupertino.dart' as cupertino;
import '../screens/screens.dart' show screens;
import '../controllers/controller.dart';

///
/// Notes: Karee provides different ways to navigate between screens. RouteMode helps you to set what kind of navigation policy you want.
///
/// RouteMode.EMPTY. Means that you want to clean navigation before adding current path. Assume that your current navigation path is /settings/user/profile and you want to go back /home, to avoid to remove one by one and push new path, you can use RouteMode.EMPTY,
/// RouteMode.POP: Used to remove current context ( screen ) and return to the previous screen. Assume you are now on the user settings screen ( /settings/user ) and you want to go back to /settings you can call KareeRouter.goBack function with current context (BuildContext) that uses previous constant
/// RouteMode.PUSH: Used to add new navigation context on last one
/// RouteMode.REPLACE: If you want to pop current context and add new one without make two calls KareeRouter.goBack and KareeRouter.goto

enum RouteMode { REPLACE, PUSH, POP, EMPTY }

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
    assert(s != null && action != null);
    routeMap[s] = action;
  }
}

///
/// doRouting: Fonction used to load resource from controller
/// Can be use for application navigation, or to request data.
doRouting(String control, String method, dynamic params) {
  try {
    if (ControllerReflectable.reflectors[control].hasReflectee) {
      if (params is List) {
        return ControllerReflectable.reflectors[control].invoke(method, params);
      } else {
        if (params == null) {
          return ControllerReflectable.reflectors[control].invoke(method, []);
        }
        return ControllerReflectable.reflectors[control]
            .invoke(method, [params]);
      }
    }
  } catch (ex, stack) {
    print(ex);
    print(stack);
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
  static cupertino.BuildContext context;

  static dynamic goto(String routeName, {dynamic parameter}) {
    dynamic action = Route.routeMap[routeName];
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
    } else {
      print('No action for this route');
    }
  }

  ///
  /// General router for application. Overload by Karee to override default navigator
  ///
  static get getRouter => (cupertino.RouteSettings rs) => appRoute(rs);

  static cupertino.Route<dynamic> appRoute(cupertino.RouteSettings settings) {
    try {
      return cupertino.PageRouteBuilder(
          settings: settings,
          transitionDuration: Duration(milliseconds: 400),
          pageBuilder: (_, a1, a2) => settings.name == null ||
                  settings.name == '/'
              ? initialScreen()
              : screens
                  .firstWhere(
                      (routeItem) => routeItem[#name] == settings.name)[#screen]
                  ?.call());
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
    return screens
        .firstWhere((routeItem) => routeItem[#initial] ?? false)[#screen]
        ?.call();
  }

  ///
  /// This function return the screen view from its name
  ///
  static cupertino.Widget componentForRouteName(String s) =>
      screens.firstWhere((routeItem) => routeItem[#name] == s)['screen'];

  ///
  /// Implementation of navigator to goback to previous context
  ///
  static goBack(cupertino.BuildContext context) {
    cupertino.Navigator.of(context).pop(true);
  }

  ///
  /// Default Karee Router
  ///
  static router(cupertino.BuildContext context) {
    KareeRouter.context = context;
    return appRoute;
  }
}

///
/// Default Karee Transition
///
class RouteTransition<T> extends cupertino.CupertinoPageRoute<T> {
  RouteTransition(
      {cupertino.WidgetBuilder builder, cupertino.RouteSettings settings})
      : super(builder: builder, settings: settings, maintainState: true);

  @override
  cupertino.Widget buildTransitions(
      cupertino.BuildContext context,
      cupertino.Animation<double> animation,
      cupertino.Animation<double> secondaryAnimation,
      cupertino.Widget child) {
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
