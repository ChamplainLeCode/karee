/// NoActionFoundError: Exception thrown when an unknown action is mapped to a route.
///
class NoActionFoundError implements Exception {
  /// message of this error
  String? message;

  /// route (path) that thrown this error
  String? routeName;

  /// Environment parameters at this moment
  dynamic params;

  NoActionFoundError([this.routeName, this.params]) {
    message = 'No Action Found For Route';
  }

  @override
  String toString() {
    return 'Exception: NoActionException( $message ): with routeName: $routeName and params $params}';
  }
}
