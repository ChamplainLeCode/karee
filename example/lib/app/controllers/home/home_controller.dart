import 'package:karee/navigation.dart' show RouteMode, screen;
import 'package:karee/annotations.dart' show Controller;

/*
 * @github ChamplainLeCode
 * 
 */
@Controller
class HomeController {
  void index() {
    screen('home', RouteMode.REPLACE);
  }
}
