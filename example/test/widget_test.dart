import 'package:example/main.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/container.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:karee/annotations.dart';
import 'package:karee/navigation.dart';
import 'package:karee/widgets.dart';

@Controller
class MyController {
  static MyController instance = KareeInjector.instance<MyController>()!;

  void dashboard() => screen(MyDashboard(), RouteMode.PUSH);
  Widget myHome() => MyHome();
}

class MyHome extends StatelessScreen {
  MyHome({Key? key});

  @override
  Widget builder(BuildContext context) {
    return Container();
  }
}

class MyDashboard extends StatelessScreen {
  MyDashboard({Key? key});

  @override
  Widget builder(BuildContext context) {
    return Container();
  }
}

/*
 * @Author Champlain Marius Bakop
 * @Email champlainmarius20@gmail.com
 * @Github ChamplainLeCode
 * 
 */
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('Karee Material App test', () {
    setUp(() {
      KareeInjector.provide(MyController());
      Route.on('/', MyController.instance.myHome);
      Route.on('/dashboard', MyController.instance.dashboard);
    });

    testWidgets('KareeRouter.goBack()', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(MyKareeApp());
      expect(find.byType(MyHome), findsOneWidget);
      KareeRouter.goto('/dashboard');
      KareeRouter.goBack();
      await tester.pumpAndSettle();
      expect(find.byType(MyDashboard), findsNothing);
      expect(find.byType(MyHome), findsOneWidget);
    });

    testWidgets('KareeRouter.goto()', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(MyKareeApp());
      expect(find.byType(MyHome), findsOneWidget);
      KareeRouter.goto('/dashboard');
      await tester.pumpAndSettle();
      expect(find.byType(MyDashboard), findsOneWidget);
      expect(find.byType(MyHome), findsNothing);
    });
  });
}
