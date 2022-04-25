/// NoRouteFoundError: Exception thrown when the application send an unknow route (path) in KareeRouter.
///
class NoRouteFoundError implements Exception {
  /// message of this error
  String? message;

  /// route (path) that thrown this error
  String? routeName;

  /// Environment parameters at this moment
  dynamic params;

  NoRouteFoundError([this.routeName, this.params]) {
    this.message = "No Route Found with name $routeName";
  }

  String toString() {
    return 'Exception: NoRouteFoundException( $message ): with routeName: $routeName and params $params}';
  }
}
