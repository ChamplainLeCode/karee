import '../../routes/router.dart' show RouteMode;

/// NotRoutableWidgetException: Exception thrown when trying to inject a non-routable
/// widget during internal routing.
///
/// See [RoutableWidget]('')
///
/// See [RouterWidget]('')
///
class NotRoutableWidgetException implements Exception {
  /// Message of this error.
  late String message;

  /// Route (path) that thrown this error.
  String routerName;

  /// RuntimeType of the widget sent.
  Type widgetType;

  NotRoutableWidgetException(this.routerName, this.widgetType) {
    message = "${widgetType.toString()} is not subType of RoutableWidget";
  }

  @override
  String toString() {
    return 'Exception: NotRoutableWidgetException( $message )';
  }
}

/// BadUseOfRouterWidgetException: Exception thrown when a inappropriate RouteMode is used with Internal Routing.
///
/// See [RoutableWidget]('')
///
/// See [RouterWidget]('')
///
/// See [RouteMode]('')
///
class BadUseOfRouterWidgetException implements Exception {
  /// Message of this error.
  late String message;

  /// Route (path) that thrown this error.
  Symbol routerName;

  /// RouteMode sent during the internal routing.
  RouteMode mode;

  BadUseOfRouterWidgetException(this.routerName, this.mode) {
    message =
        'Cannot use $mode with #${routerName.toString().substring(8, routerName.toString().length - 2)}';
  }

  @override
  String toString() {
    return 'Exception: BadUseOfRouterWidgetException( $message )';
  }
}

/// NotManagableWidgetException: Exception thrown when the application tries to send in navigation, an
/// unmanagable Screen to the KareeRouter.
///
/// see [StatefulScreen]('')
///
/// see [StatelessScreen]('./../widgets/StatelessScreen')
///
class NotManageableWidgetException implements Exception {
  /// Message of this error.
  late final String message;

  /// Route (path) that thrown this error.
  final dynamic screen;

  NotManageableWidgetException(this.screen) {
    message = '$screen is not a manageable screen';
  }
  @override
  String toString() {
    return 'Exception: NotManagableWidgetException( $message )';
  }
}
