import '../constances/constances.dart' show KareeConstants;
import 'router.dart' show Route, RouteMode;
import '../screens/library.dart' show screen;

void launchInternalRoute() {
  Route.on(KareeConstants.kareeErrorPath, (param) {
    screen(KareeConstants.kareeErrorScreenName, RouteMode.PUSH, argument: param);
  });
}
