class NoRouteFoundError implements Exception{

  String? message, routeName;

  dynamic? params;

  NoRouteFoundError([this.routeName, this.params]){
    this.message = "No Route Found";
    
  }


  String toString(){
    return 'Exception: NoRouteFoundException( $message ): with routeName: $routeName and params $params}';
  }
}