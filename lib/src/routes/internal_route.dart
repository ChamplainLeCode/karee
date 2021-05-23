import 'package:karee_core/src/constances/constances.dart' show KareeConstants;
import 'package:karee_core/src/karee_core.dart';
import 'package:karee_core/src/routes/Router.dart' show Route, RouteMode;

void launchInternalRoute() {
  Route.on(KareeConstants.kareeErrorPath, (param) {
    screen(KareeConstants.kareeErrorScreenName, RouteMode.PUSH, argument: param);
  });
}
