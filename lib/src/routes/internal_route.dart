

import 'package:karee_core/src/constances/constances.dart' show KareeConstants;
import 'package:karee_core/src/karee_core.dart';
import 'package:karee_core/src/routes/Router.dart' show Route, RouteMode;

void launchInternalRoute(){
  Route.on(KareeConstants.KAREE_ERROR_PATH, (param) {
    screen(KareeConstants.KAREE_ERROR_SCREEN_NAME, RouteMode.PUSH, parameter: param);
  });
}