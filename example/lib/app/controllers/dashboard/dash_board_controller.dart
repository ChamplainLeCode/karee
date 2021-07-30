import '../../screens/dashboard/dashboard_resources_screen.dart';
import '../../screens/dashboard/dashboard_routage_screen.dart';
import '../../screens/dashboard/dashboard_screen_screen.dart';
import '../../screens/dashboard/dashboard_services_screen.dart';

import '../../screens/dashboard/dashboard_constants_screen.dart';
import '../../screens/dashboard/dashboard_controllers_screen.dart';
import 'package:karee/annotations.dart';
import 'package:karee/navigation.dart';

import '../../services/user_service.dart';

/// Generated Karee Controller
///
/// `DashBoard` is set as Controller
@Controller
class DashBoardController {
  @Autowired
  late UserService userService;

  void home() {
    screen('dashboard', RouteMode.PUSH);
  }

  void menuScreen() {
    switch (KareeRouter.pathVariables!['menu']) {
      case 'constants':
        constants();
        break;
      case 'controllers':
        controllers();
        break;
      case 'resources':
        resources();
        break;
      case 'routage':
        routage();
        break;
      case 'services':
        services();
        break;
      case 'screen':
        screenTab();
        break;
    }
  }

  void constants() {
    screen(DashboardConstantsScreen(), RouteMode.NONE,
        routerName: #dashboardRouter);
  }

  void controllers() {
    screen(DashboardControllersScreen(), RouteMode.NONE,
        routerName: #dashboardRouter);
  }

  void resources() {
    screen(DashboardResourcesScreen(), RouteMode.NONE,
        routerName: #dashboardRouter);
  }

  void routage() {
    screen(DashboardRoutageScreen(), RouteMode.NONE,
        routerName: #dashboardRouter);
  }

  void services() {
    screen(DashboardServicesScreen(), RouteMode.NONE,
        routerName: #dashboardRouter);
  }

  void screenTab() {
    screen(DashboardScreenTabScreen(), RouteMode.NONE,
        routerName: #dashboardRouter);
  }
}
