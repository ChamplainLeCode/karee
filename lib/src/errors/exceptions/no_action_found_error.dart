

class NoActionFoundError implements Exception{

  String? message, routeName;

  dynamic? params;


  NoActionFoundError([this.routeName, this.params]){
    this.message = 'No Action Found For Route';
  }

  String toString(){
    return 'Exception: NoActionException( $message ): with routeName: $routeName and params $params}';
  }
  
}