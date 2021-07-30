import 'package:karee/navigation.dart' show Route;

/*
 * By Karee
 * 
 */
void registeredRoute() {
  Route.on('/', 'HomeController@index');
  Route.on('/dashboard', 'DashBoardController@home');
  Route.on('/dashboard/{menu}', 'DashBoardController@menuScreen');
}
