import '../../routes/router.dart' show RouteMode;

/// NotRoutableWidgetException: Exception thrown when trying to inject a non-routable
/// widget during internal routing.
///
/// see [RoutableWidget]('')
///
/// see [RouterWidget]('')
///
class NotRoutableWidgetException implements Exception {
  /// message of this error
  late String message;

  /// route (path) that thrown this error
  String routerName;

  /// RuntimeType of widget sent
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
/// see [RoutableWidget]('')
///
/// see [RouterWidget]('')
///
/// see [RouteMode]('')
///
class BadUseOfRouterWidgetException implements Exception {
  /// message of this error
  late String message;

  /// route (path) that thrown this error
  Symbol routerName;

  /// RouteMode send during the internal routing
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

/// NotManagableWidgetException: Exception thrown when the application tries to send in navigation an
/// unmanagable Screen to in KareeRouter.
///
/// see [StatefulScreen]('')
///
/// see [StatelessScreen]('./../widgets/StatelessScreen')
///
class NotManageableWidgetException implements Exception {
  /// message of this error
  late final String message;

  /// route (path) that thrown this error
  final dynamic screen;

  NotManageableWidgetException(this.screen) {
    message = '$screen is not a manageable screen';
  }
  @override
  String toString() {
    return 'Exception: NotManagableWidgetException( $message )';
  }
}
