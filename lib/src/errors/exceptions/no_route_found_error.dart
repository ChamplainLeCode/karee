/// NoRouteFoundError: Exception thrown when the application sent an unknown route (path) in KareeRouter.
///
class NoRouteFoundError implements Exception {
  /// Message of this error.
  String? message;

  /// Route (path) that thrown this error.
  String? routeName;

  /// Environment parameters at this moment.
  dynamic params;

  NoRouteFoundError([this.routeName, this.params]) {
    message = "No Route Found with name $routeName";
  }

  @override
  String toString() {
    return 'Exception: NoRouteFoundException( $message ): with routeName: $routeName and params $params}';
  }
}
