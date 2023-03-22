import '../constances/constances.dart' show KareeConstants;
import 'router.dart' show Route, RouteMode;
import '../screens/library.dart' show screen;

///
/// Load internal route used inside of Karee.
///
/// The unique route known inside Karee is the error path. This is used in prod
/// mode when a runTime error happens.
///
void launchInternalRoute() {
  Route.on(KareeConstants.kareeErrorPath, (param) {
    screen(KareeConstants.kareeErrorScreenName, RouteMode.PUSH,
        argument: param);
  });
}
