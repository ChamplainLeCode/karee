/// `Karee Core Screen` Library that manages screens in Karee Core
library karee_core.screens;

import 'package:flutter/material.dart' as cupertino;
import '../routes/Router.dart';

/// screens represents the collections of all screens in the
/// karee application.
///
List<Map<Symbol, dynamic>> screens = [];

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
    cupertino.BuildContext context}) {
  var ctx = context; // ?? Router.context;
  switch (mode) {
    case RouteMode.REPLACE:
      cupertino.Navigator.pushReplacementNamed(ctx, name, arguments: parameter);
      break;
    case RouteMode.POP:
      cupertino.Navigator.of(ctx).pop(name);
      break;
    case RouteMode.PUSH:
      cupertino.Navigator.of(ctx).pushNamed(name, arguments: parameter);
      break;
    case RouteMode.EMPTY:
      cupertino.Navigator.of(ctx)
          .pushNamedAndRemoveUntil(name, (_) => false, arguments: parameter);
      break;
    default:
      cupertino.Navigator.of(ctx).pop(false);
  }
}
