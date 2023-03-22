import 'package:flutter_test/flutter_test.dart';
import 'package:karee/navigation.dart';
import 'package:karee/annotations.dart'
    show Autowired, Controller, KareeInjector, Service;

@Service
class MyService {}

@Controller
class MyController {
  static MyController instance = KareeInjector.instance<MyController>()!;
  @Autowired
  late MyService myService;
  int add(a, b) => a + b;
  Future<int> addAsync(a, b) async =>
      Future.delayed(Duration(seconds: 5), () => a + b);
}

void main() {
  setUp(() {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  group('Router test -> ', () {
    setUp(() {});
    test('Controller Souscription in Framework', () {
      var noController = KareeInjector.instance<MyController>();
      KareeInjector.provide(MyController());
      var myController = KareeInjector.instance<MyController>();
      expect(noController, null);
      expect(myController, isNot(null));
    });

    test('Route souscription/consumption through Controller', () async {
      KareeInjector.provide(MyController());
      Route.on('/test/controller/sync/add', MyController.instance.add);
      Route.on('/test/controller/async/add', MyController.instance.addAsync);
      var a = 0x50, b = 50;
      expect(KareeRouter.goto('/test/controller/sync/add', parameter: [a, b]),
          130);
      expect(
          await KareeRouter.goto('/test/controller/async/add',
              parameter: [b, a]),
          130);
    });

    test('Route souscription/consumption through Function', () async {
      Route.on('/test/function/sync/add', (a) => a * 30);
      Route.on('/test/function/async/add',
          (a) async => Future.delayed(Duration(seconds: 3), () => a / 2));
      var a = 30, b = 50;
      expect(KareeRouter.goto('/test/function/sync/add', parameter: a), 900);
      expect(
          await KareeRouter.goto('/test/function/async/add', parameter: b), 25);
      expect(
          await KareeRouter.goto('/test/function/async/add', parameter: b), 25);
    });
  });
}
